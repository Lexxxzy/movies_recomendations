import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import 'components/movie_detail_body.dart';

class MovieDetailScreen extends StatelessWidget {
  static const routeName = '/movie-detail';

  @override
  Widget build(BuildContext context) {
    final movieId = ModalRoute.of(context)?.settings.arguments as int;
    print(movieId); // is the id!
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(child: MovieDetailBody(movieId)),
    );
  }
}
