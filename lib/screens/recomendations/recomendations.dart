// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../blocs/swipe_block.dart';
import '../../providers/movies_provider.dart';
import '../home/components/app_bar.dart';
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
      Provider.of<Movies>(context).fetchAndSetMovies().then((_) {
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
    final movies = Provider.of<Movies>(context).movies;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: BlocProvider(
        create: (_) => SwipeBloc()
          ..add(
            LoadMoviesEvent(
              movies: movies,
            ),
          ),
        child: RecomendationsBody(),
      ),
    );
  }
}
