import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../components/create_login_hint.dart';
import 'widgets/main_form.dart';
import '../components/services_sign_in.dart';
import '../sign_up/sign_up_screen.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = '/sign_in';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBackgroundColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: kDefaultPadding),
                    child: SvgPicture.asset('assets/icons/logo_without_bg.svg'),
                  ),
                ),
                MainForm(formKey: _formKey),
                CreateOrLogIn(
                  onPressTextButton: () {
                    Navigator.of(context).pushNamed(SignUpScreen.routeName);
                  },
                ),
                buildGoogleButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding buildGoogleButton() {
    return Padding(
      padding: const EdgeInsets.only(
        left: kDefaultPadding,
        right: kDefaultPadding,
        top: kDefaultPadding * 2,
      ),
      child: ServicesSignOnButton(
        assetName: 'assets/icons/Google.svg',
        content: 'Sign in with Google',
        onPress: () {},
        mainColor: Color.fromARGB(9, 147, 172, 255),
        fontSize: 18,
        height: kDefaultPadding - 5,
      ),
    );
  }
}
