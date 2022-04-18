// @dart=2.11
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:movies_recomendations/providers/single_movie_provider.dart';
import 'package:movies_recomendations/providers/trending_movies_provider.dart';
import 'package:movies_recomendations/providers/suggestions_movies_provider.dart';
import 'package:movies_recomendations/screens/authentication/verification/verification.dart';
import 'package:movies_recomendations/screens/edit_profile/edit_profile_screen.dart';
import '/components/splash_screen.dart';
import '/providers/auth.dart';
import 'providers/movies_provider.dart';
import '/providers/user.dart';
import '/screens/genres/genres_screen.dart';
import '/screens/home/home_screen.dart';
import '/screens/welcome/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'screens/authentication/sign_in/sign_in_screen.dart';
import 'screens/authentication/sign_up/sign_up_screen.dart';
import 'screens/movie_detail/movie_detail.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/recomendations/recomendations.dart';
import 'screens/suggestionsSliderPages/upcomings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Movies>(
          update: (ctx, auth, previousMovies) => Movies(
              auth.token, previousMovies == null ? [] : previousMovies.movies),
        ),
        ChangeNotifierProxyProvider<Auth, User>(
          update: (ctx, auth, previousUser) => User(
              authToken: auth.token,
              user: previousUser == null
                  ? User(
                      avatar:
                          'http://192.168.1.142:5000/api/v1/auth/files/default-avatar.png',
                      nickName: 'nonickname',
                      email: 'example@gmail.com',
                      name: 'No Name',
                      favourites: 0,
                      loved: 0,
                      disliked: 0,
                    )
                  : previousUser.user),
        ),
        ChangeNotifierProxyProvider<Auth, TrendingMovies>(
          update: (ctx, auth, previousMovies) => TrendingMovies(auth.token,
              previousMovies == null ? [] : previousMovies.trendingMovies),
        ),
        ChangeNotifierProxyProvider<Auth, SuggestedMovies>(
          update: (ctx, auth, previousMovies) => SuggestedMovies(auth.token,
              previousMovies == null ? [] : previousMovies.upcomingMovies),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'WTW',
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          /*
              Виджет пересобирается каждый раз, когда осуществляется переход
              на домашнюю страницу. Соответсвенно каждый раз проверяется
              авторизован ли пользователь, пока это проверяется
              показывается SplashScreen. Если пользователь авторизирован 
              и токен не истек то показывается HomeScreen.
            */
          home: auth.isAuth
              ? HomeScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : WelcomScreen(),
                ),
          routes: {
            HomeScreen.routeName: (ctx) => HomeScreen(),
            MovieDetailScreen.routeName: (ctx) => MovieDetailScreen(),
            RecomendationsScreen.routeName: (ctx) => RecomendationsScreen(),
            ProfileScreen.routeName: (ctx) => ProfileScreen(),
            GenresScreen.routeName: (ctx) => GenresScreen(),
            SignInScreen.routeName: (ctx) => SignInScreen(),
            SignUpScreen.routeName: (ctx) => SignUpScreen(),
            Upcomings.routeName: (ctx) => Upcomings(),
            EditProfile.routeName: (ctx) => EditProfile(),
            Verification.routeName: (ctx) => Verification(),
          },
        ),
      ),
    );
  }
}
