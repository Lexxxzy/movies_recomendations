import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'text_field_container.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool isFocused = false;
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        style: const TextStyle(
          fontFamily: 'SFProText',
          fontSize: 13,
          color: kTextColor,
        ),
        obscureText: isVisible == false ? true : false,
        onChanged: widget.onChanged,
        cursorColor: kTextColor,
        decoration: InputDecoration(
          hintStyle: const TextStyle(
              fontFamily: 'SFProText',
              fontSize: 13,
              color: kTextGreyColor,
              height: 1.5),
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: isFocused ? kTextLightColor : kTextGreyColor,
          ),
          suffixIcon: IconButton(
            color: isFocused ? kTextLightColor : kTextGreyColor,
            icon: isVisible == false
                ? Icon(Icons.visibility)
                : Icon(Icons.visibility_off),
            onPressed: () {
              setState(() {
                isVisible = !isVisible;
              });
            },
          ),
          border: InputBorder.none,
        ),
        onTap: () {
          setState(
            () {
              isFocused = true;
            },
          );
        },
        onEditingComplete: () {
          setState(
            () {
              isFocused = false;
            },
          );
          FocusManager.instance.primaryFocus?.unfocus();
        },
      ),
    );
  }
}
