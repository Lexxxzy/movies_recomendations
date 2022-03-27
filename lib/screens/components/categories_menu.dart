// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../constants.dart';

class CategotiesMenu extends StatefulWidget {
  const CategotiesMenu({Key? key}) : super(key: key);

  @override
  State<CategotiesMenu> createState() => _CategotiesMenuState();
}

class _CategotiesMenuState extends State<CategotiesMenu> {
  int selectedCategory = 0;
  List<String> categories = ["Popular", "You might like", "Categories"];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      margin: const EdgeInsets.only(
        top: kDefaultPadding,
        left: kDefaultPadding,
        right: kDefaultPadding,
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) => buildCategory(index),
      ),
    );
  }

  Padding buildCategory(int index) {
    return Padding(
      padding: const EdgeInsets.only(right: kDefaultPadding + 4),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedCategory = index;
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              categories[index],
              style: TextStyle(
                fontFamily: "SFProDisplay",
                fontWeight: index == selectedCategory
                    ? FontWeight.w700
                    : FontWeight.w500,
                color: index == selectedCategory ? kTextColor : kTextGreyColor,
                fontSize: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: underlineBuilder(index),
            ),
          ],
        ),
      ),
    );
  }

  Container underlineBuilder(int index) {
    return Container(
      height: 3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: index == selectedCategory ? kMainColor : Colors.transparent,
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                categories[index] * 7,
                style: TextStyle(
                  fontFamily: "SFProDisplay",
                  fontWeight: FontWeight.w500,
                  color: Colors.transparent,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
