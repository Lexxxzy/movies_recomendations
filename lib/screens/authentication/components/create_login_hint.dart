import 'package:flutter/material.dart';

import 'package:movies_recomendations/components/button.dart';

import '../../../../constants.dart';

class CreateOrLogIn extends StatelessWidget {
  late Function onPressTextButton;
  bool ifLogin;
  CreateOrLogIn({
    Key? key,
    required this.onPressTextButton,
    this.ifLogin = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 15,
      margin: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding * 2,
      ),
      decoration: const BoxDecoration(
        color: Color.fromARGB(9, 147, 172, 255),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            ifLogin ? 'Don\'t have account?' : 'I already have an account.',
            style: const TextStyle(
              fontSize: 11,
              fontFamily: 'SFProText',
              color: kTextGreyColor,
              fontWeight: FontWeight.w100,
            ),
          ),
          TextButton(
            onPressed: () {
              onPressTextButton();
            },
            child: Text(
              ifLogin ? 'Create new account' : 'Sign In',
              style: const TextStyle(
                fontSize: 11,
                fontFamily: 'SFProText',
                color: kMainColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
