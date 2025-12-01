import 'package:flutter/material.dart';
import 'package:union_shop/models/product.dart';        // adjust path if your model is elsewhere

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

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/product',
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
            // Image
            AspectRatio(
              aspectRatio: 4 / 3,
              child: _buildImage(),
            ),
            // Text + price
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  _buildPriceRow(theme),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (product.imageAsset == null) {
      return Container(
        alignment: Alignment.center,
        child: const Text('No image attached'),
      );
    }

    return Image.asset(
      product.imageAsset!,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stack) {
        return const Center(child: Text('No image attached'));
      },
    );
  }

  Widget _buildPriceRow(ThemeData theme) {
    final hasSale = product.salePrice != null;
    final salePrice = product.salePrice;
    final basePrice = product.price;

    if (!hasSale) {
      return Text(
        '£${basePrice.toStringAsFixed(2)}',
        style: theme.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: const Color(0xFF4D2963),
        ),
      );
    }

    final effective = salePrice!;
    final discountPercent =
        ((1 - (effective / basePrice)) * 100).round();

    return Row(
      children: [
        Text(
          '£${effective.toStringAsFixed(2)}',
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.redAccent,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '£${basePrice.toStringAsFixed(2)}',
          style: theme.textTheme.bodySmall?.copyWith(
            decoration: TextDecoration.lineThrough,
            color: Colors.grey,
          ),
        ),
        const SizedBox(width: 6),
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.redAccent.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '-$discountPercent%',
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.redAccent,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

