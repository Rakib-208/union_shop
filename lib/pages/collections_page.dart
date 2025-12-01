import 'package:flutter/material.dart';
import 'package:union_shop/widgets/footer.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/pages/collection_page.dart'; // FIX: import shared Product model

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
      const _CollectionData(
        title: 'Clothing',
        description:
            'Course hoodies, trousers and more for Computer Science students.',
        routeName: '/collection', // navigates to CollectionPage
      ),
      const _CollectionData(
        title: 'Accessories',
        description:
            'Caps, bags, and small items for everyday student life and uni events.',
        routeName: null, // No dedicated page yet, purely informational
      ),
      const _CollectionData(
        title: 'On Sale',
        description:
            'Best offers from the catalogue using the shared product list.',
        routeName: '/sale', // navigates to SaleCollectionPage
      ),
      _CollectionData(
        title: 'All Products',
        description:
            'Combined clothing (${clothingProducts.length}) and accessories '
            '(${accessoriesProducts.length}) from the shared catalogue.',
        routeName: null,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Collections'),
        backgroundColor: const Color(0xFF4d2963),
      ),
      body: SingleChildScrollView(
        child: Column(
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
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
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
                  onTap: () {
                    // We check what the tile is
                    final title = data.title;

                    if (title == 'Clothing') {
                      // Use the existing behavior for clothing
                      Navigator.of(context).pushNamed('/collection');
                    } else if (title == 'Accessories') {
                      // NEW BEHAVIOR: Go to the accessories collection page
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const CollectionPage(
                            title: 'Accessories collection',
                            typeFilter: ProductType.accessories,
                          ),
                        ),
                      );
                    } else if (data.routeName != null) {
                      // Fall back to normal navigation for things like /sale
                      Navigator.of(context).pushNamed(data.routeName!);
                    } else {
                      // For other items with no routeName (like "All products" for now),
                      // we do nothing.
                    }
                  },
                );
              },
            ),
            const Footer(),
          ],
        ),
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
