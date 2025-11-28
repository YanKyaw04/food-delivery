import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery/providers/common.dart';
import 'package:food_delivery/screens/home/cart.dart';
import 'package:food_delivery/screens/home/home.dart';
import 'package:food_delivery/screens/order/order_screen.dart';
import 'package:food_delivery/screens/profile/profile.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavIndexProvider);

    final pages = [const HomeScreen(), const CartPage(), const OrderScreen(), const ProfileScreen()];

    return Scaffold(
      extendBody: true,
      body: pages[currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              currentIndex: currentIndex,
              onTap: (index) {
                ref.read(bottomNavIndexProvider.notifier).state = index;
              },
              selectedItemColor: Colors.deepOrange,
              unselectedItemColor: Colors.grey.shade500,
              elevation: 10,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'),
                BottomNavigationBarItem(icon: Icon(Icons.receipt_long_rounded), label: 'Orders'),
                BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), label: 'Profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
