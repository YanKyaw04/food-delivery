import 'package:flutter/material.dart';
import 'package:food_delivery/model/order.dart';
import 'package:food_delivery/screens/order/order_detail.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = [
      Order(
        id: 'ORD123',
        status: 'Delivered',
        date: 'Apr 30, 2025',
        total: 29.99,
        items: [
          OrderItem(name: 'Burger', quantity: 2, price: 10.99),
          OrderItem(name: 'Fries', quantity: 1, price: 3.50),
        ],
      ),
      Order(
        id: 'ORD124',
        status: 'Processing',
        date: 'May 1, 2025',
        total: 18.50,
        items: [OrderItem(name: 'Pizza', quantity: 1, price: 18.50)],
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: Text("My Orders")),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              title: Text("Order ID: ${order.id}"),
              subtitle: Text("${order.date} • ${order.status}"),
              trailing: Text("\$${order.total}"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => OrderDetailsScreen(order: order)));
              },
            ),
          );
        },
      ),
    );
  }
}
