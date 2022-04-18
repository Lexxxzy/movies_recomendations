import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class UserCategory extends StatelessWidget {
  String content;
  String asset;
  String amount;
  double height;

  UserCategory({
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
          const SizedBox(width: 10),
          Text(
            '${content}  —  ',
            style: const TextStyle(
              color: kTextColor,
              fontFamily: 'SFProDispay',
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            amount,
            style: const TextStyle(
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
