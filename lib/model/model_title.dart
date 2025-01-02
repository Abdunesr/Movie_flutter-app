class Movies {
  final String title;
  final String year;
  final String poster;
  final String plot;
  final String imdbRating;
  final String Released;
  final String Runtime;
  final String Genre;
  final String Actors;

  Movies({
    required this.title,
    required this.year,
    required this.poster,
    required this.plot,
    required this.imdbRating,
    required this.Released,
    required this.Runtime,
    required this.Genre,
    required this.Actors,
  });

  // Factory method to parse data from the API response
  factory Movies.fromJson(Map<String, dynamic> json) {
    return Movies(
      title: json['Title'] ?? '',
      year: json['Year'] ?? '',
      poster: json['Poster'] ?? '',
      plot: json['Plot'] ?? '',
      imdbRating: json['imdbRating'] ?? '',
      Released: json['Released'] ?? '',
      Runtime: json['Runtime'] ?? '',
      Genre: json['Genre'] ?? '',
      Actors: json['Actors'] ?? '',
    );
  }
}
//{"Title":"The Hunger Games: Catching Fire","Year":"2013","Rated":"PG-13","Released":"22 Nov 2013","Runtime":"146 min","Genre":"Action, Adventure, Sci-Fi","Director":"Francis Lawrence","Writer":"Simon Beaufoy, Michael Arndt, Suzanne Collins","Actors":"Jennifer Lawrence, Josh Hutcherson, Liam Hemsworth","Plot":"Katniss Everdeen and Peeta Mellark become targets of the Capitol after their victory in the 74th Hunger Games sparks a rebellion in the Districts of Panem.","Language":"English","Country":"United States","Awards":"22 wins & 68 nominations","Poster":"https://m.media-amazon.com/images/M/MV5BMTAyMjQ3OTAxMzNeQTJeQWpwZ15BbWU4MDU0NzA1MzAx._V1_SX300.jpg","Ratings":[{"Source":"Internet Movie Database","Value":"7.5/10"},{"Source":"Rotten Tomatoes","Value":"90%"},{"Source":"Metacritic","Value":"76/100"}],"Metascore":"76","imdbRating":"7.5","imdbVotes":"735,709","imdbID":"tt1951264","Type":"movie","DVD":"N/A","BoxOffice":"$424,668,047","Production":"N/A","Website":"N/A","Response":"True"}
