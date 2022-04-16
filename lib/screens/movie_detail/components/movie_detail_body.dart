// ignore_for_file: prefer_const_constructors, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies_recomendations/constants.dart';
import 'package:provider/provider.dart';

import '../../../components/button.dart';
import '../../../providers/movies_provider.dart';
import '../../../providers/single_movie_provider.dart';
import '../../../providers/upcoming_movies_provider.dart';
import 'poster_rating.dart';

class MovieDetailBody extends StatefulWidget {
  MovieDetailBody(this.movie);
  final Movie movie;

  @override
  State<MovieDetailBody> createState() => _MovieDetailBodyState();
}

class _MovieDetailBodyState extends State<MovieDetailBody> {
  Color colorOfRaing = kGreenColor;

  @override
  Widget build(BuildContext context) {
    Movie loadedMovie = widget.movie;

    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        details.globalPosition.dx;
        Navigator.maybePop(context);
      },
      child: ChangeNotifierProvider(
        create: (BuildContext context) {
          loadedMovie;
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            PosterAndRating(
              size: size,
              loadedMovie: loadedMovie,
            ),
            buildMovieInfo(loadedMovie),
            loadedMovie.frames.isNotEmpty
                ? buildFrames(loadedMovie)
                : Container(),
            buildDescrition(loadedMovie),
            buildFooter(loadedMovie)
          ],
        ),
      ),
    );
  }

  Padding buildFooter(loadedMovie) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: kDefaultPadding / 1.5,
        horizontal: kDefaultPadding,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: kDefaultPadding * 1.5),
          child: Row(children: [
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/Kinopoisk.svg',
                  height: 16,
                ),
                SizedBox(
                  width: 10,
                ),
                buildRatingBox(
                  boxHeight: 35,
                  boxWidth: 35,
                  loadedMovie: loadedMovie,
                  text: loadedMovie.ratingKinopoisk.toString(),
                ),
                SizedBox(
                  width: kDefaultPadding - 10,
                ),
                SvgPicture.asset(
                  'assets/icons/IMDb.svg',
                  height: 13,
                ),
                SizedBox(
                  width: 10,
                ),
                buildRatingBox(
                  boxHeight: 35,
                  boxWidth: 35,
                  loadedMovie: loadedMovie,
                  text: loadedMovie.ratingIMDb.toString(),
                ),
              ],
            ),
            SizedBox(
              width: 15,
            ),
            MediaQuery.of(context).size.width > 380
                ? buildButton('ADD TO FAVOURITES')
                : Spacer(),
          ]),
        ),
      ),
    );
  }

  greyButton buildButton(String content) {
    return greyButton(content: content, onPress: () => {});
  }

  Container buildRatingBox({
    double boxHeight = 40,
    double boxWidth = 60,
    required Movie loadedMovie,
    required String text,
  }) {
    return Container(
      height: boxHeight,
      width: boxWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: ratingColor(loadedMovie),
        boxShadow: [kDefaultShadow],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              fontFamily: 'SFProDisplay',
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Padding buildDescrition(Movie loadedMovie) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: kDefaultPadding / 1.5,
        horizontal: kDefaultPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Description',
            style: TextStyle(
              fontFamily: 'SFProText',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: kTextColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              loadedMovie.description,
              style: TextStyle(
                fontFamily: 'SFProText',
                fontSize: 14,
                height: 1.6,
                color: kTextLightColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding buildFrames(Movie loadedMovie) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 1.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding),
            child: Text(
              'Frames',
              style: TextStyle(
                fontFamily: 'SFProText',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: kTextColor,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 110,
            child: Swiper(
              itemCount: loadedMovie.frames.length,
              itemWidth: 170,
              viewportFraction: 0.50,
              scale: 0.6,
              itemHeight: 100,
              index: 0,
              fade: 0.2,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    /*Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, a, b) => DetailPage(
                            planetInfo: planets[index],
                          ),
                        ),
                      );*/
                  },
                  child: buildFrameCard(index, loadedMovie),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Stack buildFrameCard(int index, Movie loadedMovie) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Container(
            height: 100,
            width: 170,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              boxShadow: [kDefaultShadow],
              color: Color.fromARGB(8, 255, 255, 255),
              image: DecorationImage(
                image: NetworkImage(loadedMovie.frames[index]),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Padding buildMovieInfo(Movie loadedMovie) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 3),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  loadedMovie.countries.join(', '),
                  style: TextStyle(
                    fontFamily: 'SFProText',
                    fontSize: 14,
                    color: kTextLightColor,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      right: kDefaultPadding / 4,
                      bottom: kDefaultPadding / 2,
                      top: kDefaultPadding / 2),
                  child: Hero(
                    tag: loadedMovie.title,
                    child: DefaultTextStyle(
                      style: TextStyle(
                          fontFamily: 'SFProDisplay',
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          height: 1),
                      child: Text(
                        loadedMovie.title,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  '${loadedMovie.premiereWorld} ${ifAgeNull(loadedMovie)}${ifSerial(loadedMovie)} | ${loadedMovie.genre.join(', ')}',
                  style: TextStyle(
                    fontFamily: 'SFProText',
                    fontSize: 14,
                    color: kTextLightColor,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                loadedMovie.toggleFavourite(context);
              });
            },
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                color: Colors.white24,
              ),
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: SvgPicture.asset(
                  loadedMovie.isFavourite == true
                      ? 'assets/icons/Heart.svg'
                      : 'assets/icons/HeartOutlined.svg',
                ),
              ),
            ),
          )
        ],
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
    return kTextLightColor;
  } else {
    return kErrorColor;
  }
}

String ifSerial(Movie movie) {
  return movie.ifSeries == true ? ' | ${movie.seasons} seasons' : '';
}

String ifAgeNull(Movie movie) {
  return movie.age != null ? ' | ${movie.age}+' : '';
}
