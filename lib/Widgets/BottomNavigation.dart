import 'package:flutter/material.dart';
import 'package:movie_app/componets/favouritePage.dart';
import 'package:movie_app/componets/topRated.dart';

class BottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      child: BottomAppBar(
        color: Theme.of(context).primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavouritePage(),
                  ),
                );
              },
              icon: const Icon(Icons.favorite,
                  color: Color.fromARGB(255, 255, 225, 31), size: 20),
              label: const Text(
                "Favourites",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
            TextButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TopRatedPage(),
                  ),
                );
              },
              icon: const Icon(Icons.star, color: Colors.yellow, size: 20),
              label: const Text(
                "Top Rated",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
