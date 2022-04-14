import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_recomendations/constants.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      height: 100,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text(
              'Loading...',
              style: TextStyle(
                fontFamily: 'SFProDispay',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: kTextColor,
              ),
            ),
            SizedBox(width: 16),
            CupertinoActivityIndicator(color: kMainColor),
          ],
        ),
      ),
    );
  }
}
