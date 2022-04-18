import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_recomendations/components/button.dart';
import 'package:movies_recomendations/components/splash_screen.dart';
import 'package:movies_recomendations/components/splash_screen_favourite.dart';
import 'package:movies_recomendations/constants.dart';
import 'package:movies_recomendations/providers/single_movie_provider.dart';
import 'package:provider/provider.dart';

import '../../components/trending_favourite_movie.dart';
import '../../providers/movies_provider.dart';

import '/components/categories_menu.dart';

class FavouritesScreen extends StatefulWidget {
  late TabController tabController;
  FavouritesScreen(TabController tabController, {Key? key}) {
    this.tabController = tabController;
  }

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  double _opacity = 0.0;
  bool isAllRemoved = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _opacity = 0;
  }

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
          setState(
            () {
              _isLoading = false;
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
    final moviesData = Provider.of<Movies>(context);
    final movies = moviesData.favouriteMovies;
    int numOfFavs = movies.length;
    return SafeArea(
      child: _isLoading
          ? SplashScreenFavourite()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: buildFavouritesBody(movies, numOfFavs, context),
              ),
            ),
    );
  }

  Column buildFavouritesBody(List<Movie> movies, int numOfFavs, BuildContext context) {
    return Column(
                children: <Widget>[
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      return ChangeNotifierProvider.value(
                          value: movies[index],
                          child:
                              buildFavouriteCards(movies, index, numOfFavs));
                    },
                  ),
                  isAllRemoved || movies.isEmpty
                      ? buildNoFavouritesScreen(context)
                      : Container()
                ],
              );
  }

  Container buildNoFavouritesScreen(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.3,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            child: Padding(
              padding: const EdgeInsets.only(left: kDefaultPadding),
              child: SizedBox(
                width: 270,
                child: DefaultTextStyle(
                    style: const TextStyle(
                      color: kTextColor,
                      fontFamily: 'SFProDisplay',
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                    ),
                    child: AnimatedTextKit(
                      isRepeatingAnimation: false,
                      onNext: (g, n) => setState(() {
                        _opacity = 1;
                      }),
                      pause: Duration(milliseconds: 300),
                      animatedTexts: [
                        TyperAnimatedText(
                          "",
                        ),
                        TyperAnimatedText(
                          "You don’t have favorites yet...",
                        ),
                      ],
                    )),
              ),
            ),
          ),
          Positioned(
            child: Container(
              margin: EdgeInsets.all(kDefaultPadding),
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 2000),
                opacity: _opacity,
                child: SvgPicture.asset('assets/images/noFavourites.svg',
                    alignment: Alignment.topCenter,
                    width: MediaQuery.of(context).size.width),
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                  top: kDefaultPadding / 2, bottom: kDefaultPadding * 2 - 10),
              child: myCustomButton(
                content: 'Explore new movies',
                onPress: () => {
                  widget.tabController
                      .animateTo((widget.tabController.index + 1) % 2)
                },
                fontSize: 15,
                width: 50,
                height: 14,
              ),
            ),
          )
        ],
      ),
    );
  }

  Dismissible buildFavouriteCards(List<Movie> movies, int index, numOfFavs) {
    return Dismissible(
      key: ValueKey(movies[index].id),
      background: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: kErrorColor,
        ),
        child: const Padding(
          padding: EdgeInsets.only(right: kDefaultPadding),
          child: Icon(
            CupertinoIcons.delete,
            color: kTextColor,
            size: 32,
          ),
        ),
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        movies[index].removeFavourite(context);
        setState(() {
          numOfFavs -= 1;
        });
        if (movies.length == 1) {
          setState(() {
            isAllRemoved = !isAllRemoved;
          });
        }
      },
      child: FavouriteMovie(),
    );
  }
}
