
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../providers/single_movie_provider.dart';
import '../../movie_detail/movie_detail.dart';
import 'movie_card_description.dart';

class MovieCardRecomendations extends StatelessWidget {
  final Movie movie;
  const MovieCardRecomendations({Key? key, required this.movie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(
        width: MediaQuery.of(context).size.width.toDouble(),
        height: MediaQuery.of(context).size.height.toDouble() / 1.6,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: kDefaultPadding,
          right: kDefaultPadding,
        ),
        child: GestureDetector(
          onTap: (() {
            Navigator.of(context).pushNamed(
              MovieDetailScreen.routeName,
              arguments: movie.id,
            );
          }),
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 1.6,
            width: MediaQuery.of(context).size.width,
            child: Stack(children: [
              MovieCardPoster(movie: movie),
              MovieCardDescription(movie: movie),
            ]),
          ),
        ),
      ),
    );
  }
}

class MovieCardPoster extends StatelessWidget {
  const MovieCardPoster({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'poster_image',
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(90, 182, 182, 182),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(movie.poster),
          ),
          borderRadius: BorderRadius.circular(38),
          boxShadow: [kDefaultShadow],
          gradient:const LinearGradient(
            colors: [
              Color.fromARGB(136, 0, 0, 0),
              Colors.transparent
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.center,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            backgroundBlendMode: BlendMode.darken,
            borderRadius: BorderRadius.circular(32),
            gradient:const LinearGradient(
              colors: [
                Color.fromARGB(143, 0, 0, 0),
                Colors.transparent
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
      ),
    );
  }
}
