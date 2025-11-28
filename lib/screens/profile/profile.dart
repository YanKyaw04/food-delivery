import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile", style: GoogleFonts.urbanist())),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                "https://cdn.vectorstock.com/i/500p/17/61/male-avatar-profile-picture-vector-10211761.jpg",
              ),
            ),
            const SizedBox(height: 12),
            Text("John Doe", style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.bold)),
            Text("johndoe@example.com", style: GoogleFonts.urbanist(color: Colors.grey)),
            const SizedBox(height: 24),
            ListTile(leading: const Icon(Icons.settings), title: const Text("Settings"), onTap: () {}),
            ListTile(leading: const Icon(Icons.logout), title: const Text("Logout"), onTap: () {}),
          ],
        ),
      ),
    );
  }
}
