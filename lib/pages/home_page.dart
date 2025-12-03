import 'package:flutter/material.dart';
import 'package:union_shop/widgets/footer.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/widgets/promo.dart';
import 'package:union_shop/widgets/app_header.dart';
import 'package:union_shop/widgets/product_card.dart';
import 'package:union_shop/widgets/hero_category_slider.dart';
import 'dart:math' as math;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void navigateToProduct(BuildContext context) {
    Navigator.pushNamed(context, '/product');
  }

  void navigateToLogin(BuildContext context) {
    Navigator.pushNamed(context, '/login');
  }

  void navigateToCollections(BuildContext context) {
    Navigator.pushNamed(context, '/collections');
  }

  void navigateToAboutUs(BuildContext context) {
    Navigator.pushNamed(context, '/about');
  }

  void placeholderCallbackForButtons() {
    // Placeholder for the button callbacks, you can customize this later if needed
  }

  @override
  Widget build(BuildContext context) {
    const double fixedWidth = 1100;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            color: Colors.white,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: fixedWidth),
                child: Column(
                  children: [
                    const AppHeader(),
                    const TopPromo(),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const HeroCategorySlider(),
                            Container(
                              color: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 24,
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 32,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Featured products',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Browse a selection of our student favourites.',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  LayoutBuilder(
                                    builder: (context, constraints) {
                                      final isWide = constraints.maxWidth > 600;
                                      final crossAxisCount = isWide ? 4 : 2;

                                      final shuffled =
                                          List<Product>.from(allProducts);
                                      shuffled.shuffle(math.Random());
                                      final featuredProducts =
                                          shuffled.take(10).toList();

                                      return GridView.count(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        crossAxisCount: crossAxisCount,
                                        mainAxisSpacing: 24,
                                        crossAxisSpacing: 24,
                                        childAspectRatio: 1 / 2,
                                        children: [
                                          for (final product
                                              in featuredProducts)
                                            ProductCard.fromProduct(product),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const Footer(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// SMALL REUSABLE WIDGETS BELOW

class HeroPreviewCard extends StatelessWidget {
  final VoidCallback onShopNow;

  const HeroPreviewCard({
    super.key,
    required this.onShopNow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      width: 220,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .08),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white24),
      ),
    );
  }
}
