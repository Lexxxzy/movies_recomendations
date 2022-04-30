import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import './single_movie_provider.dart';

class RecomendedMovies with ChangeNotifier {
  String plotText = "";
  final String authToken;

  RecomendedMovies(this.authToken, this._recomendedMovies);

  List<Movie> _recomendedMovies = [];

  List<Movie> get recomendedMovies {
    return <Movie>[..._recomendedMovies.reversed];
  }

  List<Movie> get recomendedMoviesTop {
    return <Movie>[..._recomendedMovies.take(3)];
  }

  Movie findById(int id) {
    return _recomendedMovies.firstWhere((element) => element.id == id);
  }

  Future<void> fetchAndSetRecomendations() async {
    const url = '$apiLink/recomendations/';

    try {
      var response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json'
      });

      String source = Utf8Decoder().convert(response.bodyBytes);

      final extractedData = List<Map<String, dynamic>>.from(
          json.decode(source)['recomendations']);

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
                  recId: movieInfo['recsID'],
                  filmNameDB: movieInfo['filmNameDB']
                ),
              ),
            }),
      );
      _recomendedMovies = loadedMovies;
      notifyListeners();
    } on Exception catch (e) {}
  }
}
