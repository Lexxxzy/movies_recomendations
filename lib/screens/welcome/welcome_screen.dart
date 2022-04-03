import 'package:flutter/material.dart';
import 'package:movies_recomendations/components/greyButton.dart';
import '../../constants.dart';
import 'components/movies_list_view.dart';
import 'package:flutter/scheduler.dart';

class WelcomScreen extends StatefulWidget {
  static String routeName = '/welcome_screen';

  @override
  State<WelcomScreen> createState() => _WelcomScreenState();
}

class _WelcomScreenState extends State<WelcomScreen> {
  final ScrollController _scrollController1 = ScrollController();
  final ScrollController _scrollController2 = ScrollController();

  List posters1 = [
    'images/1welcomePoster.png',
    'images/2welcomePoster.png',
    'images/3welcomePoster.png',
    'images/4welcomePoster.png',
    'images/1welcomePoster.png',
    'images/2welcomePoster.png',
    'images/3welcomePoster.png',
    'images/4welcomePoster.png',
  ];

  List posters2 = [
    'images/5welcomePoster.png',
    'images/6welcomePoster.png',
    'images/7welcomePoster.png',
    'images/8welcomePoster.png',
    'images/5welcomePoster.png',
    'images/6welcomePoster.png',
    'images/7welcomePoster.png',
    'images/8welcomePoster.png',
  ];

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      double minScrollExtent1 = _scrollController1.position.minScrollExtent;
      double maxScrollExtent1 = _scrollController1.position.maxScrollExtent;
      double minScrollExtent2 = _scrollController2.position.minScrollExtent;
      double maxScrollExtent2 = _scrollController2.position.maxScrollExtent;
      //
      animateToMaxMin(maxScrollExtent1, minScrollExtent1, maxScrollExtent1, 25,
          _scrollController1);
      animateToMaxMin(maxScrollExtent2, minScrollExtent2, maxScrollExtent2, 15,
          _scrollController2);
    });
  }

  animateToMaxMin(double max, double min, double direction, int seconds,
      ScrollController scrollController) {
    scrollController
        .animateTo(direction,
            duration: Duration(seconds: seconds), curve: Curves.linear)
        .then((value) {
      direction = direction == max ? min : max;
      animateToMaxMin(max, min, direction, seconds, scrollController);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/backgroundWelcome.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 6,
            ),
            MoviesListView(
              scrollController: _scrollController1,
              images: posters1,
            ),
            MoviesListView(
              scrollController: _scrollController2,
              images: posters2,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 8,
            ),
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: RichText(
                text: const TextSpan(
                  text: 'Discover new movies, TV shows and more',
                  style: TextStyle(
                    fontFamily: 'SFProDisplay',
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    color: kTextColor,
                  ),
                  children: [
                    TextSpan(
                      text: '.',
                      style: TextStyle(
                        fontFamily: 'SFProDisplay',
                        fontSize: 38,
                        fontWeight: FontWeight.w700,
                        color: kMainColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: kDefaultPadding),
              child: Text(
                'Personal recomendations.',
                style: TextStyle(
                  fontFamily: 'SFProText',
                  fontSize: 17,
                  color: kTextLightColor,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: kDefaultPadding,
                ),
                child: greyButton(
                  content: 'Get Started',
                  onPress: () {},
                  fontSize: 16,
                  width: MediaQuery.of(context).size.width / 3.5,
                  height: 20,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}