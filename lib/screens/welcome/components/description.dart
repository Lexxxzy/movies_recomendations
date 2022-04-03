
import 'package:flutter/material.dart';

import '../../../constants.dart';


class buildDescription extends StatelessWidget {
  const buildDescription({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: RichText(
        text: const TextSpan(
          text: 'Discover new movies, TV shows and more',
          style: TextStyle(
            fontFamily: 'SFProDisplay',
            fontSize: 36,
            fontWeight: FontWeight.w700,
            color: kTextColor,
          ),
          children: [
            TextSpan(
              text: '.',
              style: TextStyle(
                fontFamily: 'SFProDisplay',
                fontSize: 38,
                fontWeight: FontWeight.w700,
                color: kMainColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
