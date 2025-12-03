import 'dart:async';
import 'package:flutter/material.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/pages/collection_page.dart';

/// A hero slider that cycles through ProductCat categories (hoodie, tshirt, etc.)
/// and lets the user navigate to a filtered CollectionPage.
class HeroCategorySlider extends StatefulWidget {
  const HeroCategorySlider({super.key});

  @override
  State<HeroCategorySlider> createState() => _HeroCategorySliderState();
}

class _HeroCategorySliderState extends State<HeroCategorySlider> {
  // Configuration for each slide: which ProductCat and what label to show.
  final List<_CategorySlideConfig> _slides = const [
    _CategorySlideConfig(ProductCat.hoodie, 'Hoodie'),
    _CategorySlideConfig(ProductCat.tshirt, 'T-Shirt'),
    _CategorySlideConfig(ProductCat.jacket, 'Jacket'),
    _CategorySlideConfig(ProductCat.shirt, 'Shirt'),
    _CategorySlideConfig(ProductCat.trousers, 'Trousers'),
    _CategorySlideConfig(ProductCat.joggers, 'Joggers'),
    _CategorySlideConfig(ProductCat.cap, 'Cap'),
    _CategorySlideConfig(ProductCat.sunglasses, 'Sunglasses'),
    _CategorySlideConfig(ProductCat.bag, 'Bag'),
  ];

  int _currentIndex = 0;
  Timer? _autoSlideTimer;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    super.dispose();
  }

  void _startAutoSlide() {
    // Optional auto-slide every 3 seconds. Loops back after the last slide.
    _autoSlideTimer?.cancel();
    _autoSlideTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted) return;
      setState(() {
        _currentIndex = (_currentIndex + 1) % _slides.length;
      });
    });
  }

  void _goToPrevious() {
    setState(() {
      if (_currentIndex == 0) {
        _currentIndex = _slides.length - 1;
      } else {
        _currentIndex--;
      }
    });
  }

  void _goToNext() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _slides.length;
    });
  }

  /// Find the first product in allProducts that matches this ProductCat.
  /// This lets us show a relevant image for each slide if available.
  Product? _firstProductForCat(ProductCat cat) {
    for (final product in allProducts) {
      if (product.cat == cat) return product;
    }
    return null;
  }

  /// Map ProductCat to a suitable title for the CollectionPage & ProductType.
  _CollectionTarget _buildCollectionTarget(ProductCat cat) {
    switch (cat) {
      case ProductCat.hoodie:
        return const _CollectionTarget(
          title: 'Hoodies',
          type: ProductType.clothing,
        );
      case ProductCat.tshirt:
        return const _CollectionTarget(
          title: 'T-Shirts',
          type: ProductType.clothing,
        );
      case ProductCat.jacket:
        return const _CollectionTarget(
          title: 'Jackets',
          type: ProductType.clothing,
        );
      case ProductCat.shirt:
        return const _CollectionTarget(
          title: 'Shirts',
          type: ProductType.clothing,
        );
      case ProductCat.trousers:
        return const _CollectionTarget(
          title: 'Trousers',
          type: ProductType.clothing,
        );
      case ProductCat.joggers:
        return const _CollectionTarget(
          title: 'Joggers',
          type: ProductType.clothing,
        );
      case ProductCat.cap:
        return const _CollectionTarget(
          title: 'Caps',
          type: ProductType.accessories,
        );
      case ProductCat.sunglasses:
        return const _CollectionTarget(
          title: 'Sunglasses',
          type: ProductType.accessories,
        );
      case ProductCat.bag:
        return const _CollectionTarget(
          title: 'Bags',
          type: ProductType.accessories,
        );
    }
  }

  void _onCategoryButtonPressed(BuildContext context, ProductCat cat) {
    final target = _buildCollectionTarget(cat);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CollectionPage(
          title: target.title,
          typeFilter: target.type,
          catFilter: cat,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final slide = _slides[_currentIndex];
    final productForSlide = _firstProductForCat(slide.cat);
    final imagePath = productForSlide?.defaultImage;

    final theme = Theme.of(context);
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      height: isMobile ? 360 : 420,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 32,
        vertical: isMobile ? 16 : 24,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary.withOpacity(0.08),
            theme.colorScheme.primary.withOpacity(0.02),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Shop by Category',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Main slide content: centered image with overlay text + button
          Expanded(
            child: Center(
              child: AspectRatio(
                aspectRatio: isMobile ? 4 / 3 : 16 / 9,
                child: Stack(
                  children: [
                    // Full image background
                    Positioned.fill(
                      child: _SlideImagePreview(imagePath: imagePath),
                    ),

                    // Top-left title text
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Discover ${slide.label}',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    // Bottom-center button on top of the image
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          onPressed: () =>
                              _onCategoryButtonPressed(context, slide.cat),
                          child: Text(slide.label),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Dots + Previous / Next buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Previous button
              IconButton(
                onPressed: _goToPrevious,
                icon: const Icon(Icons.arrow_back),
                tooltip: 'Previous category',
              ),

              // Dots in the middle
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(_slides.length, (index) {
                  final isActive = index == _currentIndex;
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: isActive ? 10 : 8,
                    height: isActive ? 10 : 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isActive
                          ? theme.colorScheme.primary
                          : Colors.grey.shade400,
                    ),
                  );
                }),
              ),

              // Next button
              IconButton(
                onPressed: _goToNext,
                icon: const Icon(Icons.arrow_forward),
                tooltip: 'Next category',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CategorySlideConfig {
  final ProductCat cat;
  final String label;

  const _CategorySlideConfig(this.cat, this.label);
}

class _CollectionTarget {
  final String title;
  final ProductType type;

  const _CollectionTarget({
    required this.title,
    required this.type,
  });
}

class _SlideImagePreview extends StatelessWidget {
  final String? imagePath;

  const _SlideImagePreview({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    if (imagePath == null) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: const Center(
          child: Text('No image available'),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(
        imagePath!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.white,
            child: const Center(
              child: Text('Image not found'),
            ),
          );
        },
      ),
    );
  }
}
