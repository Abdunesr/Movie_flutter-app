import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/movie_model.dart'; // Make sure this path matches where your Movie model is located

class MovieService {
  static const String apiKey = 'b481392d';

  Future<List<Movie>> fetchMovies(String query, {int limit = 15}) async {
    final int moviesPerPage = 10; // OMDb API returns up to 10 results per page
    final int pages =
        (limit / moviesPerPage).ceil(); // Calculate total pages needed
    List<Movie> movies = []; // List to store the fetched movies

    for (int page = 1; page <= pages; page++) {
      final response = await http.get(
        Uri.parse('http://www.omdbapi.com/?apikey=$apiKey&s=$query&page=$page'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['Response'] == 'True') {
          final List<dynamic> moviesJson = data['Search'];
          movies.addAll(
            moviesJson.map((json) => Movie.fromJson(json)).toList(),
          );

          // Stop if we've reached the desired limit
          if (movies.length >= limit) {
            movies = movies.sublist(0, limit); // Trim to exact limit
            break;
          }
        } else {
          throw Exception(data['Error']);
        }
      } else {
        throw Exception('Failed to load movies: ${response.statusCode}');
      }
    }

    return movies;
  }
}
