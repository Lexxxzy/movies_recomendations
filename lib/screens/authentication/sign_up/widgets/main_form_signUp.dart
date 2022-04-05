import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:movies_recomendations/components/button.dart';
import 'package:movies_recomendations/screens/authentication/components/form_error.dart';
import 'package:provider/provider.dart';

import '../../../../../constants.dart';
import '../../../../models/http_exception.dart';
import '../../../../providers/auth.dart';
import '../../components/my_snack_bar.dart';
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
  bool _isloading = false;

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
          _isloading == false
              ? greyButton(
                  content: 'Create account',
                  onPress: () {
                    onSubmitSignUp(context);
                  },
                  mainColor: kBackgroundColor,
                  width: 80,
                  height: kDefaultPadding / 1.3,
                  fontSize: 16,
                )
              : const CupertinoActivityIndicator(),
          const SizedBox(
            height: 3,
          ),
          FormError(errors: errors),
        ],
      ),
    );
  }

  Future<void> onSubmitSignUp(BuildContext context) async {
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

      await Provider.of<Auth>(context, listen: false).signUp(email!, password!);

      Navigator.of(context).maybePop();

      ScaffoldMessenger.of(context).showSnackBar(
          const mySnackBar(message: 'Successful registration!', isError: false)
              .build(context));
    } on HttpException catch (err) {
      var errorMesage = 'Authentiaction failed';
      if (err.toString().contains('EMAIL_EXISTS')) {
        errorMesage = 'This e-mail address is already in use.';
      } else if (err.toString().contains('WEAK_PASSWORD')) {
        errorMesage = 'Password is too weak';
      } else if (err.toString().contains('EMAIL_NOT_FOUND')) {
        errorMesage = 'Email is not found.';
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
