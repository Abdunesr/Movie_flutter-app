class Movie {
  final String imdbID;
  final String title;
  final String year;
  final String poster;
  final String Type;
  double? userRating; // Add this to store the user's rating

  Movie({
    required this.imdbID,
    required this.title,
    required this.year,
    required this.poster,
    required this.Type,
    this.userRating,
  });

  // Update fromJson and toJson to include userRating if needed
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      imdbID: json['imdbID'],
      title: json['Title'],
      year: json['Year'],
      poster: json['Poster'],
      Type: json['Type'],
      userRating: json['userRating'] != null
          ? double.tryParse(json['userRating'].toString())
          : null,
    );
  }
}
