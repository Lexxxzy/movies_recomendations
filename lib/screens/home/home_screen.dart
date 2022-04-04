// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'components/body.dart';
import 'package:movies_recomendations/constants.dart';

import 'components/app_bar.dart';

class HomeScreen extends StatelessWidget {
  static final routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: buildAppBar(context),
      body: SingleChildScrollView(child: Body()),
    );
  }
}
