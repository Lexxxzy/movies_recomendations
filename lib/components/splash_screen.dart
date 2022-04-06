import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_recomendations/constants.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
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
