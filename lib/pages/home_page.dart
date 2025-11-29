import 'package:flutter/material.dart';
import 'package:union_shop/buttons.dart';
import 'package:union_shop/footer.dart';
import 'package:union_shop/models/product.dart'; // FIX: import shared Product model for home products

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void navigateToProduct(BuildContext context) {
    Navigator.pushNamed(context, '/product');
  }

  void navigateToCollections(BuildContext context) {
    Navigator.pushNamed(context, '/collections');
  }

  void navigateToLogin(BuildContext context) {
    Navigator.pushNamed(context, '/login');
  }

  void placeholderCallbackForButtons() {
    // This is the event handler for header buttons that don't need behaviour yet
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // HEADER
              Container(
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Top banner (restored)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      color: const Color(0xFF4d2963),
                      child: const Text(
                        'BIG SALE! OUR PRODUCTS HAVE DROPPED IN PRICE! OVER 20% OFF! COME GRAB YOURS WHILE STOCK LASTS!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),

                    // Main header row
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final isMobile = constraints.maxWidth < 600;

                          if (isMobile) {
                            // MOBILE LAYOUT:
                            //  - 45% width for logo (left)
                            //  - 55% width for buttons (right)
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 45,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: GestureDetector(
                                      onTap: () => navigateToHome(context),
                                      child: Image.network(
                                        'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                                        height: 32,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Icon(
                                          Icons.store,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  flex: 55,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: HeaderButtons(
                                      onSearch: placeholderCallbackForButtons,
                                      onAccount: () => navigateToLogin(context),
                                      onCart: placeholderCallbackForButtons,
                                      onMenu: placeholderCallbackForButtons,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            // DESKTOP / LARGE SCREEN LAYOUT:
                            //  - 20% width for logo (left)
                            //  - 55% width blank middle
                            //  - 25% width for buttons (right)
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 20,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: GestureDetector(
                                      onTap: () => navigateToHome(context),
                                      child: Image.network(
                                        'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                                        height: 40,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Icon(
                                          Icons.store,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  flex: 55,
                                  child: SizedBox.shrink(),
                                ),
                                Expanded(
                                  flex: 25,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: HeaderButtons(
                                      onSearch: placeholderCallbackForButtons,
                                      onAccount: () => navigateToLogin(context),
                                      onCart: placeholderCallbackForButtons,
                                      onMenu: placeholderCallbackForButtons,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // HERO SECTION
              SizedBox(
                height: 400,
                width: double.infinity,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      // FIX: use brand purple overlay instead of generic black
                      // and avoid deprecated withOpacity
                      color: const Color(0xAA4d2963),
                    ),
                    Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 700),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Placeholder Hero Title',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  height: 1.2,
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'This is placeholder text for the hero section.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 32),
                              BrowseProductsButton(
                                onPressed: () => navigateToCollections(context),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // PRODUCTS SECTION
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    children: [
                      const Text(
                        'PRODUCTS SECTION',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 48),
                      // FIX: use real products from the shared product catalogue
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final isWide = constraints.maxWidth > 600;
                          final crossAxisCount = isWide ? 4 : 2;

                          // Choose a subset of products to feature on the home page
                          final featuredProducts = allProducts.take(4).toList();

                          return GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: crossAxisCount,
                            mainAxisSpacing: 24,
                            crossAxisSpacing: 24,
                            childAspectRatio: 3 / 4,
                            children: [
                              for (final product in featuredProducts)
                                ProductCard.fromProduct(product),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // SHARED FOOTER
              const Footer(),
            ],
          ),
        ),
      ),
    );
  }
}

// UPDATED: ProductCard now uses Product model and handles missing images
class ProductCard extends StatelessWidget {
  // FIX: now driven by Product model instead of loose title/price/image strings
  final String title;
  final String price;
  final String? imageAssetPath;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    this.imageAssetPath,
  });

  // FIX: convenience factory to create a card directly from a Product
  factory ProductCard.fromProduct(Product product) {
    return ProductCard(
      title: product.name,
      price: '£${product.price.toStringAsFixed(2)}',
      imageAssetPath: product.imageAsset,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/product');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Builder(
              builder: (context) {
                // FIX: if there is no image path, show placeholder text box
                if (imageAssetPath == null || imageAssetPath!.isEmpty) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Center(
                      child: Text(
                        'No image attached',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }

                // If an asset path exists, attempt to load it
                return Image.asset(
                  imageAssetPath!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // If the asset is missing or not yet configured, fall back to the same placeholder
                    return Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: Text(
                          'No image attached',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(fontSize: 14, color: Colors.black),
                maxLines: 2,
              ),
              const SizedBox(height: 4),
              Text(
                price,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
