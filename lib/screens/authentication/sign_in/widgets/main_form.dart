import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:movies_recomendations/components/button.dart';
import 'package:movies_recomendations/screens/authentication/components/form_error.dart';
import 'package:movies_recomendations/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

import '../../../../../constants.dart';
import '../../../../models/http_exception.dart';
import '../../../../providers/auth.dart';
import '../../components/my_snack_bar.dart';
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
  bool _isloading = false;

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
          child: _isloading == false
              ? greyButton(
                  content: 'Log In',
                  onPress: () {
                    submitLogIn(context);
                  },
                  mainColor: kBackgroundColor,
                  width: MediaQuery.of(context).size.width / 3.6,
                  height: kDefaultPadding / 1.3,
                  fontSize: 16,
                )
              : const CupertinoActivityIndicator(
                  radius: 12,
                  color: kMainColor,
                ),
        ),
        const SizedBox(
          height: 8,
        ),
        FormError(errors: errors),
      ],
    );
  }

  Future<void> submitLogIn(BuildContext context) async {
    if (!widget._formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    widget._formKey.currentState!.save();
    setState(() {
      _isloading = true;
    });
    try {
      // if all are valid then go to success screen

      //print('e-mail: $email\npassword: $password');

      await Provider.of<Auth>(context, listen: false).login(email!, password!);

      Navigator.pushReplacementNamed(context, HomeScreen.routeName);

      ScaffoldMessenger.of(context).showSnackBar(
        const mySnackBar(message: 'Successful authorization!', isError: false)
            .build(context),
      );
    } on HttpException catch (err) {
      var errorMesage = 'Authentiaction failed';
      if (err.toString().contains('EMAIL_NOT_FOUND')) {
        errorMesage = 'Email is not found.';
      } else if (err.toString().contains('INVALID_PASSWORD')) {
        errorMesage = 'Invalid password.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
          mySnackBar(message: errorMesage, isError: true).build(context));
    } catch (err) {
      const errorMesage = 'Some Error occured';
      ScaffoldMessenger.of(context).showSnackBar(
          const mySnackBar(message: errorMesage, isError: true).build(context));
    }
    setState(() {
      _isloading = false;
    });
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
