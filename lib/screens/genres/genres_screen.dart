// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movies_recomendations/components/backButton.dart';
import 'package:movies_recomendations/components/search.dart';
import 'package:movies_recomendations/components/splash_screen_favourite.dart';
import 'package:movies_recomendations/constants.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../components/trending_favourite_movie.dart';
import '../../providers/single_movie_provider.dart';
import '../../providers/user.dart';

class GenresScreen extends StatefulWidget {
  GenresScreen({Key? key}) : super(key: key);
  static const routeName = '/genres';

  @override
  State<GenresScreen> createState() => _GenresScreenState();
}

class _GenresScreenState extends State<GenresScreen> {
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

  Future<void> fetchAndSetSearch(searchVal, authToken) async {
    final url = 'http://192.168.1.142:5000/api/v1/search?filmname=$searchVal';

    try {
      setState(() {
        isLoading = true;
      });
      var response = await http
          .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});

      String source = Utf8Decoder().convert(response.bodyBytes);

      final extractedData =
          List<Map<String, dynamic>>.from(json.decode(source));

      final List<Movie> loadedMovies = [];
      extractedData.forEach(
        ((movieInfo) => {
              if (movieInfo['title'][0] != null &&
                  movieInfo['description'] != null)
                {
                  loadedMovies.add(
                    Movie(
                      authToken: authToken,
                      id: movieInfo['id'],
                      age: movieInfo['age'],
                      countries: movieInfo['country'],
                      description: movieInfo['description'],
                      frames: movieInfo['frames'],
                      genre: movieInfo['genre'] ?? [],
                      poster: movieInfo['poster'],
                      premiereWorld: movieInfo['date'].toString(),
                      ratingIMDb: movieInfo['ratingIMDb'] ?? 0.0,
                      ratingKinopoisk: movieInfo['ratingKinopoisk'] ?? 0.0,
                      title: movieInfo['title'][0] ?? '',
                      ifSeries: movieInfo['ifSeries'] == 'true' ? true : false,
                      dateTo: movieInfo['dateTo'].toString(),
                      isFavourite: false,
                      seasons: movieInfo['seasons'] ?? 0,
                    ),
                  ),
                }
            }),
      );

      setState(() {
        _searchMovies = loadedMovies;
        isLoading = false;
      });
    } on Exception catch (e) {}
  }

  bool isSearchFocused = false;
  bool isLoading = false;
  List<Movie> _searchMovies = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBackgroundColor,
      body: buildGenresScreen(context),
    );
  }

  SafeArea buildGenresScreen(context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
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
                      onSearchFocused: () => setState(() {
                        isSearchFocused = true;
                      }),
                      onSubmit: (searchValue) {
                        fetchAndSetSearch(
                            searchValue,
                            Provider.of<User>(context, listen: false)
                                .authToken);
                      },
                      isEnabled: true,
                    ),
                  ),
                ],
              ),
            ),
            isSearchFocused == false
                ? Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: kDefaultPadding),
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
                          padding: const EdgeInsets.only(
                            top: kDefaultPadding,
                          ),
                          height: MediaQuery.of(context).size.height / 1.5,
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: kDefaultPadding,
                                    childAspectRatio: 1.4),
                            itemBuilder: (_, index) =>
                                (buildGenreCard(context, index)),
                            itemCount: genres.length,
                          ),
                        ),
                      ],
                    ),
                  )
                : isLoading
                    ? Padding(
                        padding:
                            const EdgeInsets.only(top: kDefaultPadding / 4),
                        child: SplashScreenFavourite(),
                      )
                    : SingleChildScrollView(
                        physics: const ScrollPhysics(),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: kDefaultPadding / 4),
                          child: Column(
                            children: <Widget>[
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: _searchMovies.length,
                                itemBuilder: (context, index) {
                                  return ChangeNotifierProvider.value(
                                    value: _searchMovies[index],
                                    child: FavouriteMovie(),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ),
          ],
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
            style: const TextStyle(
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
