import 'package:flutter/material.dart';
import 'package:union_shop/buttons.dart'; // shared header buttons
import 'package:union_shop/footer.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  // State for interactive controls
  String _selectedSize = 'M';
  String _selectedColour = 'Navy';
  int _quantity = 1;

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

                    // Main header row
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      // Same responsive header pattern as home_page.dart
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final isMobile = constraints.maxWidth < 600;

                          if (isMobile) {
                            // MOBILE: 45% logo, 55% buttons
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
                                Expanded(
                                  flex: 55,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: HeaderButtons(
                                      // search overlay handled inside HeaderButtons
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
                            // DESKTOP / LARGE: 20% logo, 55% blank, 25% buttons
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
                        child: Image.network(
                          'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(
                                Icons.image_not_supported,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Product name
                    const Text(
                      'Placeholder Product Name',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Price
                    const Text(
                      '£15.00',
                      style: TextStyle(
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
                            items: const [
                              DropdownMenuItem(
                                value: 'S',
                                child: Text('S'),
                              ),
                              DropdownMenuItem(
                                value: 'M',
                                child: Text('M'),
                              ),
                              DropdownMenuItem(
                                value: 'L',
                                child: Text('L'),
                              ),
                              DropdownMenuItem(
                                value: 'XL',
                                child: Text('XL'),
                              ),
                            ],
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
                            items: const [
                              DropdownMenuItem(
                                value: 'Navy',
                                child: Text('Navy'),
                              ),
                              DropdownMenuItem(
                                value: 'Black',
                                child: Text('Black'),
                              ),
                              DropdownMenuItem(
                                value: 'Grey',
                                child: Text('Grey'),
                              ),
                            ],
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

                    // Action buttons (ADD TO CART / BUY NOW)
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
                              style: TextStyle(letterSpacing: 1),
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
                                letterSpacing: 1,
                                color: Color(0xFF4d2963),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Product description
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'This is a placeholder description for a product. In a real implementation '
                      'this text would be replaced with product information and the page would '
                      'be wired up to live data.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        height: 1.5,
                      ),
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
