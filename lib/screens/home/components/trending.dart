// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_recomendations/components/trending_favourite_movie.dart';
import 'package:movies_recomendations/providers/trending_movies_provider.dart';
import '../../../constants.dart';
import 'package:provider/provider.dart';

class TrendingList extends StatefulWidget {
  const TrendingList({Key? key}) : super(key: key);

  @override
  State<TrendingList> createState() => _TrendingListState();
}

class _TrendingListState extends State<TrendingList> {
  @override
  Widget build(BuildContext context) {
    final moviesData = Provider.of<TrendingMovies>(context, listen: false);
    final movies = moviesData.trendingMoviesTop;
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          buildRecomendationsHeader(),
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
    );
  }

  Padding buildRecomendationsHeader() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: kDefaultPadding,
        left: kDefaultPadding,
        right: kDefaultPadding,
      ),
      child: Row(
        children: <Widget>[
          const Text(
            'Trending',
            style: TextStyle(
              fontFamily: 'SFProDisplay',
              fontSize: 20,
              color: Color(0xffffffff),
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(
            width: 10,
          ),
          SvgPicture.asset(
            'assets/icons/Fire.svg',
            height: 20,
          ),
        ],
      ),
    );
  }
}
