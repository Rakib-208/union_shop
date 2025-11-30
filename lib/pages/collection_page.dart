import 'package:flutter/material.dart';
import 'package:union_shop/footer.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/pages/home_page.dart' show ProductCard;

class CollectionPage extends StatefulWidget {
  const CollectionPage({super.key});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  String _selectedSort = 'Featured';
  String _selectedSize = 'All';
  String _selectedColour = 'All';

  @override
  Widget build(BuildContext context) {
    // For now, just show all products in this collection.
    final List<Product> products = allProducts.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Hoodies Collection'),
        backgroundColor: const Color(0xFF4d2963),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Responsive: match home-page-like behaviour
          final bool isWide = constraints.maxWidth > 600;
          final int crossAxisCount = isWide ? 4 : 2;

          return SingleChildScrollView(
            child: Column(
              children: [
                // Intro banner
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  color: Colors.grey[100],
                  child: const Text(
                    'Dummy collection page showing example filters and product cards. '
                    'Dropdowns are present for coursework purposes and do not have '
                    'to change the data.',
                  ),
                ),

                // Filters (responsive using inner LayoutBuilder)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: LayoutBuilder(
                    builder: (context, innerConstraints) {
                      final isNarrow = innerConstraints.maxWidth < 600;

                      if (isNarrow) {
                        // Mobile / narrow: filters stacked vertically
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildDropdown(
                              label: 'Sort by',
                              value: _selectedSort,
                              items: const [
                                'Featured',
                                'Price: Low to High',
                                'Price: High to Low',
                              ],
                              onChanged: (value) {
                                setState(() => _selectedSort = value!);
                              },
                            ),
                            const SizedBox(height: 8),
                            _buildDropdown(
                              label: 'Size',
                              value: _selectedSize,
                              items: const ['All', 'S', 'M', 'L', 'XL'],
                              onChanged: (value) {
                                setState(() => _selectedSize = value!);
                              },
                            ),
                            const SizedBox(height: 8),
                            _buildDropdown(
                              label: 'Colour',
                              value: _selectedColour,
                              items: const ['All', 'Navy', 'Black', 'Grey'],
                              onChanged: (value) {
                                setState(() => _selectedColour = value!);
                              },
                            ),
                          ],
                        );
                      } else {
                        // Wider layout: filters in a row
                        return Row(
                          children: [
                            Expanded(
                              child: _buildDropdown(
                                label: 'Sort by',
                                value: _selectedSort,
                                items: const [
                                  'Featured',
                                  'Price: Low to High',
                                  'Price: High to Low',
                                ],
                                onChanged: (value) {
                                  setState(() => _selectedSort = value!);
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildDropdown(
                                label: 'Size',
                                value: _selectedSize,
                                items: const ['All', 'S', 'M', 'L', 'XL'],
                                onChanged: (value) {
                                  setState(() => _selectedSize = value!);
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildDropdown(
                                label: 'Colour',
                                value: _selectedColour,
                                items: const ['All', 'Navy', 'Black', 'Grey'],
                                onChanged: (value) {
                                  setState(() => _selectedColour = value!);
                                },
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),

                const SizedBox(height: 8),

                // Grid of products – same visual style as home page
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 24,
                    crossAxisSpacing: 24,
                    childAspectRatio: 3 / 4,
                    children: [
                      for (final product in products)
                        ProductCard.fromProduct(product),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Footer at the end of the scroll
                const Footer(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        DropdownButtonFormField<String>(
          initialValue: value,
          items: items
              .map(
                (item) => DropdownMenuItem(
                  value: item,
                  child: Text(item),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
