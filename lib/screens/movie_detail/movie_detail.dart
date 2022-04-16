import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../providers/single_movie_provider.dart';
import 'components/movie_detail_body.dart';

class MovieDetailScreen extends StatelessWidget {
  static const routeName = '/movie-detail';

  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)?.settings.arguments as Movie;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
          child: MovieDetailBody(movie)),
    );
  }
}
