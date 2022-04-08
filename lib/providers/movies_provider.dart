import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movies_recomendations/constants.dart';
import 'package:http/http.dart' as http;

import './single_movie_provider.dart';

class Movies with ChangeNotifier {
  String plotText = "";

  List<Movie> _movies = [
    // Movie(
    //     poster:
    //         "https://www.youloveit.ru/uploads/posts/2017-09/1506175508_youloveit_ru_taina_koko_postery05.jpg",
    //     title: "Coco",
    //     id: 1,
    //     premiereWorld: "2017",
    //     ratingKinopoisk: 8.6,
    //     ratingIMDb: 8.4,
    //     genre: ["Drama", "Adventure"],
    //     description:
    //         "12-летний Мигель живёт в мексиканской деревушке в семье сапожников и тайно мечтает стать музыкантом. Тайно, потому что в его семье музыка считается проклятием. Когда-то его прапрадед оставил жену, прапрабабку Мигеля, ради мечты, которая теперь не даёт спокойно жить и его праправнуку. С тех пор музыкальная тема в семье стала табу. Мигель обнаруживает, что между ним и его любимым певцом Эрнесто де ла Крусом, ныне покойным, существует некая связь. Паренёк отправляется к своему кумиру в Страну Мёртвых, где встречает души предков. Мигель знакомится там с духом-скелетом по имени Гектор, который становится его проводником. Вдвоём они отправляются на поиски де ла Круса.",
    //     countries: ["USA", "Mexico"],
    //     age: 12,
    //     ifSeries: false,
    //     frames: [
    //       "https://avatars.mds.yandex.net/get-kinopoisk-image/1600647/a88e4348-829d-4ed2-b578-17bbb0a2ab5c/orig",
    //       "https://avatars.mds.yandex.net/get-kinopoisk-image/1777765/f1b77e75-2bd6-4e5a-b580-679f8f2d8691/orig",
    //       "https://avatars.mds.yandex.net/get-kinopoisk-image/1777765/9bb3794b-c1f7-4200-9cbc-612e0133046e/orig"
    //     ],
    //     isFavourite: true),
    // Movie(
    //   poster:
    //       "https://01streaming.tv/wp-content/uploads/resident-alien-95904-poster-scaled.jpg",
    //   title: "Resident Alien",
    //   id: 2,
    //   premiereWorld: "2021",
    //   ratingKinopoisk: 8.0,
    //   ratingIMDb: 8.2,
    //   genre: ["Drama", "Comedy"],
    //   description:
    //       "Доктор Гарри Вендершпигль — отшельник в небольшом городке в Колорадо. Ещё он — пришелец, который на самом деле упал на Землю и занял тело врача. Когда же доктора убивают, пришелец вынужден отложить миссию по возвращению домой и занять место убитого. Живя в новом теле, он постепенно начинает задаваться вопросами, стоят люди спасения или нет.",
    //   countries: ["USA"],
    //   age: 18,
    //   ifSeries: true,
    //   frames: [
    //     "https://avatars.mds.yandex.net/get-kinopoisk-image/1898899/4b9e0411-e469-4c6c-a124-048d50f02727/orig",
    //     "https://avatars.mds.yandex.net/get-kinopoisk-image/1900788/df9a40fd-f55f-4be9-91d0-1c4161097fa4/orig",
    //     "https://avatars.mds.yandex.net/get-kinopoisk-image/1900788/9d86ed78-e4bb-4b73-a064-9f0064258d22/orig"
    //   ],
    //   isFavourite: false,
    //   seasons: 3,
    //   dateTo: "now",
    // ),
    // Movie(
    //     poster:
    //         "https://i.pinimg.com/originals/45/89/f8/4589f8a22cb947a1a46eef64ee7f5cca.jpg",
    //     title: "Spider-Man",
    //     id: 3,
    //     premiereWorld: "2021",
    //     ratingKinopoisk: 8.2,
    //     ratingIMDb: 8.6,
    //     genre: ["Fiction", "Adventure", "Fantasy"],
    //     description:
    //         "Жизнь и репутация Питера Паркера оказываются под угрозой, поскольку Мистерио раскрыл всему миру тайну личности Человека-паука. Пытаясь исправить ситуацию, Питер обращается за помощью к Стивену Стрэнджу, но вскоре всё становится намного опаснее.",
    //     countries: ["USA", "India", "Iceland"],
    //     age: 12,
    //     ifSeries: false,
    //     frames: [
    //       "https://avatars.mds.yandex.net/get-kinopoisk-image/6201401/8b67471d-6c54-40f1-bfe8-8db989c06ce9/3840x",
    //       "https://avatars.mds.yandex.net/get-kinopoisk-image/4303601/e9d8a0a2-4026-4961-bf17-cb1a4b57e624/3840x",
    //       "https://avatars.mds.yandex.net/get-kinopoisk-image/4303601/6cb822bd-684a-46c5-8e52-7691bac00c82/3840x",
    //       "https://avatars.mds.yandex.net/get-kinopoisk-image/4303601/f54c4c52-a230-46da-8f75-19ad79895840/3840x"
    //     ],
    //     isFavourite: false),
  ];

  List<Movie> get movies {
    return <Movie>[..._movies];
  }

  Movie findById(int id) {
    return _movies.firstWhere((element) => element.id == id);
  }

  List<Movie> get favouriteMovies {
    List<Movie> favMovies = <Movie>[..._movies]
        .where((element) => element.isFavourite == true)
        .toList();
    return favMovies;
  }

  void removeItem(movieId) {
    favouriteMovies.remove(findById(movieId));
    notifyListeners();
  }

  void addMovie(Movie movie) {
    /*_movies.add(movie);*/
    notifyListeners();
  }

  Future<void> fetchAndSetMovies() async {
    const url = 'http://192.168.1.142:8000/Desktop/textData.json';

    try {
      final response = await http.get(
        Uri.parse(url),
      );
      String source = Utf8Decoder().convert(response.bodyBytes);

      final extractedData =
          List<Map<String, dynamic>>.from(json.decode(source));
      final List<Movie> loadedMovies = [];

      extractedData.forEach(
        ((movieInfo) => {
              loadedMovies.add(Movie(
                id: movieInfo['id'],
                age: movieInfo['age'],
                countries: List<String>.from(movieInfo['country']),
                description: movieInfo['descriprion'],
                frames: movieInfo['frames'],
                genre: movieInfo['genre'],
                poster: movieInfo['poster'],
                premiereWorld: movieInfo['date'].toString(),
                ratingIMDb: movieInfo['ratingIMDb'],
                ratingKinopoisk: movieInfo['ratingKinopoisk'],
                title: movieInfo['title'][0],
                ifSeries: movieInfo['ifSeries'],
                dateTo: movieInfo['dateTo'].toString(),
                isFavourite: true,
                seasons: movieInfo['seasons'],
              )),
            }),
      );
      _movies = loadedMovies;
      notifyListeners();
    } on Exception catch (e) {
      print('error');
      print(e.toString());
    }
  }
}
