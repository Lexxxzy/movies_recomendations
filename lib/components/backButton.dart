import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_svg/svg.dart';

enum buttonForms {
  circle,
  square,
}

class backButton extends StatelessWidget {
  buttonForms buttonForm;
  double size;
  double iconSize;

  backButton({
    Key? key,
    required this.buttonForm,
    this.size = 45,
    this.iconSize = 18,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          buttonForm == buttonForms.circle
              ? Radius.circular(30)
              : Radius.circular(size / 4),
        ),
        color: Color.fromARGB(59, 255, 255, 255),
      ),
      child: Container(
        padding: const EdgeInsets.only(right: 3),
        child: IconButton(
            icon: SvgPicture.asset(
              'assets/icons/Back.svg',
              height: iconSize,
              color: Colors.white,
            ),
            tooltip: MaterialLocalizations.of(context).backButtonTooltip,
            onPressed: () {
              Navigator.maybePop(context);
            }),
      ),
    );
  }
}
