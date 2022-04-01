import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_recomendations/constants.dart';
import 'package:movies_recomendations/screens/profile/profile_screen.dart';
import 'package:provider/provider.dart';

import '../../../providers/user.dart';

AppBar buildAppBar(BuildContext context) {
  final userData = Provider.of<User>(context).user;
  return AppBar(
    backgroundColor: kBackgroundColor,
    elevation: 0,
    toolbarHeight: 70,
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
      textAlign: TextAlign.left,
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
        onPressed: () {
          Navigator.of(context).pushNamed(
            ProfileScreen.routeName,
          );
        },
        icon: CircleAvatar(
          backgroundImage: NetworkImage(userData.avatar),
          backgroundColor: kTextGreyColor,
        ),
      ),
    ],
  );
}
