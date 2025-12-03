import 'package:flutter/material.dart';
import 'package:union_shop/widgets/footer.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/widgets/product_card.dart' show ProductCard;

/// A reusable collection page that can show:
/// - only clothing
/// - only accessories
/// - or all products (when [typeFilter] is null)
class CollectionPage extends StatefulWidget {
  final String title;
  final ProductType? typeFilter;
  final ProductCat? catFilter;

  const CollectionPage({
    super.key,
    required this.title,
    this.typeFilter,
    this.catFilter,
  });

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  String _selectedSort = 'Featured';
  String _selectedSize = 'All';
  String _selectedColour = 'All';

  double _effectivePrice(Product p) => p.discountPrice;

  /// Apply type, size, colour and sort filters.
  List<Product> _filteredAndSortedProducts() {
    // 1) Filter
    List<Product> filtered = allProducts.where((product) {
      final bool matchesCat =
          widget.catFilter == null || product.cat == widget.catFilter;
      // Type filter: if typeFilter is null, accept all types
      final bool matchesType =
          widget.typeFilter == null ? true : product.type == widget.typeFilter;

      // Size filter
      final bool matchesSize =
          _selectedSize == 'All' ? true : product.sizes.contains(_selectedSize);

      // Colour filter
      final bool matchesColour = _selectedColour == 'All'
          ? true
          : product.colours.contains(_selectedColour);

      return matchesType && matchesSize && matchesColour && matchesCat;
    }).toList();

    // 2) Sort
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
    // Get filtered products and screen size info
    final products = _filteredAndSortedProducts();
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        // If your CollectionPage has a 'title' field on the widget, this uses it
        // e.g. "Clothing collection", "Accessories collection", "All products"
        title: Text(widget.title),
        backgroundColor: const Color(0xFF4d2963),
      ),
      // ✅ The WHOLE page (content + footer) scrolls together now
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Page content (title, filters, grid)
            Padding(
              padding:
                  const EdgeInsets.fromLTRB(16, 16, 16, 120), // bottom space
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Browse ${widget.title.toLowerCase()}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 16),

                  // Filters row/column
                  _buildFilters(isMobile),
                  const SizedBox(height: 16),

                  // Products grid or empty message
                  if (products.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: Text(
                          'No products match your filters.',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    )
                  else
                    _buildGrid(products, isMobile),
                ],
              ),
            ),

            // ✅ Footer is now at the VERY BOTTOM of the scroll,
            // not stuck over the products.
            const Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters(bool isMobile) {
    final sortOptions = <String>[
      'Featured',
      'Price: Low to High',
      'Price: High to Low',
    ];

    final sizeOptions = <String>[
      'All',
      'S',
      'M',
      'L',
      'XL',
    ];

    final colourOptions = <String>[
      'All',
      'Navy',
      'Black',
      'Grey',
      'Red',
      'Green',
    ];

    if (isMobile) {
      // Filters stacked vertically on small screens
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDropdown(
            label: 'Sort by',
            value: _selectedSort,
            items: sortOptions,
            onChanged: (value) {
              if (value == null) return;
              setState(() => _selectedSort = value);
            },
          ),
          const SizedBox(height: 12),
          _buildDropdown(
            label: 'Size',
            value: _selectedSize,
            items: sizeOptions,
            onChanged: (value) {
              if (value == null) return;
              setState(() => _selectedSize = value);
            },
          ),
          const SizedBox(height: 12),
          _buildDropdown(
            label: 'Colour',
            value: _selectedColour,
            items: colourOptions,
            onChanged: (value) {
              if (value == null) return;
              setState(() => _selectedColour = value);
            },
          ),
        ],
      );
    }

    // Filters in a row on larger screens
    return Row(
      children: [
        Expanded(
          child: _buildDropdown(
            label: 'Sort by',
            value: _selectedSort,
            items: sortOptions,
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
            items: sizeOptions,
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
            items: colourOptions,
            onChanged: (value) {
              if (value == null) return;
              setState(() => _selectedColour = value);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildGrid(List<Product> products, bool isMobile) {
    final crossAxisCount = isMobile ? 2 : 4;

    return GridView.count(
      crossAxisCount: crossAxisCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 3 / 5,
      children: products
          .map(
            (product) => ProductCard.fromProduct(product),
          )
          .toList(),
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
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        DropdownButtonFormField<String>(
          value: value,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
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
