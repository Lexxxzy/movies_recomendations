import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_recomendations/constants.dart';

class ServicesSignOnButton extends StatelessWidget {
  late String content;
  late Function onPress;
  late double fontSize;
  late double width;
  late double height;
  late Color mainColor;
  late String assetName;

  ServicesSignOnButton(
      {required String content,
      required Function onPress,
      double fontSize = 12,
      double width = 7,
      double height = 0,
      Color mainColor = kButtomsGreyColor,
      required String assetName,
      Key? key})
      : super(key: key) {
    this.content = content;
    this.onPress = onPress;
    this.fontSize = fontSize;
    this.width = width;
    this.height = height;
    this.mainColor = mainColor;
    this.assetName = assetName;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPress();
      },
      child: SizedBox(
        
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width, vertical: height),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                assetName,
                height: fontSize + 2,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                content,
                style: TextStyle(
                  fontFamily: 'SFProText',
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: fontSize,
                ),
              ),
            ],
          ),
        ),
      ),
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        primary: mainColor,
      ),
    );
  }
}
