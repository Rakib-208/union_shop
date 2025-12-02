// High-level type: is this clothing or an accessory?
enum ProductType {
  clothing,
  accessories,
}

// Who is this mainly for?
enum ProductCategory {
  mens,
  womens,
  unisex,
}

// What specific kind of item is it?
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

// Central list of colour names used across the app.
// The index (position) acts as the "colour code":
// 0 -> 'Navy', 1 -> 'Black', 2 -> 'Grey', ...
const List<String> kProductColours = <String>[
  'Navy', // 0
  'Black', // 1
  'Grey', // 2
  'Red', // 3
  'Green', // 4
  'White', // 5
];

class Product {
  // We use an integer ID now (0, 1, 2, ...).
  // This is used in URLs and for building image file names.
  final int id;

  // Human-readable product name shown in the UI.
  final String name;

  // Base price of the product (before any discount).
  final double price;

  // High-level type (clothing vs accessories).
  final ProductType type;

  // Who it is for (mens / womens / unisex).
  final ProductCategory category;

  // Specific type of item (tshirt, hoodie, bag, etc.).
  final ProductCat cat;

  // Available sizes (e.g. ['S', 'M', 'L', 'XL']).
  final List<String> sizes;

  // Available colours as NAMES (e.g. ['Navy', 'Black']).
  // We keep this as List<String> so your existing filters
  // like product.colours.contains('Navy') still work.
  final List<String> colours;

  // Optional manual image asset path, e.g. 'assets/images/manual.png'.
  // This stays nullable so products can genuinely have "no image attached".
  final String? imageAsset;

  // Optional sale price. If present, it represents the discounted price.
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

  /// The price that should be used when selling:
  /// - salePrice if there is a sale
  /// - otherwise the normal price
  double get discountPrice => salePrice ?? price;

  /// Percentage discount, e.g. 20.0 means "20% off".
  /// Returns null if there is no sale.
  double? get discountPercentage {
    if (salePrice == null) return null;
    if (price == 0) return null;
    final discount = 1 - (salePrice! / price);
    return discount * 100;
  }

  // Base folder for images. You said you keep them in assets/images at the root.
  static const String _imageFolder = 'assets/images';

  /// Find the index of a colour name in our central colour list.
  /// For example: 'Navy' -> 0, 'Black' -> 1.
  /// Returns null if the colour name is not in kProductColours.
  int? _colourIndexFromName(String colourName) {
    final index = kProductColours.indexOf(colourName);
    if (index == -1) return null;
    return index;
  }

  /// Build a single image path given a colour NAME and file extension.
  ///
  /// Example:
  ///   id = 1, colourName = 'Navy' (index 0), extension = 'png'
  ///   -> 'assets/images/1_0.png'
  String? _buildImagePathFromColourName(String colourName, String extension) {
    final colourIndex = _colourIndexFromName(colourName);
    if (colourIndex == null) return null;
    return '$_imageFolder/${id}_$colourIndex.$extension';
  }

  /// Return multiple possible image paths for a given colour name,
  /// trying different file extensions (png, jpg, jpeg).
  ///
  /// This can be useful later if you want to probe which one exists.
  List<String> candidateImagePathsForColourName(String colourName) {
    final paths = <String>[];

    final png = _buildImagePathFromColourName(colourName, 'png');
    final jpg = _buildImagePathFromColourName(colourName, 'jpg');
    final jpeg = _buildImagePathFromColourName(colourName, 'jpeg');

    if (png != null) paths.add(png);
    if (jpg != null) paths.add(jpg);
    if (jpeg != null) paths.add(jpeg);

    return paths;
  }

  /// Build a single primary image path for a given colour name.
  /// By default it assumes a PNG file.
  String? primaryImageForColourName(
    String colourName, {
    String extension = 'png',
  }) {
    return _buildImagePathFromColourName(colourName, extension);
  }

  /// Default image to use for this product:
  /// - If there are colours, we try the FIRST colour's image
  /// - If that fails, we fall back to [imageAsset]
  ///
  /// In the UI, we will still check for null before calling Image.asset,
  /// so products with no real image will continue to show "No image attached".
  String? get defaultImage {
    if (colours.isNotEmpty) {
      final candidate = primaryImageForColourName(colours.first);
      if (candidate != null) {
        return candidate;
      }
    }
    return imageAsset;
  }
}

/// Temporary catalogue with only two products for testing.
/// Later we can use AI / bulk generation to extend this.
const List<Product> allProducts = <Product>[
  Product(
    id: 0,
    name: 'Full-Sleeve Portsmouth Tee',
    price: 18.00,
    type: ProductType.clothing,
    category: ProductCategory.mens,
    cat: ProductCat.tshirt,
    sizes: <String>['S', 'M', 'L', 'XL'],
    colours: <String>[
      'Navy', // matches kProductColours[0]
      'Black', // matches kProductColours[1]
    ],
    imageAsset: null, // no manual image assigned yet
  ),
  Product(
    id: 1,
    name: 'Union Logo Hoodie',
    price: 40.00,
    type: ProductType.clothing,
    category: ProductCategory.unisex,
    cat: ProductCat.hoodie,
    sizes: <String>['S', 'M', 'L', 'XL'],
    colours: <String>[
      'Navy', // 0
      'Green', // 4
      'Black', // 1
    ],
    imageAsset: null,
    salePrice: 32.00, // on sale!
  ),
];
