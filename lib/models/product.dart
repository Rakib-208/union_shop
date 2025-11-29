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
    id: 'shirt_checked',
    name: 'Checked Campus Casual Shirt',
    price: 26.00,
    type: ProductType.clothing,
    sizes: ['S', 'M', 'L', 'XL'],
    colours: ['Red Check', 'Blue Check'],
    imageAsset: null, // FIX: no image yet; set real asset path later
  ),

  // 5–6: PANTS
  Product(
    id: 'pants_joggers',
    name: 'Slim Fit Joggers',
    price: 30.00,
    type: ProductType.clothing,
    sizes: ['S', 'M', 'L', 'XL'],
    colours: ['Black', 'Charcoal'],
    imageAsset: null, // FIX: no image yet; set real asset path later
  ),
  Product(
    id: 'pants_cargo',
    name: 'Straight-Leg Cargo Pants',
    price: 35.00,
    type: ProductType.clothing,
    sizes: ['S', 'M', 'L', 'XL'],
    colours: ['Olive', 'Sand'],
    imageAsset: null, // FIX: no image yet; set real asset path later
  ),

  // 7–8: HOODIES
  Product(
    id: 'hoodie_crest',
    name: 'Crest Logo Hoodie',
    price: 40.00,
    type: ProductType.clothing,
    sizes: ['S', 'M', 'L', 'XL'],
    colours: ['Navy', 'Grey'],
    imageAsset: null, // FIX: no image yet; set real asset path later
  ),
  Product(
    id: 'hoodie_oversized',
    name: 'Oversized Fleece Hoodie',
    price: 38.00,
    type: ProductType.clothing,
    sizes: ['S', 'M', 'L', 'XL'],
    colours: ['Forest Green', 'Black'],
    imageAsset: null, // FIX: no image yet; set real asset path later
  ),

  // 9–10: JACKETS
  Product(
    id: 'jacket_windbreaker',
    name: 'Lightweight Windbreaker Jacket',
    price: 45.00,
    type: ProductType.clothing,
    sizes: ['S', 'M', 'L', 'XL'],
    colours: ['Black', 'Teal'],
    imageAsset: null, // FIX: no image yet; set real asset path later
  ),
  Product(
    id: 'jacket_quilted',
    name: 'Quilted Winter Jacket',
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
    colours: ['Black Frame / Black Lens', 'Silver Frame / Blue Lens'],
    imageAsset: null, // FIX: no image yet; set real asset path later
  ),
];
