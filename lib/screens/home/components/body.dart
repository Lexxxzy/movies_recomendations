// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'coming_movies.dart';
import 'recomendation_carousel.dart';
import 'search.dart';
import 'trending.dart';

import 'categories_menu.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Search(),
        const CategotiesMenu(),
        ComingMovies(),
        RecomendedMovieCarousel(),
        TrendingList(),
      ],
    );
  }
}
