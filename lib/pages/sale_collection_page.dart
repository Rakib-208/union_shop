import 'package:flutter/material.dart';
import 'package:union_shop/widgets/footer.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/widgets/product_card.dart';

class SaleCollectionPage extends StatelessWidget {
  const SaleCollectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    const double fixedWidth = 1100;

    final List<Product> saleProducts =
        allProducts.where((p) => p.salePrice != null).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sale & Promotions'),
        backgroundColor: const Color(0xFF4d2963), // SAME AS COLLECTIONS PAGE
        centerTitle: true,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isMobile = constraints.maxWidth < 600;

          return Container(
            color: Colors.white,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: fixedWidth),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _SaleTopBanner(isMobile: isMobile),
                      const SizedBox(height: 16),
                      if (saleProducts.isEmpty)
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 40,
                            horizontal: 16,
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.local_offer_outlined,
                                size: 40,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 12),
                              Text(
                                'No sale items available right now.\n'
                                'Check back soon for new offers.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sale items (${saleProducts.length})',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              LayoutBuilder(
                                builder: (context, innerConstraints) {
                                  final double width =
                                      innerConstraints.maxWidth;

                                  int crossAxisCount;
                                  if (width < 600) {
                                    crossAxisCount = 2;
                                  } else if (width < 900) {
                                    crossAxisCount = 3;
                                  } else {
                                    crossAxisCount = 4;
                                  }

                                  return GridView.count(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    crossAxisCount: crossAxisCount,
                                    mainAxisSpacing: 24,
                                    crossAxisSpacing: 24,
                                    childAspectRatio: 3 / 5,
                                    children: [
                                      for (final product in saleProducts)
                                        ProductCard.fromProduct(product),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 24),
                      const Footer(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SaleTopBanner extends StatelessWidget {
  final bool isMobile;

  const _SaleTopBanner({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final double verticalPadding = isMobile ? 10 : 14;
    final double horizontalPadding = isMobile ? 12 : 16;
    final double titleSize = isMobile ? 16 : 18;
    final double subtitleSize = isMobile ? 12 : 13;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding,
          horizontal: horizontalPadding,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [
              Colors.purple.withValues(alpha: .15),
              Colors.pink.withValues(alpha: .15),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.local_fire_department_outlined,
              color: Colors.redAccent,
              size: 20,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Limited time sale',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: titleSize,
                      fontWeight: FontWeight.w700,
                      color: Colors.purple.shade900,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Save up to 20% on selected Union Shop favourites.',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: subtitleSize,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.redAccent.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'SALE',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.w600,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
