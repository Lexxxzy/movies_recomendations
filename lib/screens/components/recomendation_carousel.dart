// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '/models/movie.dart';
import '../../../constants.dart';

class RecomendedMovieCarousel extends StatefulWidget {
  const RecomendedMovieCarousel({Key? key}) : super(key: key);

  @override
  State<RecomendedMovieCarousel> createState() =>
      _RecomendedMovieCarouselState();
}

class _RecomendedMovieCarouselState extends State<RecomendedMovieCarousel> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          buildRecomendationsHeader(),
          buildCarousel(context),
        ],
      ),
    );
  }

  SizedBox buildCarousel(BuildContext context) {
    return SizedBox(
      height: 340,
      child: Swiper(
        itemCount: movies.length,
        itemWidth: MediaQuery.of(context).size.width - 2 * 84,
        viewportFraction: 0.55,
        scale: 0.8,
        itemHeight: 300,
        index: 0,
        autoplayDelay: kDefaultAutoplayDelayMs * 2,
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
            child: Stack(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: buildMovieCard(context, index),
                ),
              ],
            ),
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

  Column buildMovieCard(BuildContext context, int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Card(
          elevation: 10,
          shadowColor: const Color.fromRGBO(18, 33, 61, 0.58),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: const Color(0xFF26334A),
          child: Column(
            children: [
              SizedBox(
                height: 150,
                width: MediaQuery.of(context).size.width - 2 * 64,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(movies[index].poster, fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      movies[index].title,
                      style: const TextStyle(
                        fontFamily: 'SFProDisplay',
                        fontSize: 20,
                        color: kTextColor,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${movies[index].genre[0]} | ${movies[index].age}+ ',
                      style: const TextStyle(
                        fontFamily: 'SFProDisplay',
                        fontSize: 12,
                        color: kTextLightColor,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: const <Widget>[
                        Text(
                          'Details',
                          style: TextStyle(
                            fontFamily: 'SFProDisplay',
                            fontSize: 14,
                            color: kTextLightColor,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: kTextLightColor,
                          size: 14,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  buildSliderIndicator buildCustomPagination(SwiperPluginConfig config) {
    return buildSliderIndicator(
      config: config,
    );
  }

  Padding buildRecomendationsHeader() {
    return Padding(
      padding: const EdgeInsets.only(
        left: kDefaultPadding,
        top: kDefaultPadding,
        right: kDefaultPadding,
      ),
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
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(
                fontSize: 14,
                fontFamily: 'SFProDisplay',
                fontWeight: FontWeight.w600,
              ),
            ),
            onPressed: () {},
            child: const Text(
              'See All',
              style: TextStyle(
                color: Color(0xFF75BBED),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class buildSliderIndicator extends StatelessWidget {
  const buildSliderIndicator({
    Key? key,
    required SwiperPluginConfig config,
  })  : _config = config,
        super(key: key);

  final SwiperPluginConfig _config;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      alignment: Alignment.bottomCenter,
      child: SmoothPageIndicator(
        controller: _config.pageController,
        count: movies.length,
        effect: const ExpandingDotsEffect(
          expansionFactor: 8,
          dotWidth: 6,
          dotHeight: 6,
          spacing: 7,
          activeDotColor: kTextColor,
        ),
        onDotClicked: (index) {
          _config.pageController.animateToPage(
            index,
            duration: const Duration(
              milliseconds: 300,
            ),
            curve: Curves.easeInOut,
          );
        },
      ),
    );
  }
}
