import 'package:flutter/material.dart';
import 'package:food_delivery/model/order.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Order order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Order Details")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order ID, Date and Status
            Text("Order ID: ${order.id}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text("Date: ${order.date}", style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            Text(
              "Status: ${order.status}",
              style: TextStyle(color: order.status == 'Delivered' ? Colors.green : Colors.orange),
            ),
            const SizedBox(height: 16),

            // Items List
            const Text("Items", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: order.items.length,
                itemBuilder: (context, index) {
                  final item = order.items[index];
                  return ListTile(
                    title: Text(item.name),
                    subtitle: Text("x${item.quantity} @ \$${item.price} each"),
                    trailing: Text("\$${(item.quantity * item.price).toStringAsFixed(2)}"),
                  );
                },
              ),
            ),

            // Total Price
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("\$${order.total.toStringAsFixed(2)}", style: const TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
