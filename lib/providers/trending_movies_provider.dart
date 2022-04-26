import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import './single_movie_provider.dart';

class TrendingMovies with ChangeNotifier {
  final String authToken;

  TrendingMovies(this.authToken, this._trendingMovies);

  List<Movie> _trendingMovies = [];

  List<Movie> get trendingMovies {
    return <Movie>[..._trendingMovies];
  }

  List<Movie> get trendingMoviesTop {
    return <Movie>[..._trendingMovies.take(5)];
  }

  Movie findById(int id) {
    return _trendingMovies.firstWhere((element) => element.id == id);
  }

  Future<void> fetchAndSetTrending() async {
    const url = '$apiLink/suggestions/top-films';

    try {
      var response = await http
          .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});

      String source = Utf8Decoder().convert(response.bodyBytes);

      final extractedData =
          List<Map<String, dynamic>>.from(json.decode(source));

      final List<Movie> loadedMovies = [];
      extractedData.forEach(
        ((movieInfo) => {
              loadedMovies.add(Movie(
                authToken: authToken,
                id: movieInfo['id'],
                age: movieInfo['age'],
                countries: List<String>.from(movieInfo['country']),
                description: movieInfo['description'],
                frames: movieInfo['frames'],
                genre: movieInfo['genre'],
                poster: movieInfo['poster'],
                premiereWorld: movieInfo['date'].toString(),
                ratingIMDb: movieInfo['ratingIMDb'] ?? 0.0,
                ratingKinopoisk: movieInfo['ratingKinopoisk'] ?? 0.0,
                title: movieInfo['title'][0],
                ifSeries: movieInfo['ifSeries'],
                dateTo: movieInfo['dateTo'].toString(),
                seasons: movieInfo['seasons'],
                videoURL: '',
              )),
            }),
      );
      _trendingMovies = loadedMovies;
      notifyListeners();
    } on Exception catch (e) {}
  }
}
