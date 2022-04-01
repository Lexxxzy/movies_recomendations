import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_recomendations/screens/movie_detail/components/movie_detail_body.dart';

import '../../../constants.dart';
import '../../../providers/single_movie_provider.dart';
import '../../movie_detail/movie_detail.dart';

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
              /*
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(movie.poster),
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: 20, sigmaY: 20, tileMode: TileMode.mirror),
                  child: Container(
                    color: Colors.black.withOpacity(0.0),
                  ),
                ),
              ),*/
              Hero(
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
                    gradient: LinearGradient(
                      colors: const [
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
                      gradient: LinearGradient(
                        colors: const [
                          Color.fromARGB(143, 0, 0, 0),
                          Colors.transparent
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
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
                          color: Color.fromARGB(96, 255, 255, 255),
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
                                    Text(
                                      movie.title,
                                      style: TextStyle(
                                        fontFamily: 'SFProDisplay',
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Text(
                                          movie.ratingKinopoisk.toString(),
                                          style: TextStyle(
                                            fontFamily: 'SFProDisplay',
                                            color: ratingColor(movie),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          ' | ${movie.premiereWorld}',
                                          style: TextStyle(
                                            fontFamily: 'SFProText',
                                            color: kTextLightColor,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/GoTo.svg',
                                      color: Colors.white,
                                      height: 16,
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              18,
                                      width:
                                          MediaQuery.of(context).size.height /
                                              18,
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(117, 247, 247, 247),
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
              ), /*
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  gradient: LinearGradient(colors: const [
                    Color.fromARGB(108, 0, 0, 0),
                    Colors.transparent
                  ], begin: Alignment.bottomCenter, end: Alignment.center),
                ),
              ),*/
            ]),
          ),
        ),
      ),
    );
  }
}
