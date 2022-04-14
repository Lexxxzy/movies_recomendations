import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './single_movie_provider.dart';

class UpcomingMovies with ChangeNotifier {
  String plotText = "";

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

  Future<void> fetchAndSetUpcoming() async {
    const url = 'http://192.168.1.142:5000/api/v1/trending/';

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
                id: movieInfo['id'],
                age: movieInfo['age'],
                countries: movieInfo['country'],
                description: movieInfo['description'],
                frames: movieInfo['frames'],
                genre: movieInfo['genre'],
                poster: movieInfo['poster'],
                premiereWorld: movieInfo['date'].toString(),
                ratingIMDb: 0.0,
                ratingKinopoisk: 0.0,
                title: movieInfo['title'][0],
                ifSeries: movieInfo['ifSeries'] == 'true' ? true : false,
                dateTo: '',
                isFavourite: false,
                seasons: 0,
              )),
            }),
      );
      _upcomingMovies = loadedMovies;
      notifyListeners();
    } on Exception catch (e) {}
  }
}
