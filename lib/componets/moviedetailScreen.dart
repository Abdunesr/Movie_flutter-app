import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movie_app/model/model_title.dart';
import 'package:video_player/video_player.dart';
import '../model/movie_model.dart';
import '../favourites_manager.dart';
import 'package:movie_app/Widgets/star.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;
  final Movies movieInfo;

  const MovieDetailScreen(
      {Key? key, required this.movie, required this.movieInfo})
      : super(key: key);

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  bool isFavourite = false;
  late VideoPlayerController _videoController;
  late PageController _posterController;
  Timer? _scrollTimer;

  @override
  void initState() {
    super.initState();

    // Check if the movie is already in favorites
    isFavourite = FavouritesManager.favourites
        .any((favouriteMovie) => favouriteMovie.imdbID == widget.movie.imdbID);

    // Initialize the video player for the background
    _videoController = VideoPlayerController.asset('assets/background.mp4')
      ..initialize().then((_) {
        setState(() {});
        _videoController.setLooping(true);
        _videoController.setVolume(0); // Mute the video
        _videoController.play();
      }).catchError((error) {
        print("Error initializing video: $error");
      });

    // Initialize the page controller for posters
    _posterController = PageController(viewportFraction: 0.3);

    // Start the auto-scroll timer
    _startAutoScroll();
  }

  @override
  void dispose() {
    _videoController.dispose();
    _posterController.dispose();
    _scrollTimer?.cancel();
    super.dispose();
  }

  void _startAutoScroll() {
    _scrollTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_posterController.hasClients) {
        final nextPage = (_posterController.page! + 1) % 10; // Infinite loop
        _posterController.animateToPage(
          nextPage.toInt(),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void toggleFavourite() {
    setState(() {
      if (isFavourite) {
        FavouritesManager.favourites.removeWhere(
            (favouriteMovie) => favouriteMovie.imdbID == widget.movie.imdbID);
        isFavourite = false;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Removed successfully!')),
        );
      } else {
        if (!FavouritesManager.favourites.any(
            (favouriteMovie) => favouriteMovie.imdbID == widget.movie.imdbID)) {
          FavouritesManager.favourites.add(widget.movie);
          isFavourite = true;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Added successfully!')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('This movie is already in favorites.')),
          );
        }
      }
    });
  }

  void _showMovieInfoPopup() {
    List<String> actorsList = widget.movieInfo.Actors.split(', ');
    List<String> Writers = widget.movieInfo.Writer.split(', ');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color.fromARGB(0, 24, 43, 50),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.6, // Adjust the height as needed
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Container(
              color: const Color.fromARGB(255, 22, 30, 44),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.movie.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text("Year: ${widget.movie.year}",
                      style: const TextStyle(color: Colors.white)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Image.network(
                          widget.movie.poster,
                          width: 200,
                          height: 150,
                        ),
                      ),
                      const SizedBox(width: 3),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Released: ${widget.movieInfo.Released}",
                            style: const TextStyle(color: Colors.white),
                          ),
                          Text(
                            "IMDb Rating: ${widget.movieInfo.imdbRating} ⭐",
                            style: const TextStyle(color: Colors.white),
                          ),
                          Text(
                            "Genre: ${widget.movieInfo.Genre}",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Plot: ${widget.movieInfo.plot}",
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    "Actors",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: actorsList
                            .map((actor) => Text(
                                  actor,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 168, 152, 81)),
                                ))
                            .toList(),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Column(
                        children: [
                          Text(
                            "Written By",
                            style: TextStyle(color: Colors.white),
                          ),
                          Column(
                            children: Writers.map((writer) => Text(
                                  " $writer",
                                  style: TextStyle(
                                      color: const Color.fromARGB(
                                          220, 163, 152, 53)),
                                )).toList(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Directed By: ${widget.movieInfo.Director}",
                    style: const TextStyle(
                        color: Color.fromARGB(255, 128, 109, 48)),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: TextButton(
                      onPressed: () async {
                        final temp = widget.movie.title.replaceAll(' ', '-');
                        final url =
                            'https://www.gojara/.com/$temp'; // Assuming this is the correct website
                        if (await canLaunchUrl(Uri.parse(url))) {
                          await launchUrl(Uri.parse(url));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('make sure you ahve a connection'),
                            ),
                          );
                        }
                      },
                      child: Text(
                        'Dowload it ',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 157, 146, 64),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.movie.title,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        backgroundColor: const Color.fromARGB(255, 27, 46, 62),
        actions: [
          IconButton(
            icon: Icon(
              isFavourite ? Icons.star : Icons.star_border_purple500_rounded,
              color: Theme.of(context).iconTheme.color,
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
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _videoController.value.size.width,
                      height: _videoController.value.size.height,
                      child: VideoPlayer(_videoController),
                    ),
                  ),
                )
              : const Center(child: CircularProgressIndicator()),

          // Content overlay
          Positioned.fill(
            child: Opacity(
              opacity: 0.7,
              child: Container(
                color: Colors.black.withOpacity(0.4),
              ),
            ),
          ),

          // Main content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    // Poster
                    GestureDetector(
                      onTap: _showMovieInfoPopup,
                      child: Column(
                        children: [
                          Image.network(
                            widget.movie.poster,
                            width: 150,
                            height: 225,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.broken_image, size: 150);
                            },
                          ),
                          const SizedBox(height: 8),
                          Star(),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Movie details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.movie.title,
                            style: Theme.of(context).textTheme.displayLarge,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Year: ${widget.movie.year}",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.movie.Type,
                            style: TextStyle(color: Colors.amber),
                          ),
                          Text(
                            "IMDb ID: ${widget.movie.imdbID}",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Scrolling posters at the bottom
              Expanded(
                child: PageView.builder(
                  controller: _posterController,
                  scrollDirection: Axis.horizontal,
                  itemCount: 10, // Number of posters
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: Image.network(
                        widget.movie.poster,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.broken_image);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
