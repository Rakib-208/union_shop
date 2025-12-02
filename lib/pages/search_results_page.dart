import 'package:flutter/material.dart';

import 'package:union_shop/widgets/app_header.dart';
import 'package:union_shop/widgets/footer.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/widgets/product_card.dart' show ProductCard;

class SearchResultsPage extends StatelessWidget {
  final String query;

  const SearchResultsPage({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    // Get all matching products for this query.
    final results = _searchProducts(query);

    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: Column(
        children: [
          const AppHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Search results for "$query"',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      results.isEmpty
                          ? 'No products matched your search. Try different words like "hoodie" or "tee".'
                          : '${results.length} product(s) found.',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    if (results.isEmpty)
                      const SizedBox.shrink()
                    else
                      _SearchResultsGrid(products: results, isMobile: isMobile),
                    const SizedBox(height: 24),
                    const Footer(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Grid of product cards for search results.
class _SearchResultsGrid extends StatelessWidget {
  final List<Product> products;
  final bool isMobile;

  const _SearchResultsGrid({
    required this.products,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    int crossAxisCount = 2;
    if (width >= 900) {
      crossAxisCount = 4;
    } else if (width >= 600) {
      crossAxisCount = 3;
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCard.fromProduct(product);
      },
    );
  }
}

/// Run a search against allProducts using a fuzzy-ish match.
List<Product> _searchProducts(String rawQuery) {
  final query = rawQuery.trim().toLowerCase();
  if (query.isEmpty) {
    return [];
  }

  // Split the user input into separate words: "mans tshirt" → ["mans", "tshirt"]
  final terms = query
      .split(RegExp(r'\s+'))
      .map((t) => t.trim())
      .where((t) => t.isNotEmpty)
      .toList();

  if (terms.isEmpty) {
    return [];
  }

  // We'll give each product a "score" based on how many terms match.
  final List<_ScoredProduct> scored = [];

  for (final product in allProducts) {
    // Build a big searchable text block from the product's attributes.
    final parts = <String>[
      product.name,
      product.type.name,
      product.category.name,
      product.cat.name,
      ...product.sizes,
      ...product.colours,
    ];

    final combined = parts.join(' ').toLowerCase();

    int score = 0;

    for (final term in terms) {
      if (_doesTermMatchProduct(combined, term)) {
        score++;
      }
    }

    if (score > 0) {
      scored.add(_ScoredProduct(product: product, score: score));
    }
  }

  // Sort by score (best matches first), then by name.
  scored.sort((a, b) {
    if (b.score != a.score) {
      return b.score.compareTo(a.score);
    }
    return a.product.name.compareTo(b.product.name);
  });

  return scored.map((s) => s.product).toList();
}

class _ScoredProduct {
  final Product product;
  final int score;

  _ScoredProduct({required this.product, required this.score});
}

/// Decide if a single search word matches a product's combined text.
bool _doesTermMatchProduct(String combined, String rawTerm) {
  final haystack = _normalise(combined);
  final term = _normalise(rawTerm);

  if (term.isEmpty || haystack.isEmpty) {
    return false;
  }

  // Direct contains: easy case
  if (haystack.contains(term)) {
    return true;
  }

  // Handle plural/singular: mans → man, tees → tee, etc.
  if (term.endsWith('s')) {
    final singular = term.substring(0, term.length - 1);
    if (singular.isNotEmpty && haystack.contains(singular)) {
      return true;
    }
  }

  // Specific human-friendly tweaks:
  // "mans" or "man" → match "men" / "mens"
  if (term == 'mans' || term == 'man') {
    if (haystack.contains('men') || haystack.contains('mens')) {
      return true;
    }
  }

  // "mens" → match "men"
  if (term == 'mens') {
    if (haystack.contains('men')) {
      return true;
    }
  }

  // "tshirt" / "t-shirt" / "tee" → all considered similar
  if (term == 'tshirt' || term == 'tee') {
    if (haystack.contains('tshirt') ||
        haystack.contains('tshirt') ||
        haystack.contains('tee')) {
      return true;
    }
  }

  return false;
}

/// Normalise text so that "T-Shirt", "t shirt" and "tshirt" all look similar.
String _normalise(String text) {
  return text
      .toLowerCase()
      // Remove spaces and punctuation so "t-shirt" and "t shirt" become "tshirt"
      .replaceAll(RegExp(r'[^a-z0-9]'), '');
}
