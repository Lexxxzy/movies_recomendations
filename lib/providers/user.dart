import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'movies_provider.dart';

class User with ChangeNotifier {
  String nickName;
  String email;
  String name;
  List<String> favourites, loved, disliked;
  String avatar;

  User(
      {required this.avatar,
      required this.nickName,
      required this.email,
      required this.name,
      required List<String> this.favourites,
      required List<String> this.loved,
      required List<String> this.disliked});

  User get user {
    return User(
      avatar:
          'https://images.unsplash.com/photo-1488161628813-04466f872be2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80',
      nickName: 'Lexxxy',
      email: 'lex.halikov@gmail.com',
      name: 'Alex Halikov',
      favourites:
          List.from(Movies().favouriteMovies.map((e) => e.id.toString())),
      loved: ['1'],
      disliked: ['1'],
    );
  }
}
