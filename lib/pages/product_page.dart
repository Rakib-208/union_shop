import 'package:flutter/material.dart';
import 'package:union_shop/widgets/footer.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/widgets/app_header.dart'; // FIX: shared Product model
import 'package:union_shop/models/cart.dart';

class ProductPage extends StatefulWidget {
  // FIX: product is now passed in so this page can show real data
  final Product product;

  const ProductPage({
    super.key,
    required this.product,
  });

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  // FIX: hold a reference to the selected product
  late Product _product;

  // State for interactive controls (initialised in initState based on product)
  late String _selectedSize;
  late String _selectedColour;
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    // FIX: capture the passed-in product and initialise dropdowns
    _product = widget.product;
    _selectedSize =
        _product.sizes.isNotEmpty ? _product.sizes.first : 'One Size';
    _selectedColour =
        _product.colours.isNotEmpty ? _product.colours.first : 'Default';
  }

  void _addToCart() {
    // Make sure we have size and colour (they should be set already).
    final selectedSize = _selectedSize;
    final selectedColour = _selectedColour;

    // Add to the global cart.
    cartModel.addItem(
      widget.product,
      selectedSize,
      selectedColour,
      _quantity,
    );

    // Show a small message at the bottom of the screen.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Added $_quantity × $selectedSize / $selectedColour ${widget.product.name} to your cart.',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _buyNow() {
    final selectedSize = _selectedSize;
    final selectedColour = _selectedColour;

    // Use sale price if available, otherwise normal price.
    final double unitPrice = widget.product.discountPrice;
    final double total = unitPrice * _quantity;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Purchase complete'),
          content: Text(
            '$_quantity × $selectedSize / $selectedColour ${widget.product.name} '
            'purchased for £${total.toStringAsFixed(2)}.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _decrementQuantity() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      }
    });
  }

  void _incrementQuantity() {
    setState(() {
      if (_quantity < 99) {
        _quantity++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // FIX: derive dropdown options from the selected product
    final List<String> sizeOptions =
        _product.sizes.isNotEmpty ? _product.sizes : ['One Size'];
    final List<String> colourOptions =
        _product.colours.isNotEmpty ? _product.colours : ['Default'];

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Shared Header
              const AppHeader(),
              // PRODUCT DETAILS
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product image
                    Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[200],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Builder(
                          builder: (context) {
                            // Decide which image path to use based on the selected colour.
                            String? imagePath;

                            // _selectedColour is a non-null String (late), so we can
                            // safely check if it's not just the default placeholder.
                            if (_selectedColour.isNotEmpty &&
                                _selectedColour != 'Default') {
                              // Try to get an image for the currently selected colour.
                              imagePath = _product
                                  .primaryImageForColourName(_selectedColour);

                              // If that fails (e.g. colour not in kProductColours),
                              // fall back to the model's default image.
                              imagePath ??= _product.defaultImage;
                            } else {
                              // If no meaningful colour is selected, just use the default image.
                              imagePath = _product.defaultImage;
                            }

                            // If there is still no usable path, show the "No image attached" message.
                            if (imagePath == null || imagePath.isEmpty) {
                              return const Center(
                                child: Text(
                                  'No image attached',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              );
                            }

                            // Try to load the image. If the asset is missing,
                            // show the "No image attached" message instead of crashing.
                            return Image.asset(
                              imagePath,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                  child: Text(
                                    'No image attached',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Product name (from selected product)
                    Text(
                      _product.name,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Price of the selected product (shows sale price if available)
                    _product.salePrice == null
                        ? Text(
                            '£${_product.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 24,
                              color: Color(0xFF4d2963),
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // SALE price in red
                              Text(
                                '£${_product.salePrice!.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(width: 8),
                              // Original price with line-through
                              Text(
                                '£${_product.price.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              const SizedBox(width: 8),
                              // Small discount badge like "-20%"
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.redAccent.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '-${(((1 - (_product.salePrice! / _product.price)) * 100).round())}%',
                                  style: const TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),

                    const SizedBox(height: 24),

                    // Dropdowns (size & colour) – stateful
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              labelText: 'Size',
                              border: OutlineInputBorder(),
                            ),
                            // EDIT: use initialValue instead of deprecated value
                            initialValue: _selectedSize,
                            items: sizeOptions
                                .map(
                                  (size) => DropdownMenuItem<String>(
                                    value: size,
                                    child: Text(size),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              if (value == null) return;
                              setState(() => _selectedSize = value);
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              labelText: 'Colour',
                              border: OutlineInputBorder(),
                            ),
                            // EDIT: use initialValue instead of deprecated value
                            initialValue: _selectedColour,
                            items: colourOptions
                                .map(
                                  (colour) => DropdownMenuItem<String>(
                                    value: colour,
                                    child: Text(colour),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              if (value == null) return;
                              setState(() => _selectedColour = value);
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Quantity selector
                    Row(
                      children: [
                        const Text(
                          'Quantity',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(width: 16),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: _decrementQuantity,
                              ),
                              Text('$_quantity'),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: _incrementQuantity,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Action buttons: Add to Cart & Buy Now
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _addToCart,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4d2963),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            child: const Text(
                              'ADD TO CART',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _buyNow,
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              side: const BorderSide(
                                color: Color(0xFF4d2963),
                              ),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            child: const Text(
                              'BUY NOW',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4d2963),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Shared Footer
              const Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
