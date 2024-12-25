import 'package:flutter/material.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourites"),
        backgroundColor: const Color.fromARGB(197, 6, 141, 165),
      ),
      body: const Center(
        child: Text(
          "Your Favourite Movies",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
