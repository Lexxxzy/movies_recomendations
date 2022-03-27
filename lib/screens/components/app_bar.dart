  import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_recomendations/constants.dart';
  
  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kBackgroundColor,
      elevation: 0,
      toolbarHeight: 90,
      leadingWidth: 60,
      titleSpacing: 10,
      leading: IconButton(
        padding: const EdgeInsets.only(
          left: kDefaultPadding,
        ),
        icon: SvgPicture.asset(
          "assets/icons/appicon.svg",
        ),
        onPressed: () {},
      ),
      title: const Text(
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
          padding: const EdgeInsets.only(right: kDefaultPadding),
          iconSize: 34,
          onPressed: () {},
          icon: const CircleAvatar(
            backgroundImage: AssetImage("assets/images/avatar.JPG"),
          ),
        ),
      ],
    );
  }