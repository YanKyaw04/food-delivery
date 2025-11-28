class Order {
  final String id;
  final String status;
  final String date;
  final double total;
  final List<OrderItem> items;

  Order({required this.id, required this.status, required this.date, required this.total, required this.items});
}

class OrderItem {
  final String name;
  final int quantity;
  final double price;

  OrderItem({required this.name, required this.quantity, required this.price});
}
