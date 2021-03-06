// ignore_for_file: unnecessary_this

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../constants.dart';
import '../screens/authentication/components/my_snack_bar.dart';

class Movie with ChangeNotifier {
  final int id, seasons, age;
  final double ratingKinopoisk, ratingIMDb;
  final List<dynamic> genre, countries, frames;
  final String description, title, poster, premiereWorld, dateTo, filmNameDB;
  int recId;
  final bool ifSeries;
  bool isFavourite;
  final String authToken;

  Movie(
      {this.authToken = '',
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
      this.seasons = 0,
      this.dateTo = "",
      required this.frames,
      this.isFavourite = false,
      this.recId = 0,
      this.filmNameDB = ''}) {
    checkIsFavourite();
  }

  Future<void> checkIsFavourite() async {
    if (authToken != '') {
      final url = '$apiLink/favourites/is-favourite/${this.id}';
      var response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      });

      this.isFavourite = json.decode(response.body)['isFavourite'];
    }
  }

  void httpToggleFavourite() {
    final url = '$apiLink/favourites/${this.id}';
    http.put(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authToken',
    });
  }

  Future<bool?> toggleFavourite(context) async {
    try {
      httpToggleFavourite();
      this.isFavourite = !this.isFavourite;

      notifyListeners();
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const mySnackBar(message: 'Something went wrong', isError: true)
              .build(context));
    }
    return this.isFavourite;
  }

  void httpToggleLike() {
    final url = '$apiLink/likes/${this.id}';
    http.put(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authToken',
    });
  }

  Future<bool?> toggleLike(context) async {
    try {
      httpToggleLike();
      notifyListeners();
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const mySnackBar(message: 'Something went wrong', isError: true)
              .build(context));
    }
    return this.isFavourite;
  }

    Future<bool?> toggleDislike(context) async {
    try {
      final url = '$apiLink/likes/dislikes/${this.id}';
      http.put(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      });
      notifyListeners();
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const mySnackBar(message: 'Something went wrong', isError: true)
              .build(context));
    }
    return this.isFavourite;
  }

  void removeRecomendation(context) {
    try {
      final url = '$apiLink/recomendations/${this.filmNameDB}';
      http.put(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      });

      notifyListeners();
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const mySnackBar(message: 'Something went wrong', isError: true)
              .build(context));
    }
  }

  void removeFavourite(context) {
    try {
      httpToggleFavourite();
      this.isFavourite = false;

      notifyListeners();
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const mySnackBar(message: 'Something went wrong', isError: true)
              .build(context));
    }
  }
}
