// @dart=2.11
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_recomendations/providers/movies_provider.dart';
import 'package:movies_recomendations/providers/user.dart';
import 'package:movies_recomendations/screens/genres/genres_screen.dart';
import 'package:movies_recomendations/screens/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'blocs/swipe_block.dart';
import 'screens/movie_detail/movie_detail.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/recomendations/recomendations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SwipeBloc()
            ..add(
              LoadMoviesEvent(
                movies: Movies().movies,
              ),
            ),
        )
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Movies(),
          ),
          ChangeNotifierProvider.value(
            value: User(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'WTW',
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: HomeScreen(),
          routes: {
            MovieDetailScreen.routeName: (ctx) => MovieDetailScreen(),
            RecomendationsScreen.routeName: (ctx) => RecomendationsScreen(),
            ProfileScreen.routeName: (ctx) => ProfileScreen(),
            GenresScreen.routeName: (ctx) => GenresScreen(),
          },
        ),
      ),
    );
  }
}
