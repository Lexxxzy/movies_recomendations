import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import './single_movie_provider.dart';

class SuggestedMovies with ChangeNotifier {
  String plotText = "";
  final String authToken;

  SuggestedMovies(this.authToken, this._upcomingMovies);

  List<Movie> _upcomingMovies = [];

  List<Movie> get upcomingMovies {
    return <Movie>[..._upcomingMovies];
  }

  List<Movie> get upcomingMoviesTop {
    return <Movie>[..._upcomingMovies.take(3)];
  }

  Movie findById(int id) {
    return _upcomingMovies.firstWhere((element) => element.id == id);
  }

  Future<void> fetchAndSetSuggestions(sugestionTypeURL) async {
    final url =
        '$apiLink/suggestions/$sugestionTypeURL';

    try {
      var response = await http
          .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});

      String source = Utf8Decoder().convert(response.bodyBytes);

      final extractedData =
          List<Map<String, dynamic>>.from(json.decode(source));

      final List<Movie> loadedMovies = [];
      extractedData.forEach(
        ((movieInfo) => {
              loadedMovies.add(
                Movie(
                  authToken: authToken,
                  id: movieInfo['id'],
                  age: movieInfo['age'],
                  countries: movieInfo['country'],
                  description: movieInfo['description'],
                  frames: movieInfo['frames'],
                  genre: movieInfo['genre'],
                  poster: movieInfo['poster'],
                  premiereWorld: movieInfo['date'].toString(),
                  ratingIMDb: movieInfo['ratingIMDb'] ?? 0.0,
                  ratingKinopoisk: movieInfo['ratingKinopoisk'] ?? 0.0,
                  title: movieInfo['title'][0],
                  ifSeries: movieInfo['ifSeries'] == 'true' ? true : false,
                  dateTo: movieInfo['dateTo'].toString(),
                  isFavourite: false,
                  seasons: movieInfo['seasons'] ?? 0,
                ),
              ),
            }),
      );
      _upcomingMovies = loadedMovies;
      notifyListeners();
    } on Exception catch (e) {}
  }
}
