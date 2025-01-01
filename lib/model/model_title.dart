class Movie {
  final String title;
  final String year;
  final String poster;
  final String plot;

  Movie({
    required this.title,
    required this.year,
    required this.poster,
    required this.plot,
  });

  // Factory method to parse data from the API response
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['Title'] ?? '',
      year: json['Year'] ?? '',
      poster: json['Poster'] ?? '',
      plot: json['Plot'] ?? '',
    );
  }
}
