import 'package:flutter/material.dart';
import 'Drawers.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(197, 6, 141, 165),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 130,
                child: Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      hintStyle: const TextStyle(
                        color: Color.fromARGB(179, 17, 17, 17),
                      ),
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          // Add search functionality here
                        },
                        color: const Color.fromARGB(179, 0, 0, 0),
                      ),
                    ),
                    style: const TextStyle(color: Color.fromARGB(255, 7, 7, 7)),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text("🍿Usepopcorn", style: TextStyle(fontSize: 24)),
              ),
            ],
          ),
        ),
        drawer: Drawers(),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                'https://th.bing.com/th/id/R.30b91212cad4b07caf9439261f995cb9?rik=AGTb0WtBHt2whg&pid=ImgRaw&r=0', // Replace with your preferred movie poster URL
              ),
              fit: BoxFit.cover, // Makes the image cover the entire background
            ),
          ),
          child: const Center(
            child: Text(
              "Welcome to Usepopcorn🍿!",
              style: TextStyle(
                fontSize: 24,
                color: Colors.white, // Text color to stand out on the image
                fontWeight: FontWeight.bold,
                backgroundColor: Color.fromARGB(100, 0, 0,
                    0), // Semi-transparent background for better visibility
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
