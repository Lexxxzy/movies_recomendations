import 'package:flutter/material.dart';
import '/providers/single_movie_provider.dart';
import '../../../constants.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({Key? key, required this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return buildMovieCard(context);
  }

  Container buildMovieCard(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 200),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [kDefaultShadow],
            color: const Color(0xFF26334A),
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(movie.poster),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      movie.title,
                      style: const TextStyle(
                        fontFamily: 'SFProDisplay',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: kTextColor,
                      ),
                    ),
                    const SizedBox(height: kDefaultPadding / 3),
                    Text(
                      "${movie.genre[0]}",
                      style: const TextStyle(
                        fontFamily: 'SFProDisplay',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: kTextLightColor,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
