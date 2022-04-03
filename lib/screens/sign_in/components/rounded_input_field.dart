import 'package:flutter/material.dart';
import 'package:movies_recomendations/constants.dart';

import 'text_field_container.dart';

class RoundedInputField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  BuildContext ctx;
  RoundedInputField({
    Key? key,
    required this.hintText,
    this.icon = Icons.person,
    required this.onChanged,
    required this.ctx,
  }) : super(key: key);

  @override
  State<RoundedInputField> createState() => _RoundedInputFieldState();
}

class _RoundedInputFieldState extends State<RoundedInputField> {
  bool isFocused = false;
  @override
  Widget build(ctx) {
    return TextFieldContainer(
      child: TextField(
        style: const TextStyle(
          fontFamily: 'SFProText',
          fontSize: 13,
          color: kTextColor,
        ),
        onChanged: widget.onChanged,
        cursorColor: kTextColor,
        decoration: InputDecoration(
          hintStyle: const TextStyle(
            fontFamily: 'SFProText',
            fontSize: 13,
            color: kTextGreyColor,
          ),
          icon: Icon(
            widget.icon,
            color: isFocused ? kTextLightColor : kTextGreyColor,
          ),
          hintText: widget.hintText,
          border: InputBorder.none,
        ),
        onTap: () {
          setState(() {
            isFocused = true;
          });
        },
        onEditingComplete: () {
          setState(() {
            isFocused = false;
          });
          FocusScope.of(ctx).nextFocus();
        },
        textInputAction: TextInputAction.next,
      ),
    );
  }
}
