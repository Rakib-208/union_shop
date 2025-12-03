import 'package:flutter/material.dart';
import 'package:union_shop/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  factory ProductCard.fromProduct(Product product) {
    return ProductCard(product: product);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool hasSale = product.salePrice != null;
    final int? discountPercent = product.discountPercentage?.round();

    return InkWell(
      onTap: () {
        // Navigate to the product page when the card is tapped
        Navigator.of(context).pushNamed(
          '/product/${product.id}',
          arguments: product,
        );
      },
      child: Card(
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
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

                  // Pricing row
                  _buildPriceRow(theme),
                ],
              ),
            ),

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  /// Main product image for the card.
  /// Uses product.defaultImage so it stays in sync with ProductPage logic.
  Widget _buildProductImage() {
    final String? imagePath = product.defaultImage;

    // If there is no usable image path, show a simple placeholder.
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
    // fall back to the same placeholder instead of crashing.
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

  /// Shows the price row:
  /// - If not on sale: just the base price.
  /// - If on sale: sale price + original crossed out.
  Widget _buildPriceRow(ThemeData theme) {
    final bool hasSale = product.salePrice != null;
    final double basePrice = product.price;
    final double? salePrice = product.salePrice;

    if (!hasSale || salePrice == null) {
      // No sale: just show the normal price
      return Text(
        '£${basePrice.toStringAsFixed(2)}',
        style: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      );
    }

    // On sale: show sale price + original price crossed out
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '£${salePrice.toStringAsFixed(2)}',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            '£${basePrice.toStringAsFixed(2)}',
            style: theme.textTheme.bodySmall?.copyWith(
              decoration: TextDecoration.lineThrough,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  /// Small red discount badge used over the image, e.g. "-20%".
  Widget _buildSaleBadge(BuildContext context, int discountPercent) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        // Using withValues to avoid the deprecation warning on withOpacity.
        color: Colors.redAccent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
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
