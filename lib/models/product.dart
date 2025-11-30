// NEW: Shared product model and in-memory catalogue for the Union Shop app.
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

  double get discountPrice => salePrice ?? price;
}

// NEW: Central product catalogue (12 demo products)
// NOTE: Update imageAsset fields later when you have real files in assets/images/.
const List<Product> allProducts = [
  // 1–2: T-SHIRTS
  Product(
    id: 'tshirt_full_sleeve',
    name: 'Full Sleeve Campus Tee',
    price: 24.99,
    type: ProductType.clothing,
    sizes: ['S', 'M', 'L', 'XL'],
    colours: ['Navy', 'Black', 'Maroon'],
    imageAsset:
        'assets/images/tshirt_full_sleeve.png', // FIX: sample path, replace with your own
  ),
  Product(
    id: 'tshirt_half_sleeve',
    name: 'Half Sleeve Logo Tee',
    price: 19.99,
    type: ProductType.clothing,
    sizes: ['S', 'M', 'L', 'XL'],
    colours: ['White', 'Grey', 'Sky Blue'],
    imageAsset: 'assets/images/tshirt_half_sleeve.png',
  ),

  // 3–4: HOODIES
  Product(
    id: 'hoodie_zipup',
    name: 'Zip-Up Hoodie',
    price: 34.99,
    type: ProductType.clothing,
    sizes: ['S', 'M', 'L', 'XL'],
    colours: ['Black', 'Charcoal'],
    imageAsset: 'assets/images/hoodie_zipup.png',
  ),
  Product(
    id: 'hoodie_pullover',
    name: 'Pullover Hoodie',
    price: 32.50,
    type: ProductType.clothing,
    sizes: ['S', 'M', 'L', 'XL'],
    colours: ['Navy', 'Bottle Green'],
    imageAsset: 'assets/images/hoodie_pullover.png',
  ),

  // 5–6: JACKETS
  Product(
    id: 'jacket_windbreaker',
    name: 'Light Windbreaker Jacket',
    price: 39.99,
    type: ProductType.clothing,
    sizes: ['S', 'M', 'L', 'XL'],
    colours: ['Red', 'Black'],
    imageAsset: 'assets/images/jacket_windbreaker.png',
  ),
  Product(
    id: 'jacket_puffer',
    name: 'Puffer Jacket',
    price: 59.99,
    type: ProductType.clothing,
    sizes: ['S', 'M', 'L', 'XL'],
    colours: ['Navy', 'Olive'],
    imageAsset: 'assets/images/jacket_puffer.png',
  ),

  // 7–8: TROUSERS / JOGGERS
  Product(
    id: 'joggers_slimfit',
    name: 'Slim Fit Joggers',
    price: 27.50,
    type: ProductType.clothing,
    sizes: ['S', 'M', 'L', 'XL'],
    colours: ['Black', 'Charcoal'],
    imageAsset: 'assets/images/joggers_slimfit.png',
  ),
  Product(
    id: 'trousers_chino',
    name: 'Chino Trousers',
    price: 35.00,
    type: ProductType.clothing,
    sizes: ['S', 'M', 'L', 'XL'],
    colours: ['Khaki', 'Navy'],
    imageAsset: 'assets/images/trousers_chino.png',
  ),

  // 9–10: CAPS / HATS
  Product(
    id: 'cap_baseball',
    name: 'Baseball Cap',
    price: 12.99,
    type: ProductType.accessories,
    sizes: ['One Size'],
    colours: ['Black', 'Navy', 'Burgundy'],
    imageAsset: 'assets/images/cap_baseball.png',
  ),
  Product(
    id: 'beanie_winter',
    name: 'Winter Beanie',
    price: 14.50,
    type: ProductType.accessories,
    sizes: ['One Size'],
    colours: ['Grey', 'Black'],
    imageAsset: 'assets/images/beanie_winter.png',
  ),

  // 11: TOTE BAG
  Product(
    id: 'bag_tote',
    name: 'Canvas Tote Bag',
    price: 9.99,
    type: ProductType.accessories,
    sizes: ['One Size'],
    colours: ['Natural', 'Black Print'],
    imageAsset: 'assets/images/bag_tote.png',
  ),

  // 12: SUNGLASSES
  Product(
    id: 'sunglasses_uv_shield',
    name: 'UV-Shield Polarised Sunglasses',
    price: 18.00,
    type: ProductType.accessories,
    sizes: [],
    colours: ['Black Frame / Black Lens', 'Silver Frame / Blue Lens'],
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
    salePrice: 20.24, // 8% off
  ),

  Product(
    id: 'shorts_chino_smart_sale',
    name: 'Smart Chino Shorts (Sale)',
    price: 38.00,
    type: ProductType.clothing,
    sizes: ['S', 'M', 'L', 'XL'],
    colours: ['Stone', 'Navy'],
    imageAsset: null,
    salePrice: 33.44, // 12% off
  ),
];
