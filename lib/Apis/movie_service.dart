import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/movie_model.dart';

class MovieService {
  static const String KEY = '3a9b5f5e'; // Replace with your actual API key

  Future<List<Movie>> fetchMovies(String query) async {
    final response = await http
        .get(Uri.parse('http://www.omdbapi.com/?apikey=$3a9b5f5e&s=`$`$query]'));
   

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      print(data);

      if (data['Response'] == 'True') {
        final List<dynamic> moviesJson = data['Search'];
        return moviesJson.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception(data['Error']);
      }
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
