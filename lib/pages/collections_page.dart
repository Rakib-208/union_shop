import 'package:flutter/material.dart';
import 'package:union_shop/footer.dart';
import 'package:union_shop/product.dart'; // FIX: import shared Product model

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // FIX: collections now derived dynamically from Product types
    final clothingProducts =
        allProducts.where((p) => p.type == ProductType.clothing).toList();

    final accessoriesProducts =
        allProducts.where((p) => p.type == ProductType.accessories).toList();

    final collections = [
      // FIX: was const → now dynamic due to product counts
      _CollectionData(
        // FIX: Clothing collection now uses model-driven count
        title: 'Clothing (${clothingProducts.length} items)',
        description: 'T-shirts, shirts, pants, hoodies and jackets.',
        routeName:
            '/collection-example', // uses your existing CollectionPage route
      ),
      _CollectionData(
        // FIX: Accessories collection now uses model-driven count
        title: 'Accessories (${accessoriesProducts.length} items)',
        description: 'Caps and sunglasses.',
        routeName: null, // placeholder: no accessories page yet
      ),
      _CollectionData(
        // FIX: Sale route remains unchanged
        title: 'Sale & Clearance',
        description: 'Discounted end-of-line stock and seasonal promotions.',
        routeName: '/sale',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Collections'),
        backgroundColor: const Color(0xFF4d2963),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.grey[100],
            child: const Text(
              'Browse product collections. Clothing and accessories are now '
              'grouped using the shared product catalogue.',
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: collections.length,
              separatorBuilder: (context, index) => const Divider(height: 0),
              itemBuilder: (context, index) {
                final data = collections[index];
                return ListTile(
                  title: Text(
                    data.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      data.description,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  trailing: data.routeName != null
                      ? const Icon(Icons.chevron_right)
                      : null,
                  onTap: data.routeName != null
                      ? () => Navigator.of(context).pushNamed(data.routeName!)
                      : null,
                );
              },
            ),
          ),
          const Footer(),
        ],
      ),
    );
  }
}

class _CollectionData {
  final String title;
  final String description;
  final String? routeName;

  const _CollectionData({
    required this.title,
    required this.description,
    this.routeName,
  });
}
