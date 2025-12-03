import 'package:flutter/foundation.dart';
import 'package:union_shop/models/cart.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

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
  Map<String, dynamic> toJson() {
    return {
      'productName': productName,
      'size': size,
      'colour': colour,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'lineTotal': lineTotal,
    };
  }

  /// Rebuild OrderItem from simple stored data
  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productName: json['productName'],
      size: json['size'],
      colour: json['colour'],
      quantity: json['quantity'],
      unitPrice: (json['unitPrice'] as num).toDouble(),
      lineTotal: (json['lineTotal'] as num).toDouble(),
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

  /// Convert this Order to simple data for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dateTime': dateTime.toIso8601String(),
      'items': items.map((item) => item.toJson()).toList(),
      'totalPrice': totalPrice,
    };
  }

  /// Rebuild an Order from stored data
  static Order fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      items: (json['items'] as List)
          .map((itemJson) =>
              OrderItem.fromJson(itemJson as Map<String, dynamic>))
          .toList(),
      totalPrice: (json['totalPrice'] as num).toDouble(),
    );
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
    _saveToPrefs();
  }

  void clear() {
    _orders.clear();
    notifyListeners();
    _saveToPrefs();
  }

  /// Save all orders to local storage
  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    // Convert each Order to a simple map, then encode as JSON
    final orderJsonList = _orders.map((order) => order.toJson()).toList();
    final encoded = jsonEncode(orderJsonList);

    await prefs.setString('orders', encoded);
  }

  /// Load all orders from local storage
  Future<void> loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = prefs.getString('orders');

    if (encoded == null) {
      // No orders saved yet
      return;
    }

    try {
      final decoded = jsonDecode(encoded) as List<dynamic>;

      _orders
        ..clear()
        ..addAll(
          decoded.map((orderJson) {
            return Order.fromJson(orderJson as Map<String, dynamic>);
          }),
        );

      notifyListeners();
    } catch (e) {
      // If something goes wrong (corrupt data), clear and move on
      _orders.clear();
      notifyListeners();
    }
  }
}

/// One global order history, shared by the whole app.
final OrderHistoryModel orderHistoryModel = OrderHistoryModel();
