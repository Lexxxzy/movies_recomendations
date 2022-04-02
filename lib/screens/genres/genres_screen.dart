// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:movies_recomendations/components/backButton.dart';
import 'package:movies_recomendations/components/search.dart';
import 'package:movies_recomendations/constants.dart';

class GenresScreen extends StatelessWidget {
  GenresScreen({Key? key}) : super(key: key);
  static const routeName = '/genres';
  List<Map> genres = [
    {
      'image': 'assets/images/f&f.jpg',
      'genre': 'Action',
    },
    {
      'image': 'assets/images/mitti.jpg',
      'genre': 'Adventure',
    },
    {
      'image': 'assets/images/koko.jpg',
      'genre': 'Animated',
    },
    {
      'image': 'assets/images/robert.jpg',
      'genre': 'Comedy',
    },
    {
      'image': 'assets/images/horror.jpg',
      'genre': 'Horror',
    },
    {
      'image': 'assets/images/f&f.jpg',
      'genre': 'Western',
    },
    {
      'image': 'assets/images/slider4.png',
      'genre': 'Fastasy',
    },
    {
      'image': 'assets/images/drama.jpeg',
      'genre': 'Drama',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: buildGenresScreen(context),
    );
  }

  SafeArea buildGenresScreen(context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  backButton(
                    buttonForm: buttonForms.square,
                    iconSize: 15,
                    size: 35,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    'Search',
                    style: TextStyle(
                      color: kTextColor,
                      fontFamily: 'SFProDispay',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: kDefaultPadding),
                child: Search(
                  isEnabled: true,
                ),
              ),
              const Padding(
                padding: const EdgeInsets.only(top: kDefaultPadding),
                child: Text(
                  'Browse film genres',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: kTextColor,
                    fontFamily: 'SFProDispay',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: kDefaultPadding,
                ),
                height: MediaQuery.of(context).size.height / 1.5,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: kDefaultPadding,
                      childAspectRatio: 1.4),
                  itemBuilder: (_, index) => (buildGenreCard(context, index)),
                  itemCount: genres.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Stack buildGenreCard(context, int index) {
    return Stack(children: [
      Container(
        width: (MediaQuery.of(context).size.width - kDefaultPadding * 3) / 2,
        height: MediaQuery.of(context).size.height / 9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(genres[index]['image']),
            fit: BoxFit.cover,
          ),
          boxShadow: [kDefaultShadow],
          gradient: const LinearGradient(
            colors: [Color.fromARGB(255, 0, 0, 0), Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            backgroundBlendMode: BlendMode.darken,
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              colors: [Color.fromARGB(98, 0, 0, 0), Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 20,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Text(
            genres[index]['genre'],
            style: TextStyle(
              color: kTextColor,
              fontFamily: 'SFProDispay',
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    ]);
  }
}
