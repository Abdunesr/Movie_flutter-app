import 'package:flutter/material.dart';

class Drawers extends StatelessWidget {
  const Drawers({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  backgroundColor: Color.fromARGB(100, 0, 0,
                      0), // Semi-transparent background for text visibility
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context); // Close drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.movie),
            title: const Text('Movies'),
            onTap: () {
              Navigator.pop(context); // Close drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context); // Close drawer
            },
          ),
        ],
      ),
    );
  }
}
