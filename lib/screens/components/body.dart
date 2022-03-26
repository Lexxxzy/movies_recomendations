// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:movies_recomendations/screens/components/coming_movies.dart';
import 'package:movies_recomendations/screens/components/search.dart';

import '../../constants.dart';
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
      ],
    );
  }
}
