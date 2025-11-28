import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery/model/cart_item.dart';
import 'package:food_delivery/providers/cart_notifer.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child:
            cartItems.isEmpty
                ? const Center(child: Text("🛒 Your cart is empty"))
                : Column(
                  children: [
                    // Custom Top Bar
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
                          const Text("Your Cart", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),

                    // Cart List
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: cartItems.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          final item = cartItems[index];
                          return _CartItemTile(item: item, ref: ref);
                        },
                      ),
                    ),

                    // Bottom Bar
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "\$${_calculateTotal(cartItems).toStringAsFixed(2)}",
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () {},
                            child: const Text("Checkout", style: TextStyle(fontSize: 16)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
      ),
    );
  }

  double _calculateTotal(List<CartItem> cartItems) {
    return cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);
  }
}

class _CartItemTile extends StatelessWidget {
  final CartItem item;
  final WidgetRef ref;

  const _CartItemTile({required this.item, required this.ref});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(16)),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          // Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(item.imageUrl, width: 70, height: 70, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text("\$${item.price.toStringAsFixed(2)} x ${item.quantity}"),
              ],
            ),
          ),

          // Quantity control
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: () {
                  ref.read(cartProvider.notifier).decreaseQuantity(item);
                },
              ),
              Text('${item.quantity}', style: const TextStyle(fontSize: 16)),
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                onPressed: () {
                  ref.read(cartProvider.notifier).increaseQuantity(item);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
