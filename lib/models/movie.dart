
class Movie {
  final int? id, seasons, age;
  final double ratingKinopoisk, ratingIMDb;
  final List<String> genre, countries, frames;
  final String description, title, poster, premiereWorld, dateTo;
  final bool ifSeries;
  bool isFavourite;

  Movie({
    required this.poster,
    required this.title,
    required this.id,
    required this.premiereWorld,
    required this.ratingKinopoisk,
    required this.ratingIMDb,
    required this.genre,
    required this.description,
    required this.countries,
    required this.age,
    required this.ifSeries,
    this.seasons,
    this.dateTo = "",
    required this.frames,
    required this.isFavourite,
  });
}
