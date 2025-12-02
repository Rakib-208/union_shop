enum ProductType {
  clothing,
  accessories,
}

class Product {
  final String id;
  final String name;
  final double price;
  final ProductType type;
  final List<String> sizes;
  final List<String> colours;
  final String?
      imageAsset; // FIX: made nullable so products can exist without an image
  final double? salePrice;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.type,
    required this.sizes,
    required this.colours,
    this.imageAsset, // FIX: image is optional; show placeholder text when null
    this.salePrice,
  });

  /// Returns the price the customer actually pays (sale price if present,
  /// otherwise the regular price).
  double get discountPrice => salePrice ?? price;

  /// Returns the percentage discount (e.g. 15.0 for 15% off), or null if
  /// there is no active sale price.
  double? get discountPercentage {
    if (salePrice == null) return null;
    final discount = (price - salePrice!) / price * 100;
    return discount;
  }
}

// NEW: Central product catalogue (12 demo products)
// NOTE: Update imageAsset fields later when you have real files in assets/images/.
const List<Product> allProducts = [
  // 1–2: T-SHIRTS
  Product(
    id: 'tshirt_full_sleeve',
    name: 'Full-Sleeve Portsmouth Tee',
    price: 18.00,
    type: ProductType.clothing,
    sizes: ['S', 'M', 'L', 'XL'],
    colours: ['Navy', 'Black'],
    imageAsset: null, // FIX: no image yet; set real asset path later
  ),
  Product(
    id: 'tshirt_drop_shoulder',
    name: 'Dropped-Shoulder Street Tee',
    price: 16.00,
    type: ProductType.clothing,
    sizes: ['S', 'M', 'L', 'XL'],
    colours: ['White', 'Grey', 'Sand'],
    imageAsset: null, // FIX: no image yet; set real asset path later
  ),

  // 3–4: SHIRTS
  Product(
    id: 'shirt_oxford',
    name: 'Classic Oxford Uni Shirt',
    price: 28.00,
    type: ProductType.clothing,
    sizes: ['S', 'M', 'L', 'XL'],
    colours: ['Light Blue', 'White'],
    imageAsset: null, // FIX: no image yet; set real asset path later
  ),
  Product(
    id: 'shirt_flannel',
    name: 'Checked Flannel Overshirt',
    price: 32.00,
    type: ProductType.clothing,
    sizes: ['S', 'M', 'L', 'XL'],
    colours: ['Red Check', 'Green Check'],
    imageAsset: null, // FIX: no image yet; set real asset path later
  ),

  // 5–6: HOODIES
  Product(
    id: 'hoodie_classic',
    name: 'Classic Uni Hoodie',
    price: 35.00,
    type: ProductType.clothing,
    sizes: ['S', 'M', 'L', 'XL'],
    colours: ['Navy', 'Grey'],
    imageAsset: null, // FIX: no image yet; set real asset path later
  ),
  Product(
    id: 'hoodie_zip',
    name: 'Zip-Up Society Hoodie',
    price: 38.00,
    type: ProductType.clothing,
    sizes: ['S', 'M', 'L', 'XL'],
    colours: ['Black', 'Bottle Green'],
    imageAsset: null, // FIX: no image yet; set real asset path later
  ),

  // 7–8: JOGGERS / TROUSERS
  Product(
    id: 'joggers_relaxed',
    name: 'Relaxed Fit Joggers',
    price: 26.00,
    type: ProductType.clothing,
    sizes: ['S', 'M', 'L', 'XL'],
    colours: ['Charcoal', 'Light Grey'],
    imageAsset: null, // FIX: no image yet; set real asset path later
  ),
  Product(
    id: 'trousers_chino',
    name: 'Smart Chino Trousers',
    price: 30.00,
    type: ProductType.clothing,
    sizes: ['S', 'M', 'L', 'XL'],
    colours: ['Stone', 'Navy'],
    imageAsset: null, // FIX: no image yet; set real asset path later
  ),

  // 9–10: OUTERWEAR
  Product(
    id: 'jacket_windbreaker',
    name: 'Lightweight Campus Windbreaker',
    price: 42.00,
    type: ProductType.clothing,
    sizes: ['S', 'M', 'L', 'XL'],
    colours: ['Black', 'Royal Blue'],
    imageAsset: null, // FIX: no image yet; set real asset path later
  ),
  Product(
    id: 'jacket_puffer',
    name: 'Puffer Jacket',
    price: 55.00,
    type: ProductType.clothing,
    sizes: ['S', 'M', 'L', 'XL'],
    colours: ['Navy', 'Maroon'],
    imageAsset: null, // FIX: no image yet; set real asset path later
  ),

  // 11: CAP
  Product(
    id: 'cap_structured',
    name: 'Structured Campus Cap',
    price: 12.00,
    type: ProductType.accessories,
    sizes: [],
    colours: ['Navy', 'Beige'],
    imageAsset: null, // FIX: no image yet; set real asset path later
  ),

  // 12: SUNGLASSES
  Product(
    id: 'sunglasses_uv_shield',
    name: 'UV-Shield Polarised Sunglasses',
    price: 18.00,
    type: ProductType.accessories,
    sizes: [],
    colours: ['Black', 'Grey'],
    imageAsset: null, // FIX: no image yet; set real asset path later
  ),

  // 13–18: SALE CLOTHING (5–20% off)
  Product(
    id: 'hoodie_logo_pullover_sale',
    name: 'Logo Pullover Hoodie (Sale)',
    price: 28.00,
    type: ProductType.clothing,
    sizes: ['S', 'M', 'L', 'XL'],
    colours: ['Black', 'Ash Grey'],
    imageAsset: null,
    salePrice: 26.60, // 5% off
  ),
  Product(
    id: 'tshirt_graphic_core_sale',
    name: 'Core Graphic Tee (Sale)',
    price: 32.00,
    type: ProductType.clothing,
    sizes: ['S', 'M', 'L', 'XL'],
    colours: ['White', 'Navy'],
    imageAsset: null,
    salePrice: 28.80, // 10% off
  ),
  Product(
    id: 'joggers_tapered_fit_sale',
    name: 'Tapered Joggers (Sale)',
    price: 45.00,
    type: ProductType.clothing,
    sizes: ['S', 'M', 'L', 'XL'],
    colours: ['Charcoal', 'Olive'],
    imageAsset: null,
    salePrice: 38.25, // 15% off
  ),
  Product(
    id: 'jacket_puffer_light_sale',
    name: 'Light Puffer Jacket (Sale)',
    price: 55.00,
    type: ProductType.clothing,
    sizes: ['S', 'M', 'L', 'XL'],
    colours: ['Forest Green', 'Black'],
    imageAsset: null,
    salePrice: 44.00, // 20% off
  ),
  Product(
    id: 'polo_striped_campus_sale',
    name: 'Striped Campus Polo (Sale)',
    price: 22.00,
    type: ProductType.clothing,
    sizes: ['S', 'M', 'L', 'XL'],
    colours: ['Navy / White Stripe'],
    imageAsset: null,
    salePrice: 20.24, // ~8% off
  ),
  Product(
    id: 'shorts_chino_smart_sale',
    name: 'Smart Chino Shorts (Sale)',
    price: 38.00,
    type: ProductType.clothing,
    sizes: ['S', 'M', 'L', 'XL'],
    colours: ['Stone', 'Navy'],
    imageAsset: null,
    salePrice: 33.44, // ~12% off
  ),
];
