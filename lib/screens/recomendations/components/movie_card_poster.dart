

import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../providers/single_movie_provider.dart';


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
