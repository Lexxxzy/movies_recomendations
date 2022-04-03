import 'package:flutter/material.dart';

import 'package:movies_recomendations/components/button.dart';
import 'package:movies_recomendations/screens/sign_in/components/rounded_input_field.dart';
import 'package:movies_recomendations/screens/sign_in/components/rounded_password_filed.dart';

import '../../../constants.dart';

class MainForm extends StatelessWidget {
  const MainForm({
    Key? key,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey, super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: kDefaultPadding,
        left: kDefaultPadding,
        right: kDefaultPadding,
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              height: MediaQuery.of(context).size.height / 1.9,
              decoration: const BoxDecoration(
                color: kThirdColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Sign in \nto continue',
                  style: TextStyle(
                    fontFamily: 'SFProDisplay',
                    fontSize: 32,
                    height: 1.3,
                    color: kTextColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: kDefaultPadding,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      RoundedInputField(
                        hintText: 'E-mail',
                        onChanged: (_) {},
                        ctx: context,
                      ),
                      RoundedPasswordField(onChanged: (_) {}),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'SFProText',
                              color: kMainColor,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: kDefaultPadding),
                        child: greyButton(
                          content: 'Log In',
                          onPress: () {},
                          mainColor: kBackgroundColor,
                          width: MediaQuery.of(context).size.width /
                              3.6,
                          height: kDefaultPadding / 1.3,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
