import 'package:flutter/material.dart';
import 'package:movies_recomendations/constants.dart';
import 'package:movies_recomendations/screens/upcomings/upcomings.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ComingMovies extends StatelessWidget {
  ComingMovies({Key? key}) : super(key: key);

  final List<Map> upcomings = [
    {
      'image': 'assets/images/slider1.png',
      'headerText': 'Upcoming movies',
      'plainText': 'See whats coming next...',
      'route': Upcomings.routeName
    },
    {
      'image': 'assets/images/slider2.png',
      'headerText': 'Top 10 series',
      'plainText': 'Series appreciated by audiences',
      'route': Upcomings.routeName
    },
    {
      'image': 'assets/images/slider3.png',
      'headerText': 'Top 10 from Netflix',
      'plainText': 'Top NETFLIX movies appreciated by audiences',
      'route': Upcomings.routeName
    },
    {
      'image': 'assets/images/slider4.png',
      'headerText': 'Top MARVEL movies',
      'plainText':
          'The best movies based on Marvel comics are full of action.\n But which one is the best?..',
      'route': Upcomings.routeName
    },
  ];

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding / 2,
      ),
      height: 115,
      child: Stack(
        children: [
          buildSliderImage(context),
          buildSliderIndicator(
            pageController: _pageController,
            upcomings: upcomings,
          ),
        ],
      ),
    );
  }

  PageView buildSliderImage(context) {
    return PageView(
      controller: _pageController,
      children: upcomings
          .map(
            (slide) => GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  slide['route'],
                );
              },
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(slide['image'], fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.black26,
                          Colors.black12,
                          Colors.black12,
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 40,
                    top: 20,
                    child: Text(
                      slide['headerText'],
                      style: const TextStyle(
                        fontFamily: 'SFProDisplay',
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: kTextColor,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 40,
                    top: 50,
                    child: Text(
                      slide['plainText'],
                      style: const TextStyle(
                        fontFamily: 'SFProText',
                        fontSize: 10,
                        fontWeight: FontWeight.normal,
                        color: kTextLightColor,
                      ),
                    ),
                  ),
                ],
              ),
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
  final List<Map> upcomings;

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
          dotWidth: 4,
          dotHeight: 4,
          spacing: 4,
          activeDotColor: kTextColor,
        ),
        onDotClicked: (index) {
          _pageController.animateToPage(
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
