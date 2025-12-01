import 'package:flutter/material.dart';
import 'package:union_shop/widgets/footer.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/pages/collection_page.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Pre-calculate counts for each group
    final clothingProducts =
        allProducts.where((p) => p.type == ProductType.clothing).toList();

    final accessoriesProducts =
        allProducts.where((p) => p.type == ProductType.accessories).toList();

    final int allCount = allProducts.length;

    final int saleCount = allProducts.where((p) => p.salePrice != null).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Collections'),
        backgroundColor: const Color(0xFF4d2963),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // All the tiles wrapped in padding
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildTile(
                    context: context,
                    title: 'Clothing',
                    subtitle:
                        'All clothing items (${clothingProducts.length} products)',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const CollectionPage(
                            title: 'Clothing collection',
                            typeFilter: ProductType.clothing,
                          ),
                        ),
                      );
                    },
                  ),
                  const Divider(),
                  _buildTile(
                    context: context,
                    title: 'Accessories',
                    subtitle:
                        'All accessories (${accessoriesProducts.length} products)',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const CollectionPage(
                            title: 'Accessories collection',
                            typeFilter: ProductType.accessories,
                          ),
                        ),
                      );
                    },
                  ),
                  const Divider(),
                  _buildTile(
                    context: context,
                    title: 'All products',
                    subtitle: 'All items in the shop ($allCount total)',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const CollectionPage(
                            title: 'All products',
                            // no typeFilter -> shows all types
                          ),
                        ),
                      );
                    },
                  ),
                  const Divider(),
                  _buildTile(
                    context: context,
                    title: 'On sale',
                    subtitle:
                        'All items currently on sale ($saleCount products)',
                    onTap: () {
                      Navigator.of(context).pushNamed('/sale');
                    },
                  ),
                ],
              ),
            ),

            // Footer now sits at the very bottom of the scroll
            const Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildTile({
    required BuildContext context,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
