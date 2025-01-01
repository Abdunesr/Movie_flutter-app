import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/model/model_title.dart';

class MovieSearchService {
  final String apiKey = 'b481392d'; // Replace with your API key

  // Function to fetch movies based on search query (e.g., "game")

  // Function to fetch detailed movie data based on movie title
  Future<Movie> fetchMovieDetails(String title) async {
    print("hanim ahani m ahanim ahnaam hnaim");
    final url = Uri.parse('http://www.omdbapi.com/?apikey=$apiKey&t=$title');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['Response'] == 'True') {
        return Movie.fromJson(data);
      } else {
        throw Exception('Failed to fetch movie details');
      }
    } else {
      throw Exception('Failed to load movie details');
    }
  }
}
