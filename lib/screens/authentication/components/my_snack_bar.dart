import 'package:flutter/material.dart';

import '../../../constants.dart';

class mySnackBar extends StatelessWidget {
  const mySnackBar({
    Key? key,
    required this.message,
    required this.isError,
  }) : super(key: key);

  final String message;
  final bool isError;

  @override
  SnackBar build(BuildContext context) {
    return SnackBar(
      elevation: 0,
      margin: const EdgeInsets.only(
        bottom: kDefaultPadding,
        left: kDefaultPadding * 3,
        right: kDefaultPadding * 3,
      ),
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.endToStart,
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: 'SFProDisplay',
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor:
          isError ? kErrorColor.withOpacity(0.7) : kGreenColor.withOpacity(0.7),
      duration: const Duration(milliseconds: 2000),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
