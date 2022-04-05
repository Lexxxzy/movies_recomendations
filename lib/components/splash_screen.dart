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
          children: const [
            Text(
              'Loading...',
              style: TextStyle(
                fontFamily: 'SFProDispay',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: kTextColor,
              ),
            ),
            SizedBox(width: 16),
            CupertinoActivityIndicator(),
          ],
        ),
      ),
    );
  }
}
