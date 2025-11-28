// lib/providers/cart_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery/model/cart_item.dart';

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addToCart(CartItem item) {
    final index = state.indexWhere((i) => i.name == item.name);
    if (index == -1) {
      state = [...state, item];
    } else {
      final updated = state[index].copyWith(quantity: state[index].quantity + item.quantity);
      state = [...state]..[index] = updated;
    }
  }

  void removeFromCart(String name) {
    state = state.where((item) => item.name != name).toList();
  }

  void increaseQuantity(CartItem item) {
    state = state.map((e) => e.id == item.id ? e.copyWith(quantity: e.quantity + 1) : e).toList();
  }

  void decreaseQuantity(CartItem item) {
    if (item.quantity > 1) {
      state = state.map((e) => e.id == item.id ? e.copyWith(quantity: e.quantity - 1) : e).toList();
    } else {
      state = state.where((e) => e.id != item.id).toList();
    }
  }

  void updateQuantity(String name, int quantity) {
    final index = state.indexWhere((item) => item.name == name);
    if (index != -1) {
      final updated = state[index].copyWith(quantity: quantity);
      state = [...state]..[index] = updated;
    }
  }

  double get totalPrice => state.fold(0, (sum, item) => sum + item.price * item.quantity);
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) => CartNotifier());
