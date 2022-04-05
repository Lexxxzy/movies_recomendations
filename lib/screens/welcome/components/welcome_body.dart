
import 'package:flutter/material.dart';
import 'package:movies_recomendations/components/button.dart';

import '../../../constants.dart';
import '../../authentication/sign_in/sign_in_screen.dart';
import 'description.dart';
import 'movies_list_view.dart';


class WelcomeBody extends StatelessWidget {
  const WelcomeBody({
    Key? key,
    required ScrollController scrollController1,
    required this.posters1,
    required ScrollController scrollController2,
    required this.posters2,
  }) : _scrollController1 = scrollController1, _scrollController2 = scrollController2, super(key: key);

  final ScrollController _scrollController1;
  final List posters1;
  final ScrollController _scrollController2;
  final List posters2;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        const buildDescription(),
        const Padding(
          padding: EdgeInsets.only(left: kDefaultPadding),
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
              top: kDefaultPadding * 2,
            ),
            child: greyButton(
              content: 'Get Started',
              onPress: () {
                Navigator.of(context)
                    .pushReplacementNamed(SignInScreen.routeName);
              },
              fontSize: 16,
              width: MediaQuery.of(context).size.width / 3.5,
              height: 20,
            ),
          ),
        )
      ],
    );
  }
}
