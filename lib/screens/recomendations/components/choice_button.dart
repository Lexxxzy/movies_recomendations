import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChoiceButton extends StatelessWidget {
  final double width;
  final double height;
  final double size;
  final Color backColor;
  final Color color;
  final String assetPath;
  const ChoiceButton({
    Key? key,
    required this.width,
    required this.height,
    required this.size,
    required this.color,
    required this.assetPath,
    required this.backColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backColor,
          ),
        ),
        SizedBox(
          child: SvgPicture.asset(
            assetPath,
            color: color,
            height: size,
          ),
        ),
      ],
    );
  }
}
