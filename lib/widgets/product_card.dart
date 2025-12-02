import 'package:flutter/material.dart';
import 'package:union_shop/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  // Convenience factory if you ever use ProductCard.fromProduct(product)
  factory ProductCard.fromProduct(Product product) {
    return ProductCard(product: product);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final bool hasSale = product.salePrice != null;
    final int? discountPercent = product.discountPercentage?.round();

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image + sale badge at the top
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 4 / 3,
                child: _buildProductImage(),
              ),
              if (hasSale && discountPercent != null)
                Positioned(
                  top: 8,
                  right: 8,
                  child: _buildSaleBadge(context, discountPercent),
                ),
            ],
          ),

          // Spacing between image and text
          const SizedBox(height: 8),

          // Name + pricing
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product name
                Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),

                // Pricing row (sale price + original if on sale)
                Row(
                  children: [
                    // Discounted or normal price
                    Text(
                      '£${product.discountPrice.toStringAsFixed(2)}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (hasSale) ...[
                      const SizedBox(width: 6),
                      Text(
                        '£${product.price.toStringAsFixed(2)}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }

  /// Builds the main product image for the card.
  ///
  /// Uses [product.defaultImage] so it follows the same logic as ProductPage:
  /// - Prefer the first colour's image (id + colour index)
  /// - Fall back to [imageAsset] if set
  /// - If nothing is available or the file is missing, show a placeholder.
  Widget _buildProductImage() {
    final String? imagePath = product.defaultImage;

    // If there is no usable image path, show a neutral placeholder.
    if (imagePath == null || imagePath.isEmpty) {
      return Container(
        color: Colors.grey.shade200,
        child: const Center(
          child: Icon(
            Icons.image_not_supported_outlined,
            color: Colors.grey,
            size: 32,
          ),
        ),
      );
    }

    // Try to load the asset. If the file doesn't exist,
    // fall back to the same placeholder.
    return Image.asset(
      imagePath,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.grey.shade200,
          child: const Center(
            child: Icon(
              Icons.image_not_supported_outlined,
              color: Colors.grey,
              size: 32,
            ),
          ),
        );
      },
    );
  }

  /// Small red discount badge shown on the image when the product is on sale.
  Widget _buildSaleBadge(BuildContext context, int discountPercent) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.redAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.redAccent,
          width: 1,
        ),
      ),
      child: Text(
        '-$discountPercent%',
        style: theme.textTheme.bodySmall?.copyWith(
          color: Colors.redAccent,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
