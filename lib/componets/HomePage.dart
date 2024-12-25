import 'package:flutter/material.dart';
import 'Drawers.dart';
import '../data/movie_data.dart';
import '../model/movie_model.dart';
import 'topRated.dart';
import 'favouritePage.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});

  final List<Movie> movies = tempMovieData;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 107, 194, 244),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 130,
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
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text("🍿Usepop", style: TextStyle(fontSize: 24)),
              ),
            ],
          ),
        ),
        drawer: Drawers(),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                'https://th.bing.com/th/id/OIP.DCN81-VUzgNduO8lLeVaYAHaLH?rs=1&pid=ImgDetMain',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 16.0, // Horizontal space between items
                runSpacing: 16.0, // Vertical space between rows
                children: movies.map((movie) {
                  return SizedBox(
                    width: (MediaQuery.of(context).size.width - 48) /
                        3, // Adjust for 3 items per row
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.network(
                          movie.poster,
                          width: double
                              .infinity, // Make the image take up the full width
                          height: 120, // Reduced image height
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          height: 8,
                        ), // Space between image and text
                        Text(
                          movie.title,
                          style: const TextStyle(
                            fontSize: 14, // Reduced text size
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 245, 39, 24),
                          ),
                          overflow: TextOverflow.ellipsis, // Handle long titles
                          maxLines: 1,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          movie.year,
                          style: const TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(
                                  255, 249, 62, 15)), // Smaller text size
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 56,
          child: BottomAppBar(
            color: const Color.fromARGB(255, 107, 194, 244),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FavouritePage(),
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
        ),
      ),
    );
  }
}
