import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../providers/single_movie_provider.dart';
import '../screens/movie_detail/movie_detail.dart';

enum ListTypes {
  trending,
  recomendations,
  favourites,
  upcomings,
  topNetflix,
}

class FavouriteMovie extends StatefulWidget {
  ListTypes listType;
  FavouriteMovie({Key? key, this.listType = ListTypes.favourites})
      : super(key: key);

  @override
  State<FavouriteMovie> createState() => _FavouriteMovieState();
}

class _FavouriteMovieState extends State<FavouriteMovie> {
  @override
  Widget build(BuildContext context) {
    var movieData = Provider.of<Movie>(context);

    switch (widget.listType) {
      case ListTypes.trending:
        break;
      default:
    }
    return GestureDetector(
      onTap: (() {
        Navigator.of(context).pushNamed(
          MovieDetailScreen.routeName,
          arguments: movieData,
        );
      }),
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: kDefaultPadding,
          left: kDefaultPadding,
          right: kDefaultPadding,
        ),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(32)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: movieData.poster,
                child: SizedBox(
                  height: 100,
                  width: 111,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(movieData.poster, fit: BoxFit.cover),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Container(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${MediaQuery.of(context).size.width < 380 ? movieData.countries.take(2).join(", ") : movieData.countries.take(2).join(", ")}',
                      style: const TextStyle(
                        fontFamily: 'SFProText',
                        fontSize: 12,
                        color: kTextLightColor,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Hero(
                      tag: movieData.title,
                      child: DefaultTextStyle(
                        style: TextStyle(
                          fontFamily: 'SFProDisplay',
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: kTextColor,
                        ),
                        child: Text(
                          movieData.title.length > 20
                              ? '${movieData.title.substring(0, 18)}...'
                              : movieData.title,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${movieData.premiereWorld}, ${movieData.genre[0]}',
                      style: const TextStyle(
                        fontFamily: 'SFProText',
                        fontSize: 14,
                        color: kTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: LikeButton(
                  size: 23,
                  circleColor: CircleColor(
                    start: kMainColor,
                    end: kMainColor,
                  ),
                  isLiked: movieData.isFavourite,
                  onTap: (bool) {
                    final snackBar = movieData.isFavourite == false
                        ? buildAddToFavouriteSnackBox()
                        : buildRemovedFromFavouriteSnackBox(movieData);
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    return movieData.toggleFavourite(context);
                  },
                  likeBuilder: (isTapped) {
                    return SvgPicture.asset(
                      'assets/icons/Heart.svg',
                      height: 20,
                      color: isTapped ? kMainColor : kTextGreyColor,
                      alignment: Alignment.topRight,
                    );
                  },
                ),
              ),
              // SvgPicture.asset(
              //   movieData.isFavourite == false
              //       ? 'assets/icons/HeartOutlined.svg'
              //       : 'assets/icons/Heart.svg',
              //   height: 20,
              //   alignment: Alignment.topRight,
              // ),
            ],
          ),
        ),
      ),
    );
  }

  SnackBar buildAddToFavouriteSnackBox() {
    return SnackBar(
      elevation: 0,
      margin: const EdgeInsets.only(
        bottom: kDefaultPadding,
        left: kDefaultPadding * 3,
        right: kDefaultPadding * 3,
      ),
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.endToStart,
      content: const Text(
        'Added to favourite',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'SFProDisplay',
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: kGreenColor.withOpacity(0.9),
      duration: Duration(milliseconds: 1200),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  SnackBar buildRemovedFromFavouriteSnackBox(Movie movieData) {
    return SnackBar(
      elevation: 0,
      action: SnackBarAction(
        label: 'Undo',
        textColor: Color.fromARGB(255, 255, 153, 85),
        onPressed: () {
          movieData.toggleFavourite(context);
        },
      ),
      margin: const EdgeInsets.only(
        bottom: kDefaultPadding,
        left: kDefaultPadding * 3,
        right: kDefaultPadding * 3,
      ),
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.endToStart,
      content: const Text(
        'Removed from favourite',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'SFProDisplay',
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: kErrorColor.withOpacity(0.9),
      duration: Duration(milliseconds: 2000),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}

Color ratingColor(Movie movie) {
  double rating = movie.ratingKinopoisk;
  if (rating >= 7.1) {
    return kGreenColor;
  } else if (rating < 7.1 && rating >= 5) {
    return kWarningColor;
  } else if (rating == 0.0) {
    return kTextGreyColor;
  } else {
    return kErrorColor;
  }
}
