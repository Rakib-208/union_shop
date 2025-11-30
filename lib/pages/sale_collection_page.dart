import 'package:flutter/material.dart';
import 'package:union_shop/footer.dart';
import 'package:union_shop/models/product.dart';

class SaleCollectionPage extends StatelessWidget {
  const SaleCollectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Pull all products with a sale price from the shared catalogue.
    final List<Product> saleProducts =
        allProducts.where((p) => p.salePrice != null).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sale & Promotions'),
        backgroundColor: const Color(0xFF4d2963),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4d2963), Color(0xFFB76DFB)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Limited-time sale',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Dummy sale collection with hardcoded prices for coursework purposes.',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: saleProducts.length,
              itemBuilder: (context, index) {
                final product = saleProducts[index];
                return _SaleCard(product: product);
              },
            ),
          ),
          const Footer(),
        ],
      ),
    );
  }
}

class _SaleCard extends StatelessWidget {
  final Product product;

  // EDIT: removed unused `key` parameter from constructor to fix analyzer warning.
  const _SaleCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final String originalPrice = '£${product.price.toStringAsFixed(2)}';
    final String salePrice = '£${product.discountPrice.toStringAsFixed(2)}';
    final String? discountLabel = product.discountPercentage != null
        ? '-${product.discountPercentage!.toStringAsFixed(0)}%'
        : null;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(Icons.local_offer, color: Colors.redAccent),
        title: Text(
          product.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Row(
          children: [
            Text(
              originalPrice,
              style: const TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Colors.grey,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              discountLabel != null ? '$salePrice ($discountLabel)' : salePrice,
              style: const TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        trailing: const Text(
          'SALE',
          style: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
