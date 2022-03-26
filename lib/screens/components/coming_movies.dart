import 'package:flutter/material.dart';
import 'package:movies_recomendations/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ComingMovies extends StatelessWidget {
  ComingMovies({Key? key}) : super(key: key);

  final List<String> upcomings = [
    'assets/images/slider1.png',
    'assets/images/slider2.png',
    'assets/images/slider3.png',
    'assets/images/slider4.png',
  ];

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
      ),
      height: 110,
      child: Stack(
        children: [
          buildSliderImage(),
          buildSliderIndicator(
              pageController: _pageController, upcomings: upcomings),
        ],
      ),
    );
  }

  PageView buildSliderImage() {
    return PageView(
      controller: _pageController,
      children: upcomings
          .map(
            (slide) => Stack(
              fit: StackFit.expand,
              children: [
                Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(slide, fit: BoxFit.cover),
                    )),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.black,
                        Colors.black45,
                        Colors.black12,
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                const Positioned(
                  left: 40,
                  top: 20,
                  child: Text(
                    "Upcoming movies",
                    style: TextStyle(
                      fontFamily: 'SFProDisplay',
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: kTextColor,
                    ),
                  ),
                ),
                const Positioned(
                  left: 40,
                  top: 50,
                  child: Text(
                    "See whats coming next...",
                    style: TextStyle(
                      fontFamily: 'SFProText',
                      fontSize: 10,
                      fontWeight: FontWeight.normal,
                      color: kTextLightColor,
                    ),
                  ),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}

class buildSliderIndicator extends StatelessWidget {
  const buildSliderIndicator({
    Key? key,
    required PageController pageController,
    required this.upcomings,
  })  : _pageController = pageController,
        super(key: key);

  final PageController _pageController;
  final List<String> upcomings;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 40,
      bottom: 15,
      child: SmoothPageIndicator(
        controller: _pageController,
        count: upcomings.length,
        effect: const ExpandingDotsEffect(
          expansionFactor: 6,
          dotWidth: 5,
          dotHeight: 5,
          spacing: 4,
          activeDotColor: kTextColor,
        ),
        onDotClicked: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(
              microseconds: 600,
            ),
            curve: Curves.easeInOut,
          );
        },
      ),
    );
  }
}
