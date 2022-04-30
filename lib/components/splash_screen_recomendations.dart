// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies_recomendations/components/search.dart';
import 'package:movies_recomendations/components/shimmer_widget.dart';
import 'package:movies_recomendations/constants.dart';

import '../screens/home/components/recomendation_carousel.dart';

class SplashScreenRecomendations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Stack(alignment: Alignment.center, children: [
          ShimmerWidget.rectengular(
            width: MediaQuery.of(context).size.width.toDouble(),
            height: MediaQuery.of(context).size.height.toDouble() / 1.6,
            shapeBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator.adaptive(
                backgroundColor: kMainColor,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Getting your recomendations ready...',
                style: TextStyle(
                    color: kTextColor,
                    fontFamily: 'SFProDisplay',
                    fontSize: 14),
              ),
            ],
          ))
        ]),
      ),
    );
  }
}
