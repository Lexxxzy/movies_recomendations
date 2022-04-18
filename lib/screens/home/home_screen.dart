// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:movies_recomendations/providers/trending_movies_provider.dart';
import 'package:provider/provider.dart';
import '../../providers/movies_provider.dart';
import '../../providers/suggestions_movies_provider.dart';
import '../../providers/user.dart';
import 'components/body.dart';
import 'package:movies_recomendations/constants.dart';

import 'components/app_bar.dart';

class HomeScreen extends StatefulWidget {
  static final routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();
  var _isInit = true;
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<TrendingMovies>(context).fetchAndSetTrending().then(
        (_) {
          Provider.of<SuggestedMovies>(context, listen: false)
              .fetchAndSetSuggestions('upcoming')
              .then((_) {
            Provider.of<User>(context, listen: false).fetchAndSetUser().then(
              (_) {
                setState(
                  () {
                    _isLoading = false;
                  },
                );
              },
            );
          });
        },
      );
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: LiquidPullToRefresh(
          key: _refreshIndicatorKey,
          color: kMainColor,
          height: MediaQuery.of(context).size.height * 0.05,
          animSpeedFactor: 1,
          backgroundColor: kBackgroundColor,
          onRefresh: Provider.of<TrendingMovies>(context).fetchAndSetTrending,
          child: Body(isLoading: _isLoading),
        ),
      ),
    );
  }
}
