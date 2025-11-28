import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantCard extends StatelessWidget {
  final String restaurantName;
  final String imageUrl;
  final String category;
  final double rating;
  final String deliveryTime;
  final String price;
  final VoidCallback onTap;

  const RestaurantCard({
    super.key,
    required this.restaurantName,
    this.imageUrl = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWJipVmTv-WBzpTkArZ8qRJN-msKwVAm-nbA&s",
    required this.price,
    this.category = 'Burger',
    this.rating = 4.5,
    this.deliveryTime = '30-40 min',
    //  this.price = '\$\$',
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Restaurant Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(imageUrl, height: 110, width: double.infinity, fit: BoxFit.cover),
            ),

            // Info
            Padding(
              padding: const EdgeInsets.all(4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurantName,
                    style: GoogleFonts.urbanist(fontWeight: FontWeight.bold, fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(category, style: GoogleFonts.urbanist(color: Colors.grey.shade600, fontSize: 12)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, size: 14, color: Colors.orange),
                      const SizedBox(width: 4),
                      Text(rating.toString(), style: const TextStyle(fontSize: 12)),
                      const Spacer(),
                      Text(deliveryTime, style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
