import 'package:flutter/material.dart';
import 'package:union_shop/widgets/footer.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/widgets/promo.dart';
import 'package:union_shop/widgets/app_header.dart';
import 'package:union_shop/widgets/product_card.dart';
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
          final isMobile = constraints.maxWidth < 600;

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
                            SizedBox(
                              height: 400,
                              width: double.infinity,
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: Image.network(
                                      'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.black.withValues(alpha: .4),
                                            Colors.black.withValues(alpha: .4),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 32,
                                        vertical: 24,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 6,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 12,
                                                    vertical: 6,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white
                                                        .withValues(alpha: .12),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      50,
                                                    ),
                                                  ),
                                                  child: const Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Icon(
                                                        Icons.trending_up,
                                                        color: Colors.amber,
                                                        size: 16,
                                                      ),
                                                      SizedBox(width: 6),
                                                      Text(
                                                        'New season, new drops',
                                                        style: TextStyle(
                                                          color: Colors.white70,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                const Text(
                                                  'Wear your campus pride.\nEvery day.',
                                                  style: TextStyle(
                                                    fontSize: 32,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    height: 1.3,
                                                  ),
                                                ),
                                                const SizedBox(height: 12),
                                                const Text(
                                                  'Premium university-branded clothing designed for comfort, style, and everyday uni life.',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white70,
                                                    height: 1.5,
                                                  ),
                                                ),
                                                const SizedBox(height: 24),
                                                Row(
                                                  children: [
                                                    ElevatedButton(
                                                      onPressed: () =>
                                                          navigateToCollections(
                                                              context),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Colors.amber,
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 24,
                                                          vertical: 12,
                                                        ),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                      ),
                                                      child: const Text(
                                                        'Shop collections',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          if (!isMobile)
                                            const SizedBox(width: 24),
                                          if (!isMobile)
                                            Expanded(
                                              flex: 4,
                                              child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: HeroPreviewCard(
                                                  onShopNow: () =>
                                                      navigateToCollections(
                                                          context),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 24,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Explore by category',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  const Text(
                                    'Find something for lectures, the library, socials, or just chilling in halls.',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        _CategoryChip(
                                          label: 'Hoodies',
                                          icon: Icons.checkroom,
                                          onTap: () =>
                                              navigateToCollections(context),
                                        ),
                                        const SizedBox(width: 12),
                                        _CategoryChip(
                                          label: 'T-shirts',
                                          icon: Icons.emoji_people,
                                          onTap: () =>
                                              navigateToCollections(context),
                                        ),
                                        const SizedBox(width: 12),
                                        _CategoryChip(
                                          label: 'Accessories',
                                          icon: Icons.workspaces_outline,
                                          onTap: () =>
                                              navigateToCollections(context),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
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
                                        childAspectRatio: 3 / 4,
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

class _CategoryChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: .03),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: Colors.black87,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
