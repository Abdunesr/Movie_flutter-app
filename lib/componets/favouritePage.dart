import 'package:flutter/material.dart';
import 'package:movie_app/componets/moviedetailScreen.dart';
import '../favourites_manager.dart';
import '../model/movie_model.dart';
import 'package:movie_app/Apis/title_api.dart';

class FavouritePage extends StatefulWidget {
  final moviesearchbytitle = MovieSearchService();
  FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 2).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleFavourite(Movie movie) {
    setState(() {
      if (FavouritesManager.favourites.contains(movie)) {
        FavouritesManager.favourites.remove(movie);
      } else {
        FavouritesManager.favourites.add(movie);
      }
      _controller
        ..reset()
        ..forward(); // Play the rotation animation
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourites"),
        backgroundColor: const Color.fromARGB(255, 27, 46, 62),
        iconTheme:
            const IconThemeData(color: Color.fromARGB(255, 246, 235, 133)),
      ),
      body: FavouritesManager.favourites.isEmpty
          ? Center(
              child: Text(
                "No Favourite Movies selected",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 20,
                    ),
              ),
            )
          : ListView.builder(
              itemCount: FavouritesManager.favourites.length,
              itemBuilder: (context, index) {
                final movie = FavouritesManager.favourites[index];
                return ListTile(
                  onTap: () async {
                    final title = movie.title;
                    final moviesInfo = await widget.moviesearchbytitle
                        .fetchMovieDetails(title);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MovieDetailScreen(
                              movie: movie, movieInfo: moviesInfo)),
                    );
                  },
                  leading: Image.network(
                    movie.poster,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    movie.title,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  subtitle: Text(
                    movie.year,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  trailing: GestureDetector(
                    onTap: () => _toggleFavourite(movie),
                    child: RotationTransition(
                      turns: _animation,
                      child: Icon(
                        FavouritesManager.favourites.contains(movie)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
