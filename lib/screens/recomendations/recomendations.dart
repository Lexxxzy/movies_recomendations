// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_recomendations/providers/recomendation_movies_provide.dart';
import 'package:provider/provider.dart';
import '../../blocs/swipe_block.dart';
import '../../components/splash_screen_recomendations.dart';
import '../../providers/movies_provider.dart';
import 'package:movies_recomendations/constants.dart';

import 'components/recomendations_body.dart';

class RecomendationsScreen extends StatefulWidget {
  static const routeName = '/recomendations';

  @override
  State<RecomendationsScreen> createState() => _RecomendationsScreenState();
}

class _RecomendationsScreenState extends State<RecomendationsScreen> {
  var _isInit = true;
  var isFirstTime = true;
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<RecomendedMovies>(context).fetchAndSetRecomendations().then((_) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final movies = Provider.of<RecomendedMovies>(context).recomendedMovies;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: BlocProvider(
        create: (_) => SwipeBloc()
          ..add(
            LoadMoviesEvent(
              movies: movies,
            ),
          ),
        child:_isLoading ? SplashScreenRecomendations() : RecomendationsBody(),
      ),
    );
  }
}
