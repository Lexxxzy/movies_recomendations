import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_recomendations/constants.dart';
import 'package:movies_recomendations/providers/single_movie_provider.dart';
import 'package:provider/provider.dart';

import '../../components/trending_favourite_movie.dart';
import '../../providers/movies_provider.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesData = Provider.of<Movies>(context);
    final movies = moviesData.favouriteMovies;
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Column(
                children: <Widget>[
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      return ChangeNotifierProvider.value(
                        value: movies[index],
                        child: Dismissible(
                          key: ValueKey(movies[index].id),
                          background: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: kErrorColor,
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: kDefaultPadding),
                              child: const Icon(
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
                            movies[index].toggleFavourite();
                          },
                          child: FavouriteMovie(),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final snackBar = (movieData) => movieData.isFavourite == false
    ? SnackBar(
        content: Text('Added To Favourite'),
        backgroundColor: kGreenColor,
        duration: Duration(milliseconds: 200),
      )
    : SnackBar(
        content: Text('Added To Favourite'),
        backgroundColor: kGreenColor,
        duration: Duration(milliseconds: 200),
      );
