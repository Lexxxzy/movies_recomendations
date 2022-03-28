import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../providers/movies_provider.dart';
import 'components/movie_detail_body.dart';

class MovieDetailScreen extends StatelessWidget {
  static const routeName = '/movie-detail';

  @override
  Widget build(BuildContext context) {
    final movieId =
        ModalRoute.of(context)?.settings.arguments as int; // is the id!
    final loadedMovie = Provider.of<Movies>(
      context,
      listen: false,
    ).findById(movieId);
    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: SingleChildScrollView(child: MovieDetailBody(loadedMovie)),
    );
  }
}
