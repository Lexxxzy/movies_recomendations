import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_recomendations/constants.dart';
import 'package:movies_recomendations/screens/movie_detail/components/video_player_widget.dart';

import '../../../providers/single_movie_provider.dart';
import 'movie_detail_body.dart';

class PosterAndRating extends StatelessWidget {
  PosterAndRating({Key? key, required this.size, required this.loadedMovie})
      : super(key: key);

  Size size;
  Movie loadedMovie;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.50,
      child: Stack(
        children: [
          VideoPoster(
            loadedMovie: loadedMovie,
          ),
          //RatingBox
          Positioned(
            bottom: 0,
            right: kDefaultPadding,
            child:
                buildRatingBox(text: (loadedMovie.ratingKinopoisk).toString()),
          ),
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding / 2),
            child: SafeArea(
              child: Container(
                height: 30,
                width: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  color: Colors.black45,
                ),
                child: IconButton(
                    icon: SvgPicture.asset(
                      'assets/icons/Back.svg',
                      height: 14,
                      color: Colors.white,
                    ),
                    tooltip:
                        MaterialLocalizations.of(context).backButtonTooltip,
                    onPressed: () {
                      Navigator.maybePop(context);
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildRatingBox(
      {double boxHeight = 40, double boxWidth = 60, String text = '8.0'}) {
    return Container(
      height: 40,
      width: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        color: ratingColor(loadedMovie),
        boxShadow: [kDefaultShadow],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${loadedMovie.ratingKinopoisk}',
            style: TextStyle(
              fontFamily: 'SFProDisplay',
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 3,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: SvgPicture.asset(
              'assets/icons/Star.svg',
              height: 14,
            ),
          )
        ],
      ),
    );
  }
}
