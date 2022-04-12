import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './single_movie_provider.dart';

class TrendingMovies with ChangeNotifier {
  String plotText = "";

  List<Movie> _trendingMovies = [];

  List<Movie> get trendingMovies {
    return <Movie>[..._trendingMovies];
  }

  List<Movie> get trendingMoviesTop {
    return <Movie>[..._trendingMovies.take(3)];
  }

  Movie findById(int id) {
    return _trendingMovies.firstWhere((element) => element.id == id);
  }

  Future<void> fetchAndSetTrending() async {
    const url = 'http://192.168.1.142:5000/api/v1/trending/';

    try {
      var response = await http
          .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});

      String source = Utf8Decoder().convert(response.bodyBytes);

      final extractedData =
          List<Map<String, dynamic>>.from(json.decode(source));
      print(extractedData);

      final List<Movie> loadedMovies = [];
      extractedData.forEach(
        ((movieInfo) => {
              loadedMovies.add(Movie(
                id: movieInfo['id'],
                age: movieInfo['age'],
                countries: movieInfo['country'],
                description: movieInfo['description'],
                frames: movieInfo['frames'],
                genre: movieInfo['genre'],
                poster: movieInfo['poster'],
                premiereWorld: movieInfo['date'].toString(),
                ratingIMDb: movieInfo['ratingIMDb'],
                ratingKinopoisk: movieInfo['ratingKinopoisk'],
                title: movieInfo['title'][0],
                ifSeries: movieInfo['ifSeries'],
                dateTo: movieInfo['dateTo'].toString(),
                isFavourite: true,
                seasons: movieInfo['seasons'],
              )),
            }),
      );
      _trendingMovies = loadedMovies;
      notifyListeners();
    } on Exception catch (e) {}
  }
}
