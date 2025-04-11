// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Drawers extends StatelessWidget {
  const Drawers({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 27, 46, 62),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://th.bing.com/th/id/OIP.blverIh7XMBbvrx1GCVBtQHaEK?rs=1&pid=ImgDetMain', // Replace with a valid image URL
                ),
                fit: BoxFit.cover, // Ensures the image covers the header
              ),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: const Text(
                '🍿Usepopcorn',
                style: TextStyle(
                  color: Color.fromARGB(255, 249, 219, 120),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  backgroundColor: Color.fromARGB(100, 0, 0,
                      0), // Semi-transparent background for text visibility
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
              color: Color.fromARGB(255, 197, 165, 90), // Yellow icon color
            ),
            title: const Text(
              'Home',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context); // Close drawer
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.movie,
              color: Color(0xFFFFC947), // Yellow icon color
            ),
            title: const Text(
              'Movies',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context); // Close drawer
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
              color: Color(0xFFFFC947), // Yellow icon color
            ),
            title: const Text(
              'Settings',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context); // Close drawer
            },
          ),
        ],
      ),
    );
  }
}
