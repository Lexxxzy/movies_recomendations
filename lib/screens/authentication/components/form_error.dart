import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_recomendations/constants.dart';

class FormError extends StatelessWidget {
  const FormError({
    Key? key,
    required this.errors,
  }) : super(key: key);

  final List<String?> errors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          errors.length, (index) => formErrorText(error: errors[index]!)),
    );
  }

  Padding formErrorText({required String error}) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Icon(
            Icons.error_outline_outlined,
            size: 12,
            color: kErrorColor,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            error,
            style: TextStyle(
              fontFamily: 'SFProText',
              fontSize: 10,
              color: kErrorColor,
            ),
          ),
        ],
      ),
    );
  }
}
