// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../screens/components/body.dart';
import 'package:movies_recomendations/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: buildAppBar(),
      body: Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kBackgroundColor,
      elevation: 0,
      toolbarHeight: 90,
      leadingWidth: 60,
      titleSpacing: 10,
      leading: IconButton(
        padding: EdgeInsets.only(
          left: kDefaultPadding,
        ),
        icon: SvgPicture.asset(
          "assets/icons/appicon.svg",
        ),
        onPressed: () {},
      ),
      title: Text(
        "WTW",
        style: TextStyle(
          fontFamily: "SFProDisplay",
          fontWeight: FontWeight.w900,
          letterSpacing: -2,
          fontSize: 24,
          color: kTextColor,
        ),
      ),
      actions: <Widget>[
        IconButton(
          padding: EdgeInsets.only(right: kDefaultPadding),
          iconSize: 34,
          onPressed: () {},
          icon: CircleAvatar(
            backgroundImage: AssetImage("assets/images/avatar.JPG"),
          ),
        ),
      ],
    );
  }
}
