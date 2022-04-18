import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_recomendations/components/backButton.dart';
import 'package:movies_recomendations/components/button.dart';
import 'package:movies_recomendations/constants.dart';
import 'package:http/http.dart' as http;
import 'package:movies_recomendations/screens/authentication/sign_in/sign_in_screen.dart';

import '../../../models/http_exception.dart';
import '../components/my_snack_bar.dart';

class Verification extends StatefulWidget {
  static String routeName = '/verify';

  var inputValue = '';
  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  @override
  Widget build(BuildContext context) {
    final email = (ModalRoute.of(context)?.settings.arguments ??
        <String, String>{}) as Map;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBackgroundColor,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: kDefaultPadding, horizontal: kDefaultPadding),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: backButton(buttonForm: buttonForms.square),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                // Container(
                //   width: 200,
                //   height: 200,
                //   decoration: BoxDecoration(
                //     color: Color.fromARGB(0, 220, 124, 89),
                //     shape: BoxShape.circle,
                //   ),
                //   child: SvgPicture.asset('assets/images/verification.svg'),
                // ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    const Text(
                      'Verification',
                      style: TextStyle(
                        fontFamily: 'SFProDisplay',
                        fontSize: 22,
                        color: kTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "We sent you email with activation code",
                      style: const TextStyle(
                        fontFamily: 'SFProDisplay',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: kTextLightColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    Container(
                      padding: const EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        color: kThirdColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: kDefaultPadding,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _textFieldOTP(first: true, last: false),
                              _textFieldOTP(first: false, last: false),
                              _textFieldOTP(first: false, last: false),
                              _textFieldOTP(
                                  first: false,
                                  last: true,
                                  email: email['email']),
                            ],
                          ),
                          const SizedBox(
                            height: kDefaultPadding,
                          ),
                          SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: myCustomButton(
                                content: 'Verify',
                                onPress: () {},
                                fontSize: 16,
                                mainColor: kThirdColor,
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    const Text(
                      "Didn't you receive any code? Look in spam folder",
                      style: TextStyle(
                        fontFamily: 'SFProDisplay',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: kTextLightColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    const Text(
                      "Resend New Code",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: kMainColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _sendOTP(email) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.142:5000/api/v1/verification/validate'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(
          <String, String>{
            'email': email,
            'code': widget.inputValue,
          },
        ),
      );
      if (response.body.contains('error')) {
        ScaffoldMessenger.of(context).showSnackBar(
            const mySnackBar(message: 'Wrong code!', isError: true)
                .build(context));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const mySnackBar(message: 'You are all in!', isError: false)
                .build(context));
        Navigator.of(context).pushNamed(SignInScreen.routeName);
      }
    } on HttpException catch (err) {
      if (err.toString().contains('error')) {}
    } finally {
      widget.inputValue = '';
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  Widget _textFieldOTP({required bool first, last, email}) {
    return Container(
      height: 64,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            widget.inputValue += value;
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
            if (value.length == 1 && last == true) {
              _sendOTP(email);
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'SFProDisplay',
              color: kTextColor),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: kTextGreyColor),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: kMainColor),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}
