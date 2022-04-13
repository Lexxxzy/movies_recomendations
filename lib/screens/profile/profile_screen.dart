// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_recomendations/components/button.dart';
import 'package:movies_recomendations/components/redButton.dart';
import 'package:movies_recomendations/screens/authentication/components/my_snack_bar.dart';
import 'package:movies_recomendations/screens/authentication/sign_in/sign_in_screen.dart';
import 'package:movies_recomendations/screens/home/components/body.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../components/backButton.dart';
import '../../constants.dart';
import '../../providers/auth.dart';
import '../../providers/movies_provider.dart';
import '../../providers/user.dart';
import 'components/user_categories_stat.dart';
import 'package:image_picker/image_picker.dart';

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

class bodyProfile extends StatefulWidget {
  bodyProfile({
    Key? key,
  }) : super(key: key);

  @override
  State<bodyProfile> createState() => _bodyProfileState();
}

class _bodyProfileState extends State<bodyProfile> {
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    final moviesData = Provider.of<Movies>(context);
    final User userData = Provider.of<User>(context).user!;

    return SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
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
        ),
      ),
    );
  }

  Container buildProfileBody(BuildContext context, User userData) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding * 3),
      //color: Colors.white10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              getImage();
            },
            child: CircleAvatar(
              backgroundImage: selectedImage == null
                  ? NetworkImage(userData.avatar!)
                  : AssetImage(selectedImage!.path) as ImageProvider,
              radius: 100,
              backgroundColor: Colors.transparent,
            ),
          ),
          const SizedBox(height: kDefaultPadding),
          Text(
            userData.name!,
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
            userData.nickName!,
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
                userData.email!,
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
                amount: userData.favourites!.toString(),
                content: 'Favourites',
                asset: 'assets/icons/boockmark.svg',
                height: 14,
              ),
              buildUserCategory(
                amount: userData.loved!.toString(),
                content: 'Loved',
                asset: 'assets/icons/Heart.svg',
                height: 11,
              ),
              buildUserCategory(
                amount: userData.disliked!.toString(),
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
              onPress: () {
                userData.uploadImage(selectedImage,context);
              },
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
          title: const Text("Sign out"),
          content: const Text("Are you sure you want to sign out?"),
          actions: [
            CupertinoDialogAction(
              child: const Text(
                "NO",
                style: TextStyle(
                  fontFamily: 'SFProText',
                  color: kErrorColor,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
                child: const Text(
                  "YES",
                  style: TextStyle(
                    fontFamily: 'SFProText',
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacementNamed('/');
                  Provider.of<Auth>(context, listen: false).logout();

                  // Navigator.of(context).pushNamed(SignInScreen.routeName);
                }),
          ],
        );
      },
    );
  }

  androidDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text(
        "Cancel",
        style: const TextStyle(
          fontFamily: 'SFProText',
          color: kMainColor,
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text(
        "Continue",
        style: TextStyle(
          fontFamily: 'SFProText',
          color: kTextColor,
        ),
      ),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text(
        "AlertDialog",
        style: const TextStyle(
          fontFamily: 'SFProText',
          color: kErrorColor,
        ),
      ),
      backgroundColor: kSecondaryColor,
      content: const Text("Are you sure you want to sign out?"),
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

  Future getImage() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      setState(() {
        selectedImage = File(pickedImage!.path);
      });
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const mySnackBar(message: 'Something went wrong', isError: true)
              .build(context));
    }
  }

}
