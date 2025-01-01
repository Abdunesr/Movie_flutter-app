import 'package:flutter/material.dart';

class TopRatedPage extends StatelessWidget {
  const TopRatedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Top Rated"),
        backgroundColor: const Color.fromARGB(255, 27, 46, 62),
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
