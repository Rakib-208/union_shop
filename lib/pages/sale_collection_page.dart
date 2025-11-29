import 'package:flutter/material.dart';
import 'package:union_shop/footer.dart';

class SaleCollectionPage extends StatelessWidget {
  const SaleCollectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    const saleProducts = [
      _SaleProduct(
        name: 'Portsmouth Scarf',
        originalPrice: '£20.00',
        salePrice: '£14.00',
      ),
      _SaleProduct(
        name: 'Logo Hoodie',
        originalPrice: '£40.00',
        salePrice: '£30.00',
      ),
      _SaleProduct(
        name: 'Campus Mug',
        originalPrice: '£10.00',
        salePrice: '£6.00',
      ),
    ];

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
                  'LIMITED TIME SALE',
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 2,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Up to 30% off selected Union Shop lines',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4),
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

class _SaleProduct {
  final String name;
  final String originalPrice;
  final String salePrice;

  const _SaleProduct({
    required this.name,
    required this.originalPrice,
    required this.salePrice,
  });
}

class _SaleCard extends StatelessWidget {
  final _SaleProduct product;

  // EDIT: removed unused `key` parameter from constructor to fix analyzer warning.
  const _SaleCard({required this.product});

  @override
  Widget build(BuildContext context) {
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
              product.originalPrice,
              style: const TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Colors.grey,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              product.salePrice,
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
