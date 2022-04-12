// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:movies_recomendations/components/splash_screen.dart';
import 'package:movies_recomendations/constants.dart';
import 'package:movies_recomendations/providers/trending_movies_provider.dart';
import 'package:movies_recomendations/screens/genres/genres_screen.dart';
import 'package:provider/provider.dart';
import '../../../providers/movies_provider.dart';
import 'coming_movies.dart';
import 'recomendation_carousel.dart';
import '../../../components/search.dart';
import 'trending.dart';

import '../../../components/categories_menu.dart';

class Body extends StatelessWidget {
  Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CategotiesMenu(),
      ],
    );
  }
}

class MainScreenWidgets extends StatefulWidget {
  late TabController tabController;
  MainScreenWidgets(TabController tabController, {Key? key}) : super(key: key) {
    this.tabController = tabController;
  }

  @override
  State<MainScreenWidgets> createState() => _MainScreenWidgetsState();
}

class _MainScreenWidgetsState extends State<MainScreenWidgets> {
  var _isInit = true;
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Movies>(context).fetchAndSetMovies().then(
        (_) {
          Provider.of<TrendingMovies>(context, listen: false)
              .fetchAndSetTrending()
              .then(
            (_) {
              setState(
                () {
                  _isLoading = false;
                },
              );
            },
          );
        },
      );
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? SplashScreen()
        : Container(
            height: 100,
            child: SingleChildScrollView(
              child: Column(children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      GenresScreen.routeName,
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: kDefaultPadding,
                      left: kDefaultPadding,
                      right: kDefaultPadding,
                    ),
                    child: Search(
                      isEnabled: false,
                    ),
                  ),
                ),
                ComingMovies(),
                RecomendedMovieCarousel(widget.tabController),
                Padding(
                  padding: const EdgeInsets.only(bottom: kDefaultPadding * 2),
                  child: TrendingList(),
                ),
              ]),
            ),
          );
  }
}
