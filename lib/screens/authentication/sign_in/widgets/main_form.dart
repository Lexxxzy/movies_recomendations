import 'package:flutter/material.dart';

import 'package:movies_recomendations/components/button.dart';
import 'package:movies_recomendations/screens/authentication/components/form_error.dart';
import 'package:movies_recomendations/screens/home/home_screen.dart';

import '../../../../../constants.dart';
import '../../components/rounded_input_field.dart';
import '../../components/rounded_password_filed.dart';

class MainForm extends StatefulWidget {
  MainForm({
    Key? key,
    required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  State<MainForm> createState() => _MainFormState();
}

class _MainFormState extends State<MainForm> {
  List<String?> errors = [];
  String? email;
  String? password;

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

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
              height: errors.isEmpty
                  ? MediaQuery.of(context).size.height / 1.9
                  : MediaQuery.of(context).size.height / 1.81,
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
                  key: widget._formKey,
                  child: Column(
                    children: <Widget>[
                      buildEmailTextField(context),
                      buildPasswordTextField(context),
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
                      buildLoginButtonAndErrors(context)
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

  Column buildLoginButtonAndErrors(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: kDefaultPadding),
          child: greyButton(
            content: 'Log In',
            onPress: () {
              if (widget._formKey.currentState!.validate()) {
                widget._formKey.currentState!.save();
                // if all are valid then go to success screen
                ScaffoldMessenger.of(context).showSnackBar(
                  buildSuccessSnackBar(),
                );
                print('e-mail: $email\npassword: $password');
                Navigator.pushReplacementNamed(context, HomeScreen.routeName);
              }
            },
            mainColor: kBackgroundColor,
            width: MediaQuery.of(context).size.width / 3.6,
            height: kDefaultPadding / 1.3,
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        FormError(errors: errors),
      ],
    );
  }

  RoundedPasswordField buildPasswordTextField(BuildContext context) {
    return RoundedPasswordField(
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      validFunc: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 7) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      ctx: context,
    );
  }

  SnackBar buildSuccessSnackBar() {
    return SnackBar(
      elevation: 0,
      margin: const EdgeInsets.only(
        bottom: kDefaultPadding,
        left: kDefaultPadding * 3,
        right: kDefaultPadding * 3,
      ),
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.endToStart,
      content: const Text(
        'Successful authorization!',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'SFProDisplay',
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: kGreenColor.withOpacity(0.7),
      duration: Duration(milliseconds: 2000),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  RoundedInputField buildEmailTextField(BuildContext context) {
    return RoundedInputField(
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        email = value;
      },
      validFunc: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      hintText: 'E-mail',
      ctx: context,
    );
  }
}
