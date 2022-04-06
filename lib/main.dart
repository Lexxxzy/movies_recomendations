// @dart=2.11
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/components/splash_screen.dart';
import '/providers/auth.dart';
import 'providers/movies_provider.dart';
import '/providers/user.dart';
import '/screens/genres/genres_screen.dart';
import '/screens/home/home_screen.dart';
import '/screens/welcome/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'blocs/swipe_block.dart';
import 'screens/authentication/sign_in/sign_in_screen.dart';
import 'screens/authentication/sign_up/sign_up_screen.dart';
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
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Movies(),
          ),
          ChangeNotifierProvider.value(
            value: User(),
          ),
          ChangeNotifierProvider.value(
            value: Auth(),
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
            },
          ),
        ),
    );
  }
}
