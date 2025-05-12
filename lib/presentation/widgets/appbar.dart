import 'package:flutter/material.dart';

class FancyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isNoticationButtoonVisible;
  final bool islogoutButtoonVisible;

  const FancyAppBar({
    super.key,
    required this.title,
    this.isNoticationButtoonVisible = false,
    this.islogoutButtoonVisible = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(80.0); // Custom height

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(24)), // Rounded bottom
      child: Container(
        height: preferredSize.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: AppBar(
          backgroundColor: Colors.transparent, // Make AppBar itself transparent
          elevation: 0,
          title: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            if (isNoticationButtoonVisible)
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  // Action here
                },
              ),
            if (islogoutButtoonVisible)
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  // Profile or logout
                },
              ),
          ],
        ),
      ),
    );
  }
}
