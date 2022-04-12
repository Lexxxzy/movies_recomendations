// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../constants.dart';
import '../../../providers/single_movie_provider.dart';
import '../../movie_detail/movie_detail.dart';
import '/providers/movies_provider.dart';

class RecomendedMovieCarousel extends StatefulWidget {
  late TabController tabController;
  RecomendedMovieCarousel(TabController tabController, {Key? key})
      : super(key: key) {
    this.tabController = tabController;
  }

  @override
  State<RecomendedMovieCarousel> createState() =>
      _RecomendedMovieCarouselState();
}

class _RecomendedMovieCarouselState extends State<RecomendedMovieCarousel> {
  @override
  Widget build(BuildContext context) {
    final movies = Provider.of<Movies>(context).movies;
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          buildRecomendationsHeader(),
          buildCarousel(context, movies),
        ],
      ),
    );
  }

  SizedBox buildCarousel(BuildContext context, List<Movie> movies) {
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
                  child: buildMovieCard(context, index, movies),
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

  GestureDetector buildMovieCard(
      BuildContext context, int index, List<Movie> movies) {
    return GestureDetector(
      onTap: (() {
        Navigator.of(context).pushNamed(
          MovieDetailScreen.routeName,
          arguments: movies[index].id,
        );
      }),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Card(
            elevation: 10,
            shadowColor: const Color.fromRGBO(18, 33, 61, 0.58),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: kSecondaryColor,
            child: Column(
              children: [
                SizedBox(
                  height: 150,
                  width: MediaQuery.of(context).size.width - 2 * 64,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child:
                        Image.network(movies[index].poster, fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FittedBox(
                        child: Text(
                          movies[index].title.length > 15
                              ? '${movies[index].title.substring(0, 15)}...'
                              : movies[index].title,
                          style: const TextStyle(
                            fontFamily: 'SFProDisplay',
                            fontSize: 20,
                            color: kTextColor,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${capitalizeFirstLetter(movies[index].genre[0])} | ${movies[index].age}+ ',
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
      ),
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
        bottom: kDefaultPadding / 2,
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
            MediaQuery.of(context).size.width < 400
                ? const Spacer()
                : TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'SFProDisplay',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: () {
                      widget.tabController
                          .animateTo((widget.tabController.index + 1) % 2);
                    },
                    child: const Text(
                      'See All',
                      style: TextStyle(
                        color: Color(0xFF75BBED),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class buildSliderIndicator extends StatelessWidget {
  buildSliderIndicator({
    Key? key,
    required SwiperPluginConfig config,
  })  : _config = config,
        super(key: key);

  
  SwiperPluginConfig _config;

  @override
  Widget build(BuildContext context) {
    
    return Container(
      padding: const EdgeInsets.only(bottom: 15),
      alignment: Alignment.bottomCenter,
      child: SmoothPageIndicator(
        controller: _config.pageController,
        count: _config.itemCount,
        effect: WormEffect(
          dotWidth: 8,
          dotHeight: 8,
          spacing: 9,
          activeDotColor: kTextColor,
        ),
        axisDirection: Axis.horizontal,
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

String capitalizeFirstLetter(String s) => s[0].toUpperCase() + s.substring(1);
