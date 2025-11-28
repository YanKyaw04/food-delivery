import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final String category;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChip({super.key, required this.category, this.isSelected = false, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        label: Text(category, style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
        backgroundColor: isSelected ? Colors.deepOrange : Colors.grey.shade200,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}
