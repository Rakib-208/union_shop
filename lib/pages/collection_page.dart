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

  double _effectivePrice(Product product) => product.discountPrice;

  List<Product> _filteredAndSortedProducts() {
    final List<Product> filtered = allProducts.where((product) {
      final bool matchesSize =
          _selectedSize == 'All' || product.sizes.contains(_selectedSize);
      final bool matchesColour =
          _selectedColour == 'All' || product.colours.contains(_selectedColour);
      return matchesSize && matchesColour;
    }).toList();

    if (_selectedSort == 'Price: Low to High') {
      filtered.sort(
        (a, b) => _effectivePrice(a).compareTo(_effectivePrice(b)),
      );
    } else if (_selectedSort == 'Price: High to Low') {
      filtered.sort(
        (a, b) => _effectivePrice(b).compareTo(_effectivePrice(a)),
      );
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    // Use current filters + sort to drive the collection view.
    final List<Product> products = _filteredAndSortedProducts();

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
                  padding: const EdgeInsets.all(16),
                  child: LayoutBuilder(
                    builder: (context, innerConstraints) {
                      final bool isFilterWide = innerConstraints.maxWidth > 600;

                      if (isFilterWide) {
                        // Row layout for filters on wide screens
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  if (value == null) return;
                                  setState(() => _selectedSort = value);
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildDropdown(
                                label: 'Size',
                                value: _selectedSize,
                                items: const ['All', 'S', 'M', 'L', 'XL'],
                                onChanged: (value) {
                                  if (value == null) return;
                                  setState(() => _selectedSize = value);
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildDropdown(
                                label: 'Colour',
                                value: _selectedColour,
                                items: const [
                                  'All',
                                  'Navy',
                                  'Black',
                                  'Grey',
                                  'Red',
                                  'Green'
                                ],
                                onChanged: (value) {
                                  if (value == null) return;
                                  setState(() => _selectedColour = value);
                                },
                              ),
                            ),
                          ],
                        );
                      } else {
                        // Column layout for filters on narrow screens
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
                                if (value == null) return;
                                setState(() => _selectedSort = value);
                              },
                            ),
                            const SizedBox(height: 12),
                            _buildDropdown(
                              label: 'Size',
                              value: _selectedSize,
                              items: const ['All', 'S', 'M', 'L', 'XL'],
                              onChanged: (value) {
                                if (value == null) return;
                                setState(() => _selectedSize = value);
                              },
                            ),
                            const SizedBox(height: 12),
                            _buildDropdown(
                              label: 'Colour',
                              value: _selectedColour,
                              items: const [
                                'All',
                                'Navy',
                                'Black',
                                'Grey',
                                'Red',
                                'Green'
                              ],
                              onChanged: (value) {
                                if (value == null) return;
                                setState(() => _selectedColour = value);
                              },
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),

                // Product grid
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 3 / 4,
                    children: [
                      for (final product in products)
                        ProductCard.fromProduct(product),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

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
          value: value,
          isExpanded: true,
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
