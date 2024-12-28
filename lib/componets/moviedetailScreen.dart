import 'package:flutter/material.dart';
import 'package:movie_app/Widgets/star.dart';
import 'package:video_player/video_player.dart';
import '../model/movie_model.dart';
import '../favourites_manager.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;

  const MovieDetailScreen({Key? key, required this.movie}) : super(key: key);

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  bool isFavourite = false;
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();

    // Check if the movie is already in favorites
    isFavourite = FavouritesManager.favourites
        .any((favouriteMovie) => favouriteMovie.imdbID == widget.movie.imdbID);

    // Initialize the video player for the background
    _videoController = VideoPlayerController.asset('assets/background.mp4')
      ..initialize().then((_) {
        print("Video Initialized Successfully");
        setState(() {}); // Refresh the state after initialization
        _videoController.setLooping(true); // Loop the video
        _videoController.play(); // Start playing the video
      }).catchError((error) {
        print("Error initializing video: $error");
      });
  }

  @override
  void dispose() {
    _videoController.dispose(); // Dispose the video player when not in use
    super.dispose();
  }

  void toggleFavourite() {
    setState(() {
      if (isFavourite) {
        // Remove the movie from favorites
        FavouritesManager.favourites.removeWhere(
            (favouriteMovie) => favouriteMovie.imdbID == widget.movie.imdbID);
        isFavourite = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(seconds: 3),
          content: Text('Removed sucesfully!'),
        ));
      } else {
        // Check if the movie already exists in favorites
        if (!FavouritesManager.favourites.any(
            (favouriteMovie) => favouriteMovie.imdbID == widget.movie.imdbID)) {
          FavouritesManager.favourites.add(widget.movie);
          isFavourite = true;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Added sucesfully!'),
            ),
          );
        } else {
          // Optionally, show a message that the movie is already in favorites
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("This movie is already in your favorites."),
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.movie.title,
          style: const TextStyle(color: Color.fromARGB(255, 2, 2, 2)),
        ),
        backgroundColor: const Color.fromARGB(255, 240, 97, 86),
        actions: [
          IconButton(
            icon: Icon(
              isFavourite ? Icons.star : Icons.star_border_purple500_rounded,
              color: const Color.fromARGB(255, 227, 15, 0),
            ),
            onPressed: toggleFavourite,
          ),
        ],
      ),
      body: Stack(
        children: [
          // Video background
          _videoController.value.isInitialized
              ? Positioned.fill(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: _videoController.value.size.width,
                        height: _videoController.value.size.height,
                        child: VideoPlayer(_videoController),
                      ),
                    ),
                  ),
                )
              : const Center(child: CircularProgressIndicator()),

          // Content overlay (Opacity layer)
          Positioned.fill(
            child: Opacity(
              opacity: 0.7, // Add opacity to make the content more readable
              child: Container(
                color:
                    Colors.black.withOpacity(0.4), // Semi-transparent overlay
              ),
            ),
          ),

          // Main content (movie details)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Poster on the left
                    Column(
                      children: [
                        Image.network(
                          widget.movie.poster,
                          width: 150,
                          height: 225,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 8),
                        // Rating bar below the poster
                        Column(
                          children: [
                            Star(),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    // Details on the right
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.movie.title,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Year: ${widget.movie.year}",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "IMDb ID: ${widget.movie.imdbID}",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Summary:",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          const Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus euismod, nunc id tristique pharetra, neque massa facilisis risus.",
                            style: TextStyle(fontSize: 14, color: Colors.red),
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
