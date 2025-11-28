import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery/providers/cart_notifer.dart';
import 'package:food_delivery/providers/category_provider.dart';
import 'package:food_delivery/screens/home/cart.dart';
import 'package:food_delivery/screens/home/restaurant_detail.dart';
import 'package:food_delivery/widgets/category_chip.dart';
import 'package:food_delivery/widgets/filter_bottomsheet.dart';
import 'package:food_delivery/widgets/restaurant_cart.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);
    //  final restaurants = ref.watch(restaurantListProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 65),
        child: Consumer(
          builder: (context, ref, _) {
            final cartItems = ref.watch(cartProvider);
            final totalCount = cartItems.fold<int>(0, (sum, item) => sum + item.quantity);

            return Stack(
              clipBehavior: Clip.none,
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.black26,
                  shape: const CircleBorder(),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const CartPage()));
                  },
                  child: const Icon(Icons.shopping_basket, color: Colors.white),
                ),
                if (totalCount > 0)
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                      child: Text('$totalCount', style: const TextStyle(color: Colors.white, fontSize: 14)),
                    ),
                  ),
              ],
            );
          },
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //  Custom App Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Hey, Foodie 👋", style: GoogleFonts.urbanist(fontSize: 22, fontWeight: FontWeight.bold)),
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      "https://cdn.vectorstock.com/i/500p/17/61/male-avatar-profile-picture-vector-10211761.jpg", // Replace with user's image later
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              //  Search Bar with Filter Icon
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 4)),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.grey),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search restaurants or food",
                          border: InputBorder.none,
                          hintStyle: GoogleFonts.urbanist(color: Colors.grey),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.tune, color: Colors.grey),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                          ),
                          builder: (_) => const FilterBottomSheet(),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Categories
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children:
                      ['Burgers', 'Pizza', 'Sushi', 'Pasta'].map((category) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: CategoryChip(
                            category: category,
                            isSelected: selectedCategory == category,
                            onTap: () => ref.read(selectedCategoryProvider.notifier).state = category,
                          ),
                        );
                      }).toList(),
                ),
              ),
              const SizedBox(height: 10),

              // Title
              Text("Popular Restaurants", style: GoogleFonts.urbanist(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),

              // Restaurants
              Expanded(
                child: GridView.builder(
                  itemCount: 10,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemBuilder: (context, index) {
                    final name = "Restaurant ${index + 1}";

                    final price = 12.99 + index;
                    return RestaurantCard(
                      restaurantName: name,
                      price: price.toString(),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => RestaurantDetailScreen(restaurantName: name, price: price)),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
