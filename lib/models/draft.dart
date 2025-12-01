// Product model and catalogue

enum ProductType {
  clothing,
  accessories,
}

enum ProductCategory {
  mens,
  womens,
  unisex,
}

enum ProductCat {
  hoodie,
  tshirt,
  jacket,
  shirt,
  trousers,
  joggers,
  cap,
  sunglasses,
  bag,
}

// Centralised allowed colour palette.
// Colours accessed by index.
const List<String> kProductColours = [
  'Red', // 0
  'Blue', // 1
  'Black', // 2
  'White', // 3
  'Green', // 4
  'Orange', // 5
  'Brown', // 6
  'Gray', // 7
];

class Product {
  final int id;
  final String name;
  final double price;
  final ProductType type;
  final ProductCategory category;
  final ProductCat cat;
  final List<String> sizes;

  /// Numeric list mapping to kProductColours.
  final List<int> colours;

  /// Optional manual/legacy image asset path.
  final String? imageAsset;

  final double? salePrice;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.type,
    required this.category,
    required this.cat,
    required this.sizes,
    required this.colours,
    this.imageAsset,
    this.salePrice,
  });

  // ---------------- EXISTING GETTERS (unchanged) ----------------

  List<String> get colourNames =>
      colours.map((i) => kProductColours[i]).toList();

  /// Returns the active price: sale price if present, otherwise base price.
  double get discountPrice => salePrice ?? price;

  /// Returns the discount percentage if a sale price exists, otherwise null.
  double? get discountPercentage {
    if (salePrice == null) return null;
    final discount = (price - salePrice!) / price * 100;
    return discount;
  }

  // ---------------- NEW IMAGE HELPERS (non-breaking) ----------------

  /// Base folder where product images are stored.
  /// Files are expected to live under: lib/assets/images
  static const String _imageFolder = 'lib/assets/images';

  /// Internal helper to build a single image path for a given colour code
  /// and extension.
  String _buildImagePath(int colourCode, String extension) {
    return '$_imageFolder/${id}_$colourCode.$extension';
  }

  /// Returns a list of candidate asset paths for the given colour code,
  /// trying .png, .jpg, .jpeg in that order.
  ///
  /// Example for product id 1 and colourCode 2:
  /// - lib/assets/images/1_2.png
  /// - lib/assets/images/1_2.jpg
  /// - lib/assets/images/1_2.jpeg
  List<String> imageAssetsForColour(int colourCode) {
    return [
      _buildImagePath(colourCode, 'png'),
      _buildImagePath(colourCode, 'jpg'),
      _buildImagePath(colourCode, 'jpeg'),
    ];
  }

  /// Convenience getter for a “primary” image for a specific colour.
  /// By default assumes .png.
  ///
  /// On your product page, when a user selects a colour (using its colour code
  /// from kProductColours / colours list), you can call:
  ///   product.primaryImageForColour(selectedColourCode)
  /// and use that string in Image.asset().
  String primaryImageForColour(int colourCode, {String extension = 'png'}) {
    return _buildImagePath(colourCode, extension);
  }

  /// Default image for this product:
  /// - If there is at least one colour, use the first colour's primary image.
  /// - Otherwise fall back to the legacy imageAsset field.
  String? get defaultImage {
    if (colours.isNotEmpty) {
      return primaryImageForColour(colours.first);
    }
    return imageAsset;
  }
}

// Product catalogue
const List<Product> allProducts = [
  Product(
    id: 0,
    name: 'Full-Sleeve Portsmouth Tee',
    price: 18.00,
    type: ProductType.clothing,
    category: ProductCategory.mens,
    cat: ProductCat.tshirt,
    sizes: ['S', 'M', 'L', 'XL'],
    colours: [
      1, // Blue
      2, // Black
    ],
    imageAsset: null,
  ),
  Product(
    id: 1,
    name: 'Union Logo Hoodie',
    price: 40.00,
    type: ProductType.clothing,
    category: ProductCategory.unisex,
    cat: ProductCat.hoodie,
    sizes: ['S', 'M', 'L', 'XL'],
    colours: [
      1, // Blue
      4, // Green
      2, // Black
    ],
    imageAsset: null,
    salePrice: 32.00,
  ),
];
