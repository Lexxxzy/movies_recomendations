import 'package:flutter/material.dart';
import 'package:movies_recomendations/constants.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  final Color color;
  const TextFieldContainer({
    Key? key,
    required this.child,
    this.color = kBackgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      //width: size.width * 0.8,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}
