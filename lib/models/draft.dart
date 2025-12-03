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

const List<String> kProductColours = <String>[
  'Navy',
  'Black',
  'Grey',
  'Red',
  'Green',
  'White',
];

class Product {
  int id;
  String name;
  ProductCategory category;
  ProductCat cat;
  List<String> colours;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.cat,
    required this.colours,
  });
}

final List<Product> allProducts = <Product>[
  Product(
    id: 0,
    name: 'Portsmouth Crest T-Shirt',
    category: ProductCategory.mens,
    cat: ProductCat.tshirt,
    colours: <String>[
      'Navy',
      'Black',
    ],
  ),
  Product(
    id: 1,
    name: 'Union Classic Hoodie',
    category: ProductCategory.unisex,
    cat: ProductCat.hoodie,
    colours: <String>[
      'Navy',
      'Green',
    ],
  ),
  Product(
    id: 2,
    name: 'Harbour Stripe T-Shirt',
    category: ProductCategory.womens,
    cat: ProductCat.tshirt,
    colours: <String>[
      'White',
      'Grey',
    ],
  ),
  Product(
    id: 3,
    name: 'Campus Zip Hoodie',
    category: ProductCategory.mens,
    cat: ProductCat.hoodie,
    colours: <String>[
      'Black',
      'Grey',
    ],
  ),
  Product(
    id: 4,
    name: 'Freshers Week T-Shirt',
    category: ProductCategory.unisex,
    cat: ProductCat.tshirt,
    colours: <String>[
      'Red',
      'White',
    ],
  ),
  Product(
    id: 5,
    name: 'Alumni Script T-Shirt',
    category: ProductCategory.mens,
    cat: ProductCat.tshirt,
    colours: <String>[
      'Navy',
    ],
  ),
  Product(
    id: 6,
    name: 'Seaside Oversized T-Shirt',
    category: ProductCategory.womens,
    cat: ProductCat.tshirt,
    colours: <String>[
      'Grey',
      'White',
    ],
  ),
  Product(
    id: 7,
    name: 'Varsity Letterman Jacket',
    category: ProductCategory.unisex,
    cat: ProductCat.jacket,
    colours: <String>[
      'Navy',
      'Red',
    ],
  ),
  Product(
    id: 8,
    name: 'Windbreaker Shell Jacket',
    category: ProductCategory.mens,
    cat: ProductCat.jacket,
    colours: <String>[
      'Grey',
      'Black',
    ],
  ),
  Product(
    id: 9,
    name: 'Heritage Denim Jacket',
    category: ProductCategory.womens,
    cat: ProductCat.jacket,
    colours: <String>[
      'Black',
      'White',
    ],
  ),
  Product(
    id: 10,
    name: 'Oxford Check Shirt',
    category: ProductCategory.mens,
    cat: ProductCat.shirt,
    colours: <String>[
      'Grey',
      'Navy',
    ],
  ),
  Product(
    id: 11,
    name: 'Signature Poplin Shirt',
    category: ProductCategory.womens,
    cat: ProductCat.shirt,
    colours: <String>[
      'White',
    ],
  ),
  Product(
    id: 12,
    name: 'Relaxed Flannel Shirt',
    category: ProductCategory.unisex,
    cat: ProductCat.shirt,
    colours: <String>[
      'Red',
      'Grey',
    ],
  ),
  Product(
    id: 13,
    name: 'Everyday Chino Trousers',
    category: ProductCategory.mens,
    cat: ProductCat.trousers,
    colours: <String>[
      'Grey',
    ],
  ),
  Product(
    id: 14,
    name: 'High-Rise Campus Trousers',
    category: ProductCategory.womens,
    cat: ProductCat.trousers,
    colours: <String>[
      'Black',
      'White',
    ],
  ),
  Product(
    id: 15,
    name: 'Unisex Utility Trousers',
    category: ProductCategory.unisex,
    cat: ProductCat.trousers,
    colours: <String>[
      'Navy',
      'Grey',
    ],
  ),
  Product(
    id: 16,
    name: 'Fleece Joggers',
    category: ProductCategory.mens,
    cat: ProductCat.joggers,
    colours: <String>[
      'Black',
    ],
  ),
  Product(
    id: 17,
    name: 'Cuffed Lounge Joggers',
    category: ProductCategory.womens,
    cat: ProductCat.joggers,
    colours: <String>[
      'Green',
      'White',
    ],
  ),
  Product(
    id: 18,
    name: 'Sport Tech Joggers',
    category: ProductCategory.unisex,
    cat: ProductCat.joggers,
    colours: <String>[
      'Navy',
      'Red',
    ],
  ),
  Product(
    id: 19,
    name: 'Campus Baseball Cap',
    category: ProductCategory.unisex,
    cat: ProductCat.cap,
    colours: <String>[
      'Navy',
      'White',
    ],
  ),
  Product(
    id: 20,
    name: 'Heritage Wool Beanie',
    category: ProductCategory.mens,
    cat: ProductCat.cap,
    colours: <String>[
      'Grey',
      'Black',
    ],
  ),
  Product(
    id: 21,
    name: 'Logo Dad Cap',
    category: ProductCategory.womens,
    cat: ProductCat.cap,
    colours: <String>[
      'Red',
    ],
  ),
  Product(
    id: 22,
    name: 'Retro Round Sunglasses',
    category: ProductCategory.unisex,
    cat: ProductCat.sunglasses,
    colours: <String>[
      'Black',
    ],
  ),
  Product(
    id: 23,
    name: 'Sport Shield Sunglasses',
    category: ProductCategory.mens,
    cat: ProductCat.sunglasses,
    colours: <String>[
      'Navy',
      'Grey',
    ],
  ),
  Product(
    id: 24,
    name: 'Tortoiseshell Sunglasses',
    category: ProductCategory.womens,
    cat: ProductCat.sunglasses,
    colours: <String>[
      'Black',
      'White',
    ],
  ),
  Product(
    id: 25,
    name: 'Everyday Canvas Tote Bag',
    category: ProductCategory.unisex,
    cat: ProductCat.bag,
    colours: <String>[
      'White',
      'Navy',
    ],
  ),
  Product(
    id: 26,
    name: 'Padded Laptop Backpack',
    category: ProductCategory.mens,
    cat: ProductCat.bag,
    colours: <String>[
      'Black',
      'Grey',
    ],
  ),
  Product(
    id: 27,
    name: 'Mini Crossbody Bag',
    category: ProductCategory.womens,
    cat: ProductCat.bag,
    colours: <String>[
      'Red',
      'White',
    ],
  ),
  Product(
    id: 28,
    name: 'Graphic Crest T-Shirt',
    category: ProductCategory.unisex,
    cat: ProductCat.tshirt,
    colours: <String>[
      'Navy',
      'Red',
    ],
  ),
  Product(
    id: 29,
    name: 'Half-Zip Fleece Hoodie',
    category: ProductCategory.mens,
    cat: ProductCat.hoodie,
    colours: <String>[
      'Grey',
      'Green',
    ],
  ),
];
