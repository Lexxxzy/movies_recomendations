// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_recomendations/components/button.dart';
import 'package:movies_recomendations/components/redButton.dart';
import 'package:movies_recomendations/screens/authentication/sign_in/sign_in_screen.dart';
import 'package:movies_recomendations/screens/home/components/body.dart';
import 'package:provider/provider.dart';

import '../../components/backButton.dart';
import '../../constants.dart';
import '../../providers/movies_provider.dart';
import '../../providers/user.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static const routeName = '/profile';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(child: bodyProfile()),
    );
  }
}

class bodyProfile extends StatelessWidget {
  bodyProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesData = Provider.of<Movies>(context);
    final User userData = Provider.of<User>(context).user;
    userData.favourites =
        List.from(moviesData.favouriteMovies.map((e) => e.id.toString()));
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: backButton(
              buttonForm: buttonForms.circle,
            ),
          ),
          buildProfileBody(context, userData),
        ],
      ),
    );
  }

  Container buildProfileBody(BuildContext context, User userData) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.3,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding * 3),
      //color: Colors.white10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(userData.avatar),
            radius: 100,
          ),
          const SizedBox(height: kDefaultPadding),
          Text(
            userData.name,
            style: const TextStyle(
              color: kTextColor,
              fontFamily: 'SFProDispay',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            userData.nickName,
            style: const TextStyle(
              color: kTextLightColor,
              fontFamily: 'SFProDispay',
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: kDefaultPadding * 2,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Email',
                style: TextStyle(
                  color: kTextLightColor,
                  fontFamily: 'SFProDispay',
                  fontSize: 12,
                ),
              ),
              const SizedBox(
                height: kDefaultPadding - 15,
              ),
              Text(
                userData.email,
                style: const TextStyle(
                  color: kTextColor,
                  fontFamily: 'SFProText',
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: kDefaultPadding,
              ),
              buildUserCategory(
                amount: userData.favourites.length.toString(),
                content: 'Favourites',
                asset: 'assets/icons/boockmark.svg',
                height: 14,
              ),
              buildUserCategory(
                amount: userData.loved.length.toString(),
                content: 'Loved',
                asset: 'assets/icons/Heart.svg',
                height: 11,
              ),
              buildUserCategory(
                amount: userData.disliked.length.toString(),
                content: 'Disliked',
                asset: 'assets/icons/redCross.svg',
                height: 11,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: kDefaultPadding),
            child: greyButton(
              content: 'EDIT PROFILE',
              onPress: () {},
              fontSize: 14,
              height: 16,
              width: 60,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: kDefaultPadding / 2),
            child: redButton(
              content: 'SIGN OUT',
              onPress: () {
                Platform.isIOS ? iosDialog(context) : androidDialog(context);
              },
              fontSize: 14,
              height: 16,
              width: 73,
            ),
          )
        ],
      ),
    );
  }

  void iosDialog(context) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("Sign out"),
          content: Text("Are you sure you want to sign out?"),
          actions: [
            CupertinoDialogAction(
                child: Text(
                  "YES",
                  style: TextStyle(
                    fontFamily: 'SFProText',
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(SignInScreen.routeName);
                }),
            CupertinoDialogAction(
              child: Text(
                "NO",
                style: TextStyle(
                  fontFamily: 'SFProText',
                  color: kErrorColor,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  androidDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {},
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text(
          "Would you like to continue learning how to use Flutter alerts?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class buildUserCategory extends StatelessWidget {
  String content;
  String asset;
  String amount;
  double height;

  buildUserCategory({
    required this.content,
    required this.asset,
    required this.amount,
    required this.height,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          SvgPicture.asset(
            asset,
            height: height,
          ),
          SizedBox(width: 10),
          Text(
            '${content}  —  ',
            style: TextStyle(
              color: kTextColor,
              fontFamily: 'SFProDispay',
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              color: kTextColor,
              fontFamily: 'SFProDispay',
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
