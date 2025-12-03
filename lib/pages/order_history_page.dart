import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:union_shop/models/order.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Order History')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'You need to be logged in to view your orders.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text('Login to continue'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order history'),
      ),
      body: AnimatedBuilder(
        animation: orderHistoryModel,
        builder: (context, _) {
          if (orderHistoryModel.isEmpty) {
            return const Center(
              child: Text(
                'You haven\'t placed any orders yet.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          final orders = orderHistoryModel.orders;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _OrderCard(order: order),
              );
            },
          );
        },
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final Order order;

  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    final date = order.dateTime;
    final dateString =
        '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year} '
        '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';

    return Card(
      elevation: 2,
      child: ExpansionTile(
        title: Text(
          'Order #${order.id}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '$dateString • ${order.totalQuantity} items • '
          '£${order.totalPrice.toStringAsFixed(2)}',
        ),
        children: [
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final item in order.items)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      '${item.quantity} × ${item.size} / ${item.colour} ${item.productName} '
                      '– £${item.lineTotal.toStringAsFixed(2)}',
                    ),
                  ),
                const SizedBox(height: 8),
                Text(
                  'Total: £${order.totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
