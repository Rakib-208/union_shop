import 'package:flutter/foundation.dart';
import 'package:union_shop/models/product.dart';

/// One line in the shopping cart.
/// Example: 3 × Navy / M / Hoodie
class CartItem {
  final Product product;
  final String size;
  final String colour;

  /// How many of this exact combo (product + size + colour)
  int quantity;

  CartItem({
    required this.product,
    required this.size,
    required this.colour,
    required this.quantity,
  });

  /// The price for one item (uses sale price if there is one)
  double get unitPrice => product.discountPrice;

  /// Total price for this line: unit price × quantity
  double get lineTotal => unitPrice * quantity;

  /// Helper: does this cart item represent the same configuration?
  bool isSameConfiguration(
      Product otherProduct, String otherSize, String otherColour) {
    return product.id == otherProduct.id &&
        size == otherSize &&
        colour == otherColour;
  }
}

/// The whole cart (all items).
/// This is the "shopping basket" logic.
class CartModel extends ChangeNotifier {
  final List<CartItem> _items = [];

  /// Read-only view of items so outside code can't modify the list directly.
  List<CartItem> get items => List.unmodifiable(_items);

  /// Add an item to the cart.
  ///
  /// If the same product + size + colour is already in the cart, we just
  /// increase its quantity.
  /// Otherwise we create a new CartItem line.
  void addItem(Product product, String size, String colour, int quantity) {
    // Try to find an existing line with the same configuration
    final existingIndex = _items.indexWhere(
      (item) => item.isSameConfiguration(product, size, colour),
    );

    if (existingIndex != -1) {
      // Same product + size + colour already in cart → add to its quantity
      _items[existingIndex].quantity += quantity;
    } else {
      // New combination → create a new line in the cart
      _items.add(
        CartItem(
          product: product,
          size: size,
          colour: colour,
          quantity: quantity,
        ),
      );
    }

    // Tell the UI that something changed
    notifyListeners();
  }

  /// Update the quantity of a specific CartItem.
  ///
  /// If newQuantity is less than 1, we remove the item from the cart.
  void updateItemQuantity(CartItem item, int newQuantity) {
    if (newQuantity < 1) {
      removeItem(item);
      return;
    }

    final index = _items.indexOf(item);
    if (index != -1) {
      _items[index].quantity = newQuantity;
      notifyListeners();
    }
  }

  /// Remove a CartItem completely from the cart.
  void removeItem(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }

  /// Remove everything from the cart.
  void clear() {
    _items.clear();
    notifyListeners();
  }

  /// Total number of items in the cart (sum of quantities).
  ///
  /// Example: 2 hoodies + 3 tees = 5 total items.
  int get totalItemCount {
    return _items.fold<int>(0, (sum, item) => sum + item.quantity);
  }

  /// Total price of everything in the cart.
  double get totalPrice {
    return _items.fold<double>(0.0, (sum, item) => sum + item.lineTotal);
  }

  /// True if the cart is empty.
  bool get isEmpty => _items.isEmpty;
}

/// One global cart that the whole app can use.
/// Think of this as your single shopping basket.
final CartModel cartModel = CartModel();
