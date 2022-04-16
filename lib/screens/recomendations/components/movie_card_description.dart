import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:movies_recomendations/constants.dart';

import '../../../providers/single_movie_provider.dart';
import '../../movie_detail/components/movie_detail_body.dart';

class MovieCardDescription extends StatelessWidget {
  const MovieCardDescription({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 9,
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 7,
                sigmaY: 7,
              ),
              child: Container(
                color: const Color.fromARGB(96, 255, 255, 255),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding - 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DefaultTextStyle(
                            style: const TextStyle(
                              fontFamily: 'SFProDisplay',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                            child: Text(
                              movie.title.length > 18
                                  ? '${movie.title.substring(0, 18)}...'
                                  : movie.title,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              DefaultTextStyle(
                                style: TextStyle(
                                  fontFamily: 'SFProDisplay',
                                  color: ratingColor(movie),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                                child: Text(
                                  movie.ratingKinopoisk.toString(),
                                ),
                              ),
                              DefaultTextStyle(
                                style: const TextStyle(
                                  fontFamily: 'SFProText',
                                  color: kTextLightColor,
                                  fontSize: 15,
                                ),
                                child: Text(
                                  ' | ${movie.premiereWorld}',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/GoTo.svg',
                            color: Colors.white,
                            height: 16,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height / 18,
                            width: MediaQuery.of(context).size.height / 18,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(117, 247, 247, 247),
                              shape: BoxShape.circle,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
