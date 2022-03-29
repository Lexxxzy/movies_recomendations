import 'package:flutter/material.dart';
import 'package:movies_recomendations/providers/movies_provider.dart';
import 'package:movies_recomendations/providers/single_movie_provider.dart';
import 'package:movies_recomendations/screens/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'screens/favourites/movie_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
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
        },
      ),
    );
  }
}
