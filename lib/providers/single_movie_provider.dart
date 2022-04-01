// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';
import 'package:movies_recomendations/components/trending_favourite_movie.dart';
import 'movies_provider.dart';

class Movie with ChangeNotifier {
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
    this.isFavourite = false,
  });

  void toggleFavourite() {
    this.isFavourite = !this.isFavourite;
    notifyListeners();
  }
  


}
