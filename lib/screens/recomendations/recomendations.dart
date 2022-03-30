// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../home/components/app_bar.dart';
import 'package:movies_recomendations/constants.dart';

import 'components/recomendations_body.dart';

class RecomendationsScreen extends StatelessWidget {
  static const routeName = '/recomendations';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: RecomendationsBody(),
    );
  }
}
