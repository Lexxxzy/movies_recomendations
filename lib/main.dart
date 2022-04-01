import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_recomendations/providers/movies_provider.dart';
import 'package:movies_recomendations/screens/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'blocs/swipe_block.dart';
import 'screens/movie_detail/movie_detail.dart';
import 'screens/recomendations/recomendations.dart';

void main() {
  runApp(const MyApp());
}

/*create: (_) => SwipeBloc()
              ..add(
                LoadMoviesEvent(
                  movies: Movies().movies.where((user) => user.id != 1).toList(),
                ),
              ),*/
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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
          },
        ),
      ),
    );
  }
}
