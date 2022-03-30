// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:movies_recomendations/constants.dart';
import 'coming_movies.dart';
import 'recomendation_carousel.dart';
import 'search.dart';
import 'trending.dart';

import '../../../components/categories_menu.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CategotiesMenu(),
      ],
    );
  }
}

class MainScreenWidgets extends StatelessWidget {
  const MainScreenWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: SingleChildScrollView(
        child: Column(children: [
          const Search(),
          ComingMovies(),
          RecomendedMovieCarousel(),
          Padding(
            padding: const EdgeInsets.only(bottom: kDefaultPadding * 2),
            child: TrendingList(),
          ),
        ]),
      ),
    );
  }
}
