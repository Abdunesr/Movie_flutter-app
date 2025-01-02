import 'package:flutter/material.dart';
import 'package:movie_app/Widgets/BottomNavigation.dart';
import 'package:video_player/video_player.dart';
import 'Drawers.dart';
import '../Apis/movie_service.dart';
import '../model/movie_model.dart';
import 'moviedetailScreen.dart';
import 'package:movie_app/Apis/title_api.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _searchController = TextEditingController();
  final MovieService _movieService = MovieService();
  final moviesearchbytitle = MovieSearchService();
  List<Movie> _movies = [];
  bool _isLoading = false;
  String _error = '';
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _searchInitialMovies(); // Perform initial search with "game"

    // Initialize the video player
    _videoController = VideoPlayerController.asset('assets/background.mp4')
      ..initialize().then((_) {
        setState(() {}); // Refresh the state after initialization
        _videoController.setLooping(true); // Loop the video
        _videoController.setVolume(0.0); // Mute the video
        _videoController.play(); // Play the video
      });
  }

  @override
  void dispose() {
    _videoController
        .dispose(); // Clean up the video player when the widget is disposed
    super.dispose();
  }

  void _searchMovies() async {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;

    setState(() {
      _isLoading = true;
      _error = '';
    });

    try {
      final movies = await _movieService.fetchMovies(query);

      setState(() {
        _movies = movies;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _searchInitialMovies() async {
    const query = "fire";
    setState(() {
      _isLoading = true;
      _error = '';
    });

    try {
      final movies = await _movieService.fetchMovies(query);
      setState(() {
        _movies = movies;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: TextField(
                  controller: _searchController,
                  onChanged: (_) {
                    if (_searchController.text.isEmpty) {
                      _searchInitialMovies();
                    } else if (_searchController.text.length <= 2) {
                      return;
                    } else {
                      _searchMovies();
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: const TextStyle(color: Colors.white),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: _searchMovies,
                    ),
                  ),
                  onSubmitted: (_) => _searchMovies(),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text("🍿", style: TextStyle(fontSize: 24)),
              ),
            ],
          ),
        ),
        drawer: Drawers(),
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

            // Content overlay (Opacity layer)
            Positioned.fill(
              child: Container(
                color: const Color.fromARGB(255, 95, 138, 156)
                    .withOpacity(0.4), // Semi-transparent overlay
              ),
            ),

            // Main content (movies list)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _error.isNotEmpty
                      ? Center(child: Text(_error))
                      : SingleChildScrollView(
                          child: Wrap(
                            spacing: 16.0,
                            runSpacing: 16.0,
                            children: _movies.map((movie) {
                              return GestureDetector(
                                onTap: () async {
                                  final title = movie.title;

                                  final moviesInfo = await moviesearchbytitle
                                      .fetchMovieDetails(title);
                                  print(
                                      "hey hey hey hey hey heye    jlfkljafkjafkjksjafmdsaf");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MovieDetailScreen(
                                          movie: movie, movieInfo: moviesInfo),
                                    ),
                                  );
                                },
                                child: SizedBox(
                                  width:
                                      (MediaQuery.of(context).size.width - 48) /
                                          3,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.network(
                                        movie.poster,
                                        width: double.infinity,
                                        height: 120,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        movie.title,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        movie.year,
                                        style: const TextStyle(
                                            color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigation(),
      ),
    );
  }
}
