import 'package:flutter/material.dart';
import 'package:movies_recomendations/constants.dart';

class greyButton extends StatelessWidget {
  late String content;
  late Function onPress;
  late double fontSize;
  late double width;
  late double height;

  greyButton(
      {required String content,
      required Function onPress,
      double fontSize = 12,
      double width = 7,
      double height = 0,
      Key? key})
      : super(key: key) {
    this.content = content;
    this.onPress = onPress;
    this.fontSize = fontSize;
    this.width = width;
    this.height = height;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPress();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width, vertical: height),
        child: Text(
          content,
          style: TextStyle(
            fontFamily: 'SFProText',
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: fontSize,
          ),
        ),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        primary: kButtomsGreyColor,
      ),
    );
  }
}
