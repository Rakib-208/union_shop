import 'package:flutter/material.dart';
import 'package:union_shop/footer.dart';

class CollectionExamplePage extends StatefulWidget {
  const CollectionExamplePage({super.key});

  @override
  State<CollectionExamplePage> createState() => _CollectionExamplePageState();
}

class _CollectionExamplePageState extends State<CollectionExamplePage> {
  String _selectedSort = 'Featured';
  String _selectedSize = 'All';
  String _selectedColour = 'All';

  @override
  Widget build(BuildContext context) {
    const products = [
      _CollectionProduct(
        name: 'Course Hoodie - Computing',
        price: '£35.00',
      ),
      _CollectionProduct(
        name: 'Course Hoodie - Business',
        price: '£35.00',
      ),
      _CollectionProduct(
        name: 'Course Hoodie - Engineering',
        price: '£38.00',
      ),
      _CollectionProduct(
        name: 'Course Hoodie - Law',
        price: '£38.00',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Hoodies Collection'),
        backgroundColor: const Color(0xFF4d2963),
      ),
      body: Column(
        children: [
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

          // FILTERS
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
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
                    onChanged: (value) =>
                        setState(() => _selectedSort = value!),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildDropdown(
                    label: 'Size',
                    value: _selectedSize,
                    items: const ['All', 'S', 'M', 'L', 'XL'],
                    onChanged: (value) =>
                        setState(() => _selectedSize = value!),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildDropdown(
                    label: 'Colour',
                    value: _selectedColour,
                    items: const ['All', 'Navy', 'Black', 'Grey'],
                    onChanged: (value) =>
                        setState(() => _selectedColour = value!),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // GRID LIST
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 3 / 4,
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                return _CollectionProductCard(product: product);
              },
            ),
          ),

          const Footer(),
        ],
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
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        DropdownButtonFormField<String>(
          value: value,
          items: items
              .map(
                (v) => DropdownMenuItem<String>(
                  value: v,
                  child: Text(v),
                ),
              )
              .toList(),
          onChanged: onChanged,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            isDense: true,
          ),
        ),
      ],
    );
  }
}

class _CollectionProduct {
  final String name;
  final String price;

  const _CollectionProduct({
    required this.name,
    required this.price,
  });
}

class _CollectionProductCard extends StatelessWidget {
  final _CollectionProduct product;

  // EDIT: removed unused `key` parameter to fix analyzer warning.
  const _CollectionProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                color: Colors.grey[200],
                child: const Icon(Icons.image, size: 48, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.name,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(product.price),
            const SizedBox(height: 4),
            OutlinedButton(
              onPressed: () {},
              child: const Text('VIEW PRODUCT'),
            ),
          ],
        ),
      ),
    );
  }
}
