// ignore_for_file: prefer_const_constructors, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies_recomendations/constants.dart';

import '../../../models/movie.dart';
import 'poster_rating.dart';

class MovieDetailBody extends StatefulWidget {
  MovieDetailBody(this.loadedMovie);
  final Movie loadedMovie;

  @override
  State<MovieDetailBody> createState() => _MovieDetailBodyState();
}

class _MovieDetailBodyState extends State<MovieDetailBody> {
  Color colorOfRaing = kGreenColor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        PosterAndRating(
          size: size,
          loadedMovie: widget.loadedMovie,
        ),
        buildMovieInfo(),
        buildFrames(),
        buildDescrition(),
        buildFooter()
      ],
    );
  }

  Padding buildFooter() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: kDefaultPadding / 1.5,
        horizontal: kDefaultPadding,
      ),
      child: SingleChildScrollView(
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
                loadedMovie: widget.loadedMovie,
                text: widget.loadedMovie.ratingKinopoisk.toString(),
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
                loadedMovie: widget.loadedMovie,
                text: widget.loadedMovie.ratingIMDb.toString(),
              ),
            ],
          ),
          SizedBox(
            width: 15,
          ),
          buildButton()
        ]),
      ),
    );
  }

  ElevatedButton buildButton() {
    return ElevatedButton(
      onPressed: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        child: Text(
          'ADD TO FAVOURITES',
          style: TextStyle(
            fontFamily: 'SFProText',
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        primary: kButtomsGreyColor,
      ),
    );
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

  Padding buildDescrition() {
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
              widget.loadedMovie.description,
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

  Padding buildFrames() {
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
              itemCount: widget.loadedMovie.frames.length,
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
                  child: buildFrameCard(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Stack buildFrameCard(int index) {
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
              color: Colors.white12,
              image: DecorationImage(
                image: NetworkImage(widget.loadedMovie.frames[index]),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Padding buildMovieInfo() {
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
                  widget.loadedMovie.countries.join(', '),
                  style: TextStyle(
                    fontFamily: 'SFProText',
                    fontSize: 14,
                    color: kTextLightColor,
                  ),
                ),
                Text(
                  widget.loadedMovie.title,
                  style: TextStyle(
                    fontFamily: 'SFProDisplay',
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  '${widget.loadedMovie.premiereWorld} | ${widget.loadedMovie.age}+${ifSerial(widget.loadedMovie)} | ${widget.loadedMovie.genre.join(', ')}',
                  style: TextStyle(
                    fontFamily: 'SFProText',
                    fontSize: 14,
                    color: kTextLightColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
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
                widget.loadedMovie.isFavourite == true
                    ? 'assets/icons/Heart.svg'
                    : 'assets/icons/HeartOutlined.svg',
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
  } else {
    return kErrorColor;
  }
}

String ifSerial(Movie movie) {
  return movie.ifSeries == true ? ' | ${movie.seasons} seasons' : '';
}
