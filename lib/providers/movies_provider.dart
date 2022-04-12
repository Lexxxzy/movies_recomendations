import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movies_recomendations/constants.dart';
import 'package:http/http.dart' as http;

import './single_movie_provider.dart';

class Movies with ChangeNotifier {
  String plotText = "";
  final String authToken;

  Movies(this.authToken, this._movies);

  List<Movie> _movies = [];

  List<Movie> get movies {
    return <Movie>[..._movies];
  }

  Movie findById(int id) {
    return _movies.firstWhere((element) => element.id == id);
  }

  List<Movie> get favouriteMovies {
    List<Movie> favMovies = <Movie>[..._movies]
        .where((element) => element.isFavourite == true)
        .toList();
    return favMovies;
  }

  void removeItem(movieId) {
    favouriteMovies.remove(findById(movieId));
    notifyListeners();
  }

  void addMovie(Movie movie) {
    /*_movies.add(movie);*/
    notifyListeners();
  }

  Future<void> fetchAndSetMovies() async {
    //const url = 'http://192.168.1.142:5000/api/v1/favourites/';
    const url = 'http://192.168.1.142:9000/Desktop/favourites.json';
    try {
      var response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json'
      });

      String source = Utf8Decoder().convert(response.bodyBytes);

      final extractedData =
          List<Map<String, dynamic>>.from(json.decode(source)['favourites']);
      final List<Movie> loadedMovies = [];
      extractedData.forEach(
        ((movieInfo) => {
              loadedMovies.add(Movie(
                id: movieInfo['id'],
                age: movieInfo['age'],
                countries: List<String>.from(movieInfo['country']),
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
      _movies = loadedMovies;
      notifyListeners();
    } on Exception catch (e) {}
  }
}
