import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery/model/cart_item.dart';
import 'package:food_delivery/providers/cart_notifer.dart';
import 'package:uuid/uuid.dart';

class RestaurantDetailScreen extends ConsumerStatefulWidget {
  final String restaurantName;
  final String imageUrl;
  final double price;

  const RestaurantDetailScreen({
    super.key,
    required this.restaurantName,
    this.imageUrl = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWJipVmTv-WBzpTkArZ8qRJN-msKwVAm-nbA&s",
    required this.price,
  });

  @override
  ConsumerState<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends ConsumerState<RestaurantDetailScreen> {
  int quantity = 1;

  void _increment() {
    setState(() => quantity++);
  }

  void _decrement() {
    if (quantity > 1) setState(() => quantity--);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
            onPressed: () {
              // Navigate to cart
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Top image
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                child: Image.network(
                  widget.imageUrl,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.none, // disable mipmapping
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black.withOpacity(0.6), Colors.transparent, Colors.black.withOpacity(0.6)],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Info
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.restaurantName,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: const [
                    Icon(Icons.star, color: Colors.amber, size: 20),
                    SizedBox(width: 4),
                    Text("4.7", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 12),
                    Text("• Burgers • Fast Food"),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "Enjoy juicy burgers, crispy fries, and refreshing drinks from our top-rated fast food restaurant. Delivered fresh & hot!",
                  style: TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 20),

                // Quantity Selector
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Quantity", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        children: [
                          IconButton(icon: const Icon(Icons.remove), onPressed: _decrement),
                          Text("$quantity", style: const TextStyle(fontSize: 16)),
                          IconButton(icon: const Icon(Icons.add), onPressed: _increment),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),

      // Add to Cart Fixed Bottom
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Colors.grey.shade200))),
        child: ElevatedButton(
          onPressed: () {
            final cartItem = CartItem(
              id: const Uuid().v4(), // generates a unique id

              name: widget.restaurantName,
              imageUrl: widget.imageUrl,
              price: widget.price,
              quantity: quantity,
            );
            ref.read(cartProvider.notifier).addToCart(cartItem);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Added to cart")));
          },
          child: const Text("Add to Cart"),
        ),
      ),
    );
  }
}
