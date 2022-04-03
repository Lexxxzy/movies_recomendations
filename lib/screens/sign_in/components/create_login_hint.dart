import 'package:flutter/material.dart';

import 'package:movies_recomendations/components/button.dart';
import 'package:movies_recomendations/screens/sign_in/components/rounded_input_field.dart';
import 'package:movies_recomendations/screens/sign_in/components/rounded_password_filed.dart';

import '../../../constants.dart';

class CreateOrLogIn extends StatelessWidget {
  const CreateOrLogIn({
    Key? key,
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
            'Don\'t have account?',
            style: TextStyle(
              fontSize: 11,
              fontFamily: 'SFProText',
              color: kTextGreyColor,
              fontWeight: FontWeight.w100,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Create new account',
              style: TextStyle(
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

