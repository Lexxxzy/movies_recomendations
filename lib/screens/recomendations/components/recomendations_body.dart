import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_recomendations/constants.dart';
import '../../../blocs/swipe_block.dart';
import '../../../blocs/swipe_state.dart';
import '../../../providers/movies_provider.dart';
import 'choice_button.dart';
import 'movie_card_recomendations.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class RecomendationsBody extends StatefulWidget {
  const RecomendationsBody({Key? key}) : super(key: key);

  @override
  State<RecomendationsBody> createState() => _RecomendationsBodyState();
}

class _RecomendationsBodyState extends State<RecomendationsBody> {
  double _opacity = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _opacity = 0;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwipeBloc, SwipeState>(
      builder: (context, state) {
        if (state is SwipeLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SwipeLoaded) {
          return state.movies.length >= 1
              ? Column(
                  children: [
                    Draggable(
                      child: MovieCardRecomendations(movie: state.movies[0]),
                      feedback: MovieCardRecomendations(movie: state.movies[0]),
                      childWhenDragging: state.movies[0].id !=
                              Movies().movies.length
                          ? MovieCardRecomendations(movie: state.movies[1])
                          : Container(
                              height: MediaQuery.of(context).size.height / 1.6),
                      onDragEnd: (drag) {
                        if (drag.velocity.pixelsPerSecond.dx < -200) {
                          context.read<SwipeBloc>().add(
                                SwipeLeftEvent(movie: state.movies[0]),
                              );
                          print(drag.velocity.pixelsPerSecond.dx);
                        } else if (drag.velocity.pixelsPerSecond.dx > 200) {
                          context.read<SwipeBloc>().add(
                                SwipeRightEvent(
                                  movie: state.movies[0],
                                ),
                              );
                        }
                      },
                    ),
                    buildChoiceButtons(context, state),
                  ],
                )
              : buildThatWasAllRecomendations(context);
        } else {
          return Text('Something went wrong');
        }
      },
    );
  }

  Padding buildChoiceButtons(BuildContext context, SwipeLoaded state) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding * 5 + 10, vertical: kDefaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              context.read<SwipeBloc>()
                ..add(
                  SwipeLeftEvent(movie: state.movies[0]),
                );
            },
            child: ChoiceButton(
              assetPath: 'assets/icons/Cross.svg',
              backColor: Color(0xFFF5F5FA),
              color: Color.fromARGB(255, 0, 0, 0),
              size: 20,
              width: 53,
              height: 53,
            ),
          ),
          GestureDetector(
            onTap: () {
              context.read<SwipeBloc>()
                ..add(
                  SwipeRightEvent(
                    movie: state.movies[0],
                  ),
                );
            },
            child: ChoiceButton(
              assetPath: 'assets/icons/lilHeart.svg',
              backColor: kMainColorWithOpacity,
              color: Color(0xFFEE896C),
              size: 20,
              width: 53,
              height: 53,
            ),
          ),
        ],
      ),
    );
  }

  Stack buildThatWasAllRecomendations(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          child: Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding),
            child: SizedBox(
              width: 270,
              child: DefaultTextStyle(
                  style: const TextStyle(
                    color: kTextColor,
                    fontFamily: 'SFProDisplay',
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                  ),
                  child: AnimatedTextKit(
                    isRepeatingAnimation: false,
                    onNext: (g, n) => setState(() {
                      _opacity = 1;
                    }),
                    pause: Duration(milliseconds: 300),
                    animatedTexts: [
                      TyperAnimatedText(
                        "",
                      ),
                      TyperAnimatedText(
                        "That was all your recomedations for today",
                      ),
                    ],
                  )),
            ),
          ),
        ),
        Positioned(
          top: 80,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 2000),
            opacity: _opacity,
            child: SvgPicture.asset(
              'assets/images/allRecomedationForToday.svg',
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ),
      ],
    );
  }
}
