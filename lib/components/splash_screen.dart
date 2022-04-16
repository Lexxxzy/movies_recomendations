// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies_recomendations/components/search.dart';
import 'package:movies_recomendations/components/shimmer_widget.dart';
import 'package:movies_recomendations/constants.dart';

import '../screens/home/components/recomendation_carousel.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: kDefaultPadding,
              left: kDefaultPadding,
              right: kDefaultPadding,
            ),
            child: Search(
              isEnabled: false,onSubmit: (str) {}, onSearchFocused: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
              bottom: kDefaultPadding,
            ),
            child: ShimmerWidget.rectengular(
              height: 115,
              shapeBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          buildRecomendationsHeader(),
          buildShimmerRecomendationCarousel(context),
          // RecomendedMovieCarousel(widget.tabController),
          // Padding(
          //   padding: const EdgeInsets.only(bottom: kDefaultPadding * 2),
          //   child: TrendingList(),
          // ),
        ]),
      ),
    );
  }

  Padding buildRecomendationsHeader() {
    return Padding(
      padding: const EdgeInsets.only(
        left: kDefaultPadding,
        top: kDefaultPadding / 2,
        right: kDefaultPadding,
        bottom: kDefaultPadding,
      ),
      child: SingleChildScrollView(
        child: Row(
          children: <Widget>[
            const Text(
              'Top 3 Recomendations',
              style: TextStyle(
                fontFamily: 'SFProDisplay',
                fontSize: 20,
                color: Color(0xffffffff),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(
              width: 15,
            ),
            SvgPicture.asset(
              'assets/icons/Recomedations.svg',
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  SizedBox buildShimmerRecomendationCarousel(BuildContext context) {
    return SizedBox(
      height: 340,
      child: Swiper(
        itemCount: 3,
        itemWidth: MediaQuery.of(context).size.width - 2 * 84,
        viewportFraction: 0.55,
        scale: 0.8,
        itemHeight: 150,
        index: 0,
        itemBuilder: (context, index) {
          return Stack(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Container(
                  margin: EdgeInsets.only(bottom: kDefaultPadding),
                  child: ShimmerWidget.rectengular(
                    height: 280,
                    shapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        pagination: SwiperCustomPagination(
          builder: (BuildContext context, SwiperPluginConfig config) {
            return buildCustomPagination(config);
          },
        ),
      ),
    );
  }

  buildSliderIndicator buildCustomPagination(SwiperPluginConfig config) {
    return buildSliderIndicator(
      config: config,
    );
  }
}
