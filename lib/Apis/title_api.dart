import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/model/model_title.dart';

class MovieSearchService {
  final String apiKey = 'b481392d'; // Replace with your API key

  // Function to fetch movies based on search query (e.g., "game")

  // Function to fetch detailed movie data based on movie title
  Future<Movies> fetchMovieDetails(String title) async {
    final url = Uri.parse('http://www.omdbapi.com/?apikey=$apiKey&t=$title');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['Response'] == 'True') {
        return Movies.fromJson(data);
      } else {
        throw Exception('Failed to fetch movie details');
      }
    } else {
      throw Exception('Failed to load movie details');
    }
  }
}

//{"Title":"The Hunger Games: Catching Fire","Year":"2013","Rated":"PG-13","Released":"22 Nov 2013","Runtime":"146 min","Genre":"Action, Adventure, Sci-Fi","Director":"Francis Lawrence","Writer":"Simon Beaufoy, Michael Arndt, Suzanne Collins","Actors":"Jennifer Lawrence, Josh Hutcherson, Liam Hemsworth","Plot":"Katniss Everdeen and Peeta Mellark become targets of the Capitol after their victory in the 74th Hunger Games sparks a rebellion in the Districts of Panem.","Language":"English","Country":"United States","Awards":"22 wins & 68 nominations","Poster":"https://m.media-amazon.com/images/M/MV5BMTAyMjQ3OTAxMzNeQTJeQWpwZ15BbWU4MDU0NzA1MzAx._V1_SX300.jpg","Ratings":[{"Source":"Internet Movie Database","Value":"7.5/10"},{"Source":"Rotten Tomatoes","Value":"90%"},{"Source":"Metacritic","Value":"76/100"}],"Metascore":"76","imdbRating":"7.5","imdbVotes":"735,709","imdbID":"tt1951264","Type":"movie","DVD":"N/A","BoxOffice":"$424,668,047","Production":"N/A","Website":"N/A","Response":"True"}
