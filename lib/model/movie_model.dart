class Movie {
  final String imdbID;
  final String title;
  final String year;
  final String poster;

  Movie({
    required this.imdbID,
    required this.title,
    required this.year,
    required this.poster,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      imdbID: json['imdbID'] as String,
      title: json['Title'] as String,
      year: json['Year'] as String,
      poster: json['Poster'] as String,
    );
  }
}
