class Movie {
  final int? id, seasons, age;
  final double ratingKinopoisk, ratingIMDb;
  final List<String> genre, countries, frames;
  final String description, title, poster, premiereWorld, dateTo;
  final bool ifSeries, isFavourite;

  Movie({
    required this.poster,
    required this.title,
    required this.id,
    required this.premiereWorld,
    required this.ratingKinopoisk,
    required this.ratingIMDb,
    required this.genre,
    required this.description,
    required this.countries,
    required this.age,
    required this.ifSeries,
    this.seasons,
    this.dateTo = "",
    required this.frames,
    required this.isFavourite,
  });
}

// our demo data movie data
List<Movie> movies = [
  Movie(
      poster: "assets/images/cocoposter.jpg",
      title: "Coco",
      id: 1,
      premiereWorld: "2017",
      ratingKinopoisk: 8.6,
      ratingIMDb: 8.4,
      genre: ["Drama", "Adventure"],
      description: plotText,
      countries: ["USA", "Mexico"],
      age: 12,
      ifSeries: false,
      frames: [
        "https://avatars.mds.yandex.net/get-kinopoisk-image/1600647/a88e4348-829d-4ed2-b578-17bbb0a2ab5c/orig",
        "https://avatars.mds.yandex.net/get-kinopoisk-image/1777765/f1b77e75-2bd6-4e5a-b580-679f8f2d8691/orig",
        "https://avatars.mds.yandex.net/get-kinopoisk-image/1777765/9bb3794b-c1f7-4200-9cbc-612e0133046e/orig"
      ],
      isFavourite: false),
  Movie(
    poster: "assets/images/alien.jfif",
    title: "Resident Alien",
    id: 2,
    premiereWorld: "2021",
    ratingKinopoisk: 8.0,
    ratingIMDb: 8.2,
    genre: ["Drama", "Comedy"],
    description: plotText,
    countries: ["USA"],
    age: 18,
    ifSeries: true,
    frames: [
      "https://avatars.mds.yandex.net/get-kinopoisk-image/1898899/4b9e0411-e469-4c6c-a124-048d50f02727/orig",
      "https://avatars.mds.yandex.net/get-kinopoisk-image/1900788/df9a40fd-f55f-4be9-91d0-1c4161097fa4/orig",
      "https://avatars.mds.yandex.net/get-kinopoisk-image/1900788/9d86ed78-e4bb-4b73-a064-9f0064258d22/orig"
    ],
    isFavourite: false,
    seasons: 3,
    dateTo: "now",
  ),
  Movie(
      poster: "assets/images/spider.jfif",
      title: "Spider-Man",
      id: 3,
      premiereWorld: "2021",
      ratingKinopoisk: 8.2,
      ratingIMDb: 8.6,
      genre: ["Fiction", "Adventure", "Fantasy"],
      description: plotText,
      countries: ["USA", "India", "Iceland"],
      age: 12,
      ifSeries: false,
      frames: [
        "https://avatars.mds.yandex.net/get-kinopoisk-image/1600647/a88e4348-829d-4ed2-b578-17bbb0a2ab5c/orig",
        "https://avatars.mds.yandex.net/get-kinopoisk-image/1777765/f1b77e75-2bd6-4e5a-b580-679f8f2d8691/orig",
        "https://avatars.mds.yandex.net/get-kinopoisk-image/1777765/9bb3794b-c1f7-4200-9cbc-612e0133046e/orig"
      ],
      isFavourite: false),
];

String plotText =
    "Доктор Гарри Вендершпигль — отшельник в небольшом городке в Колорадо. Ещё он — пришелец, который на самом деле упал на Землю и занял тело врача. Когда же доктора убивают, пришелец вынужден отложить миссию по возвращению домой и занять место убитого. Живя в новом теле, он постепенно начинает задаваться вопросами, стоят люди спасения или нет.";
