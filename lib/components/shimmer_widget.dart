import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../constants.dart';


class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const ShimmerWidget.rectengular({
    this.width = double.infinity,
    required this.height,
    this.shapeBorder = const RoundedRectangleBorder(),
  });

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: const Color.fromARGB(235, 57, 57, 57),
        highlightColor: const Color.fromARGB(156, 255, 255, 255),
        child: Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
            color: kSecondaryColor,
            shape: shapeBorder,
          ),
        ),
      );
}