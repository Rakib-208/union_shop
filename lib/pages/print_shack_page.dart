import 'package:flutter/material.dart';
import 'package:union_shop/widgets/app_header.dart';
import 'package:union_shop/widgets/footer.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/models/cart.dart';

class PrintShackPage extends StatefulWidget {
  const PrintShackPage({super.key});

  @override
  State<PrintShackPage> createState() => _PrintShackPageState();
}

class _PrintShackPageState extends State<PrintShackPage> {
  // Dropdown selection: how many lines of text?
  String _selectedLines = 'One Line of Text';

  // Text fields for personalisation + quantity
  final TextEditingController _line1Controller = TextEditingController();
  final TextEditingController _line2Controller = TextEditingController();
  final TextEditingController _quantityController =
      TextEditingController(text: '1');

  @override
  void dispose() {
    // Clean up controllers when page is destroyed
    _line1Controller.dispose();
    _line2Controller.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Shared site header
              const AppHeader(),

              // Main content
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    // Page title
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Print Shack – Text Personalisation',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Content area
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product image
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              // Placeholder UPSU image
                              'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                              height: 260,
                              width: 260,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 260,
                                  width: 260,
                                  color: Colors.grey[200],
                                  child: const Icon(
                                    Icons.image,
                                    size: 48,
                                    color: Colors.grey,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Personalisation form
                        Card(
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Personalisation',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  '£3.00 per line (example price)',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),

                                const SizedBox(height: 16),

                                // Per line dropdown
                                const Text(
                                  'Per line:',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                DropdownButtonFormField<String>(
                                  value: _selectedLines,
                                  items: const [
                                    DropdownMenuItem(
                                      value: 'One Line of Text',
                                      child: Text('One Line of Text'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'Two Lines of Text',
                                      child: Text('Two Lines of Text'),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    if (value == null) return;
                                    setState(() {
                                      _selectedLines = value;

                                      // If user switches back to one line,
                                      // we can optionally clear line 2.
                                      if (_selectedLines ==
                                          'One Line of Text') {
                                        _line2Controller.clear();
                                      }
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 10,
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 16),

                                // Personalisation line 1
                                const Text(
                                  'Personalisation Line 1',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                TextField(
                                  controller: _line1Controller,
                                  decoration: const InputDecoration(
                                    hintText: 'Enter your text...',
                                    border: OutlineInputBorder(),
                                  ),
                                ),

                                const SizedBox(height: 16),

                                // Personalisation line 2 (shown only if selected)
                                if (_selectedLines == 'Two Lines of Text') ...[
                                  const Text(
                                    'Personalisation Line 2',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  TextField(
                                    controller: _line2Controller,
                                    decoration: const InputDecoration(
                                      hintText: 'Enter your second line...',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                ],

                                // Quantity
                                const Text(
                                  'Quantity',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                SizedBox(
                                  width: 80,
                                  child: TextField(
                                    controller: _quantityController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 10,
                                      ),
                                      hintText: '1',
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 20),

                                // Add to cart button (we'll wire this later)
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF4D2963),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                    ),
                                    onPressed: () {
                                      // 1) Read and validate the text lines.
                                      final line1 =
                                          _line1Controller.text.trim();
                                      final line2 =
                                          _line2Controller.text.trim();

                                      if (line1.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Please enter at least Line 1 for your text.'),
                                          ),
                                        );
                                        return;
                                      }

                                      // 2) Work out how many lines the user chose.
                                      final bool isTwoLines =
                                          _selectedLines == 'Two Lines of Text';

                                      // If 2 lines selected but line2 is empty, we can warn or allow it.
                                      if (isTwoLines && line2.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Please fill in Line 2 or switch back to one line.'),
                                          ),
                                        );
                                        return;
                                      }

                                      // 3) Parse quantity safely.
                                      final qtyText =
                                          _quantityController.text.trim();
                                      int qty = int.tryParse(qtyText.isEmpty
                                              ? '1'
                                              : qtyText) ??
                                          1;
                                      if (qty < 1) qty = 1;

                                      // 4) Build a combined text description for the cart.
                                      final String personalisationText =
                                          isTwoLines
                                              ? '$line1 / $line2'
                                              : line1;

                                      // 5) Pick which special product to use (1 line = id 30, 2 lines = id 31).
                                      final int productId =
                                          isTwoLines ? 31 : 30;

                                      final Product printShackProduct =
                                          allProducts.firstWhere(
                                              (p) => p.id == productId);

                                      // 6) Use "size" as a label for number of lines,
                                      //    and "colour" to carry the actual personalised text.
                                      final String sizeLabel =
                                          isTwoLines ? '2 lines' : '1 line';
                                      final String colourLabel =
                                          personalisationText;

                                      // 7) Add to the global cart.
                                      cartModel.addItem(
                                        printShackProduct,
                                        sizeLabel,
                                        colourLabel,
                                        qty,
                                      );

                                      // 8) Show confirmation to the user.
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Added to cart: $sizeLabel of text:\n"$personalisationText"\n'
                                            'Quantity: $qty',
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'ADD TO CART',
                                      style: TextStyle(
                                        fontSize: 16,
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Shared footer
              const Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
