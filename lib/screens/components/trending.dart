// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '/models/movie.dart';
import '../../../constants.dart';

class TrendingList extends StatefulWidget {
  const TrendingList({Key? key}) : super(key: key);

  @override
  State<TrendingList> createState() => _TrendingListState();
}

class _TrendingListState extends State<TrendingList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          buildRecomendationsHeader(),
          SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Column(
                children: <Widget>[
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      return buildTrendingMovie(index);
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding buildTrendingMovie(int index) {
    return Padding(
      padding: const EdgeInsets.only(
        top: kDefaultPadding,
        left: kDefaultPadding,
        right: kDefaultPadding,
      ),
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              width: 111,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(movies[index].poster, fit: BoxFit.cover),
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
                  Row(
                    children: [
                      Text(
                        '${movies[index].ratingKinopoisk}',
                        style: TextStyle(
                            fontFamily: 'SFProDisplay',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: movies[index].ratingKinopoisk >= 7.0
                                ? kGreenColor
                                : kWarningColor),
                      ),
                      Text(
                        ' | ${movies[index].countries.join(", ")}',
                        style: const TextStyle(
                          fontFamily: 'SFProText',
                          fontSize: 12,
                          color: kTextLightColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    movies[index].title,
                    style: const TextStyle(
                      fontFamily: 'SFProDisplay',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: kTextColor,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${movies[index].premiereWorld}, ${movies[index].genre[0]}',
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
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    movies[index].isFavourite = !movies[index].isFavourite;
                  });
                },
                child: SvgPicture.asset(
                  movies[index].isFavourite == false
                      ? 'assets/icons/HeartOutlined.svg'
                      : 'assets/icons/Heart.svg',
                  height: 20,
                  alignment: Alignment.topRight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildRecomendationsHeader() {
    return Padding(
      padding: const EdgeInsets.only(
        left: kDefaultPadding,
        right: kDefaultPadding,
      ),
      child: Row(
        children: <Widget>[
          const Text(
            'Trending',
            style: TextStyle(
              fontFamily: 'SFProDisplay',
              fontSize: 20,
              color: Color(0xffffffff),
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(
            width: 10,
          ),
          SvgPicture.asset(
            'assets/icons/Fire.svg',
            height: 20,
          ),
        ],
      ),
    );
  }
}
