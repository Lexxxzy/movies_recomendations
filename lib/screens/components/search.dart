// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_recomendations/constants.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
      ),
      child: Stack(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          TextField(
            cursorColor: kTextLightColor,
            style: TextStyle(
              fontSize: 14,
              color: kTextColor,
              fontFamily: 'SFProDisplay',
              fontWeight: FontWeight.w500,
            ),
            decoration: buildInputDecoration(),
          ),
          buildShadow(),
        ],
      ),
    );
  }

  InputDecoration buildInputDecoration() {
    return InputDecoration(
      fillColor: kButtomsGreyColor,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          width: 0,
          style: BorderStyle.none,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
      ),
      hintText: 'Search movies',
      hintStyle: TextStyle(
        fontSize: 14,
        color: kTextLightColor,
        fontFamily: 'SFProDisplay',
        fontWeight: FontWeight.w500,
      ),
      suffixIcon: SvgPicture.asset(
        'assets/icons/search.svg',
      ),
    );
  }

  Positioned buildShadow() {
    return Positioned(
      bottom: 12,
      right: 11,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.transparent,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(241, 146, 119, 0.30),
              spreadRadius: 5,
              blurRadius: 15,
            ),
          ],
        ),
      ),
    );
  }
}
