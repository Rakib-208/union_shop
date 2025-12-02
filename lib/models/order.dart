import 'package:flutter/foundation.dart';
import 'package:union_shop/models/cart.dart';

/// One line inside an order (like a "receipt row").
/// Very similar to CartItem, but read-only once created.
class OrderItem {
  final String productName;
  final String size;
  final String colour;
  final int quantity;
  final double unitPrice;
  final double lineTotal;

  OrderItem({
    required this.productName,
    required this.size,
    required this.colour,
    required this.quantity,
    required this.unitPrice,
    required this.lineTotal,
  });

  /// Helper: create an OrderItem from a CartItem.
  factory OrderItem.fromCartItem(CartItem cartItem) {
    return OrderItem(
      productName: cartItem.product.name,
      size: cartItem.size,
      colour: cartItem.colour,
      quantity: cartItem.quantity,
      unitPrice: cartItem.unitPrice,
      lineTotal: cartItem.lineTotal,
    );
  }
}

/// One completed order.
/// Example: "Order #3 on 2 Dec, total £120, with 4 items".
class Order {
  final String id;
  final DateTime dateTime;
  final List<OrderItem> items;
  final double totalPrice;

  Order({
    required this.id,
    required this.dateTime,
    required this.items,
    required this.totalPrice,
  });

  int get totalQuantity {
    return items.fold<int>(0, (sum, item) => sum + item.quantity);
  }
}

/// Stores all the past orders for this session.
class OrderHistoryModel extends ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders => List.unmodifiable(_orders);

  bool get isEmpty => _orders.isEmpty;

  int get orderCount => _orders.length;

  void addOrder(Order order) {
    _orders.insert(0, order); // newest at the top
    notifyListeners();
  }

  void clear() {
    _orders.clear();
    notifyListeners();
  }
}

/// One global order history, shared by the whole app.
final OrderHistoryModel orderHistoryModel = OrderHistoryModel();
