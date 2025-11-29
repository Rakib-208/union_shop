import 'package:flutter/material.dart';
import 'package:union_shop/buttons.dart'; // shared header buttons
import 'package:union_shop/footer.dart';
import 'package:union_shop/models/product.dart'; // FIX: shared Product model

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

  void _navigateToHome() {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void _navigateToLogin() {
    Navigator.pushNamed(context, '/login');
  }

  // Product-page-specific cart feedback
  void _showCartMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Cart is empty (demo only). Selected: $_quantity x $_selectedSize / $_selectedColour',
        ),
      ),
    );
  }

  void _addToCart() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Added $_quantity x $_selectedSize / $_selectedColour to cart (demo only).',
        ),
      ),
    );
  }

  void _buyNow() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Checkout flow is not implemented (demo only).'),
      ),
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
              // HEADER
              Container(
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Top banner
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      color: const Color(0xFF4d2963),
                      child: const Text(
                        'PLACEHOLDER HEADER TEXT',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final isMobile = constraints.maxWidth < 600;

                          if (isMobile) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 45,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: GestureDetector(
                                      onTap: _navigateToHome,
                                      child: Image.network(
                                        'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                                        height: 32,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Icon(
                                          Icons.store,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  flex: 55,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: HeaderButtons(
                                      onSearch: () {},
                                      onAccount: _navigateToLogin,
                                      onCart: _showCartMessage,
                                      onMenu: () {},
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 20,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: GestureDetector(
                                      onTap: _navigateToHome,
                                      child: Image.network(
                                        'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                                        height: 40,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Icon(
                                          Icons.store,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  flex: 55,
                                  child: SizedBox.shrink(),
                                ),
                                Expanded(
                                  flex: 25,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: HeaderButtons(
                                      onSearch: () {},
                                      onAccount: _navigateToLogin,
                                      onCart: _showCartMessage,
                                      onMenu: () {},
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),

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
                            // FIX: use product image when available, otherwise show placeholder text
                            if (_product.imageAsset == null ||
                                _product.imageAsset!.isEmpty) {
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
                            return Image.asset(
                              _product.imageAsset!,
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

                    // Price (from selected product)
                    Text(
                      '£${_product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 24,
                        color: Color(0xFF4d2963),
                        fontWeight: FontWeight.w600,
                      ),
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
