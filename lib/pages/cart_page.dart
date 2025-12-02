import 'package:flutter/material.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/models/order.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your cart'),
      ),
      body: AnimatedBuilder(
        // Listen to changes in the global cartModel.
        animation: cartModel,
        builder: (context, _) {
          if (cartModel.isEmpty) {
            // When there is nothing in the cart.
            return const Center(
              child: Text(
                'Your cart is empty.\nGo add some items!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          // When the cart has items.
          return Column(
            children: [
              // List of cart items.
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: cartModel.items.length,
                  itemBuilder: (context, index) {
                    final item = cartModel.items[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: CartItemCard(item: item),
                    );
                  },
                ),
              ),

              const Divider(height: 1),

              // Bottom summary area: total + buy now button.
              Padding(
                padding: const EdgeInsets.all(16),
                child: _CartSummary(),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// One card in the cart list for a single CartItem.
class CartItemCard extends StatelessWidget {
  final CartItem item;

  const CartItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    // Try to get an image that matches the selected colour.
    String? imagePath = item.product.primaryImageForColourName(item.colour) ??
        item.product.defaultImage;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image on the left.
            SizedBox(
              width: 80,
              height: 80,
              child: imagePath != null
                  ? Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(Icons.image_not_supported_outlined),
                        );
                      },
                    )
                  : const Center(
                      child: Icon(Icons.image_not_supported_outlined),
                    ),
            ),

            const SizedBox(width: 12),

            // Text and controls on the right.
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text('Size: ${item.size}'),
                  Text('Colour: ${item.colour}'),
                  const SizedBox(height: 4),

                  // Price info
                  Text(
                    '£${item.unitPrice.toStringAsFixed(2)} each',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Subtotal: £${item.lineTotal.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Quantity controls + delete button.
                  Row(
                    children: [
                      // Minus button
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          final newQty = item.quantity - 1;
                          cartModel.updateItemQuantity(item, newQty);
                        },
                      ),

                      // Current quantity
                      Text(
                        '${item.quantity}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // Plus button
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          final newQty = item.quantity + 1;
                          cartModel.updateItemQuantity(item, newQty);
                        },
                      ),

                      const Spacer(),

                      // Delete button
                      IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          cartModel.removeItem(item);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Bottom area showing total price and a Buy Now button for the whole cart.
class _CartSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final total = cartModel.totalPrice;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Total: £${total.toStringAsFixed(2)}',
          textAlign: TextAlign.right,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            _showCartPurchaseDialog(context);
          },
          child: const Text('Buy now'),
        ),
      ],
    );
  }

  void _showCartPurchaseDialog(BuildContext context) {
    if (cartModel.isEmpty) {
      return;
    }

    final total = cartModel.totalPrice;

    // 1) Build a text summary for the popup
    final buffer = StringBuffer();
    for (final item in cartModel.items) {
      buffer.writeln(
        '${item.quantity} × ${item.size} / ${item.colour} ${item.product.name} '
        '– £${item.lineTotal.toStringAsFixed(2)}',
      );
    }
    buffer.writeln('---------------------');
    buffer.writeln('Total: £${total.toStringAsFixed(2)}');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Purchase summary'),
          content: SingleChildScrollView(
            child: Text(buffer.toString()),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // 2) Create an Order from the current cart items
                final orderItems = cartModel.items
                    .map((cartItem) => OrderItem.fromCartItem(cartItem))
                    .toList();

                final order = Order(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  dateTime: DateTime.now(),
                  items: orderItems,
                  totalPrice: total,
                );

                // 3) Save it to the order history
                orderHistoryModel.addOrder(order);

                // 4) Clear the cart
                cartModel.clear();

                // 5) Close the dialog
                Navigator.of(context).pop();

                // 6) Show a thank-you message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Thank you for your purchase!'),
                  ),
                );
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }
}
