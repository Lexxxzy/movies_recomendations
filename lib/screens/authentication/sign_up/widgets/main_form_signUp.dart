import 'package:flutter/material.dart';

import 'package:movies_recomendations/components/button.dart';
import 'package:movies_recomendations/screens/authentication/components/form_error.dart';

import '../../../../../constants.dart';
import '../../components/rounded_input_field.dart';
import '../../components/rounded_password_filed.dart';

class MainForm extends StatefulWidget {
  const MainForm({
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
  String? conformPassword;
  String? nickName;

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
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
                  ? MediaQuery.of(context).size.height / 1.6
                  : MediaQuery.of(context).size.height / 1.45,
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
                  'Create new \nAccount',
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
                      buildNameFormField(context),
                      buidEmailFormField(context),
                      buildPasswordField(context),
                      buildConfirmPasswordField(context),
                      buildSubmitButtomAndErrors(context)
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

  RoundedInputField buildNameFormField(BuildContext context) {
    return RoundedInputField(
      hintText: 'Display name',
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNameNullError);
        } else if (value.length <= 15) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      ctx: context,
      validFunc: (String value) {
        if (value.isEmpty) {
          addError(error: kNameNullError);
          return "";
        } else if ((value.length > 15)) {
          addError(error: kLongNameError);
          return "";
        }
        nickName = value;
      },
    );
  }

  Padding buildSubmitButtomAndErrors(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: Column(
        children: [
          greyButton(
            content: 'Create account',
            onPress: () {
              if (widget._formKey.currentState!.validate()) {
                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.
                ScaffoldMessenger.of(context).showSnackBar(
                  buildSuccessSnackBar(),
                );
                print('e-mail: $email\nname: $nickName\npassword: $password');
              Navigator.of(context).maybePop();
              }
              
            },
            mainColor: kBackgroundColor,
            width: 80,
            height: kDefaultPadding / 1.3,
            fontSize: 16,
          ),
          SizedBox(
            height: 3,
          ),
          FormError(errors: errors),
        ],
      ),
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
        'Success!',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'SFProDisplay',
          fontSize: 13,
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

  RoundedPasswordField buildConfirmPasswordField(BuildContext context) {
    return RoundedPasswordField(
      validFunc: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      ctx: context,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == conformPassword) {
          removeError(error: kMatchPassError);
        }
        conformPassword = value;
      },
      hintText: 'Confirm Password',
    );
  }

  RoundedPasswordField buildPasswordField(BuildContext context) {
    return RoundedPasswordField(
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 6) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      ctx: context,
      ifLast: false,
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
    );
  }

  RoundedInputField buidEmailFormField(BuildContext context) {
    return RoundedInputField(
      validFunc: (String value) {
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
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        email = value;
      },
      ctx: context,
      icon: Icons.email,
    );
  }
}
