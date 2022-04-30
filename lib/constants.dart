import 'package:flutter/material.dart';

// Colos that use in app
const kMainColor = Color(0xFFDC7C59);
const kMainColorWithOpacity = Color.fromARGB(45, 238, 136, 108);
const kTextColor = Color(0xFFFFFDFA);
const kTextLightColor = Color(0xFFD2D5D9);
const kTextGreyColor = Color(0xFF4D525E);
const kFillStarColor = Color(0xFFFCC419);
//const kBackgroundColor = Color(0xFF202C42); main first background


const kBackgroundColor = Color(0xFF10141b); //MAIN



//const kSecondaryColor = Color(0xFF26334A);
const kSecondaryColor = Color.fromARGB(20, 255, 255, 255);

const kThirdColor = Color.fromARGB(11, 105, 158, 255);

const kErrorColor = Color(0xFFF6565D);
const kWarningColor = Color(0xFFD9D220);
const kGreenColor = Color(0xFF85D920);

const kButtomsGreyColor = Color.fromARGB(66, 253, 253, 253);

const kDefaultPadding = 25.0;

const kDefaultShadow = BoxShadow(
  offset: Offset(0, 5),
  blurRadius: 22,
  color: Color.fromRGBO(18, 33, 61, 0.58),
);

final RegExp emailValidatorRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kNameNullError = "Please Enter your nickname";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kAddressNullError = "Please Enter your address";
const String kLongNameError = "Name is too long";

//link to api
const apiLink = 'http://92.255.104.126:5000/api/v1';
