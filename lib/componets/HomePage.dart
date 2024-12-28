import 'package:flutter/material.dart';
import 'package:movie_app/Widgets/BottomNavigation.dart';
import 'Drawers.dart';
import '../Apis/movie_service.dart';
import '../model/movie_model.dart';
import 'moviedetailScreen.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _searchController = TextEditingController();
  final MovieService _movieService = MovieService();
  List<Movie> _movies = [];
  bool _isLoading = false;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _searchInitialMovies(); // Perform initial search with "game"
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
    const query = "game";
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
          backgroundColor: const Color.fromARGB(255, 107, 194, 244),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
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
                    hintStyle: const TextStyle(
                      color: Color.fromARGB(179, 17, 17, 17),
                    ),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: _searchMovies,
                      color: const Color.fromARGB(179, 0, 0, 0),
                    ),
                  ),
                  style: const TextStyle(color: Color.fromARGB(255, 7, 7, 7)),
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
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                'https://th.bing.com/th/id/OIP.DCN81-VUzgNduO8lLeVaYAHaLH?rs=1&pid=ImgDetMain',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : _error.isNotEmpty
                  ? Center(child: Text(_error))
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Wrap(
                          spacing: 16.0,
                          runSpacing: 16.0,
                          children: _movies.map((movie) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        MovieDetailScreen(movie: movie),
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
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 245, 39, 24),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      movie.year,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color.fromARGB(255, 249, 62, 15),
                                      ),
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
        ),
        bottomNavigationBar: BottomNavigation(),
      ),
    );
  }
}
