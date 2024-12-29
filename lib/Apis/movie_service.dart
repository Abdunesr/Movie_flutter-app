import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/movie_model.dart';

class MovieService {
  static const String apiKey = 'f84fc31d';
  final title = "Power"; // Replace with your actual API key

  Future<List<Movie>> fetchMovies(String query) async {
    final response = await http
        .get(Uri.parse('http://www.omdbapi.com/?apikey=$apiKey&s=$query'));
    final rating = await http
        .get(Uri.parse('http://www.omdbapi.com/?apikey=$apiKey&t=$title'));
    print("Hanim Hanim hanim hanim hanim hanim hanim ahnaim abdekah abdelah ");
    print(rating.body);

    /*{"Title":"Power","Year":"2014–2020","Rated":"TV-MA","Released":"07 Jun 2014","Runtime":"50 min","Genre":"Crime, Drama","Director":"N/A","Writer":"Courtney A. Kemp","Actors":"Omari Hardwick, Lela Loren, Naturi Naughton","Plot":"James \"Ghost\" St. Patrick, a wealthy New York nightclub owner who has it all; dreaming big, catering to the city's elite, and living a double life as a drug kingpin.","Language":"English","Country":"United States","Awards":"14 wins & 29 nominations","Poster":"https://m.media-amazon.com/images/M/MV5BMTg0NDMyMzEzOF5BMl5BanBnXkFtZTgwNTIzODQxMjI@._V1_SX300.jpg","Ratings":[{"Source":"Internet Movie Database","Value":"8.1/10"}],"Metascore":"N/A","imdbRating":"8.1","imdbVotes":"53,883","imdbID":"tt3281796","Type":"series","totalSeasons":"6","Response":"True"}*/

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data.toString());

      if (data['Response'] == 'True') {
        final List<dynamic> moviesJson = data['Search'];
        return moviesJson.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception(data['Error']);
      }
    } else {
      print("Error");
      throw Exception('Failed to load movies');
    }
  }
}
