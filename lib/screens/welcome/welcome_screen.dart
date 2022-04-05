import 'package:flutter/material.dart';
import 'package:movies_recomendations/components/button.dart';
import '../../constants.dart';
import '../authentication/sign_in/sign_in_screen.dart';
import 'components/description.dart';
import 'components/movies_list_view.dart';
import 'package:flutter/scheduler.dart';

import 'components/welcome_body.dart';

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
      _scrollController1.hasClients;
      _scrollController2.hasClients;
      double minScrollExtent1 = _scrollController1.position.minScrollExtent;
      double maxScrollExtent1 = _scrollController1.position.maxScrollExtent;
      double minScrollExtent2 = _scrollController2.position.minScrollExtent;
      double maxScrollExtent2 = _scrollController2.position.maxScrollExtent;
      //
      animateToMaxMin(maxScrollExtent1, minScrollExtent1, maxScrollExtent1, 95,
          _scrollController1);
      animateToMaxMin(maxScrollExtent2, minScrollExtent2, maxScrollExtent2, 45,
          _scrollController2);
    });
  }

  animateToMaxMin(double max, double min, double direction, int seconds,
      ScrollController scrollController) {
    if (scrollController.hasClients) {
      scrollController
          .animateTo(direction,
              duration: Duration(seconds: seconds), curve: Curves.linear)
          .then((value) {
        direction = direction == max ? min : max;
        animateToMaxMin(max, min, direction, seconds, scrollController);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/backgroundWelcome.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: WelcomeBody(
            scrollController1: _scrollController1,
            posters1: posters1,
            scrollController2: _scrollController2,
            posters2: posters2,
          ),
        ),
      ),
    );
  }
}
