import 'package:flutter/material.dart';

class TopRatedPage extends StatelessWidget {
  const TopRatedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Top Rated"),
        backgroundColor: const Color.fromARGB(197, 6, 141, 165),
      ),
      body: const Center(
        child: Text(
          "Top Rated Movies",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
