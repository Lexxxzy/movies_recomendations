import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_recomendations/components/splash_screen_favourite.dart';
import 'package:movies_recomendations/components/trending_favourite_movie.dart';
import '../../../providers/suggestions_movies_provider.dart';
import '../../../constants.dart';
import 'package:movies_recomendations/providers/single_movie_provider.dart';
import 'package:provider/provider.dart';

class SuggestionsDefaultBody extends StatefulWidget {
  final sugestionURL;
  SuggestionsDefaultBody({Key? key, this.sugestionURL = 'upcoming'})
      : super(key: key);

  @override
  State<SuggestionsDefaultBody> createState() => _SuggestionsDefaultBodyState();
}

class _SuggestionsDefaultBodyState extends State<SuggestionsDefaultBody> {
  var _isInit = true;
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<SuggestedMovies>(context, listen: false)
        .fetchAndSetSuggestions(widget.sugestionURL)
        .then(
      (value) {
        setState(
          () {
            _isLoading = false;
          },
        );
      },
    );
    _isInit = false;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final moviesData = Provider.of<SuggestedMovies>(context, listen: false);
    final movies = moviesData.upcomingMovies;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            buildUpcomingsHeader(),
            _isLoading ? SplashScreenFavourite() : buildSuggestedMovies(movies),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView buildSuggestedMovies(List<Movie> movies) {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          children: <Widget>[
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                  value: movies[index],
                  child: FavouriteMovie(),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Padding buildUpcomingsHeader() {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Row(
        children: <Widget>[
          BackButton(color: kTextLightColor),
          Text(
            widget.sugestionURL == 'upcoming'
                ? widget.sugestionURL.toString().substring(0, 1).toUpperCase() +
                    widget.sugestionURL
                        .toString()
                        .substring(1, widget.sugestionURL.length)
                : '',
            style: const TextStyle(
              fontFamily: 'SFProDisplay',
              fontSize: 28,
              color: Color(0xffffffff),
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(
            width: 10,
          ),
          Center(
            child: SvgPicture.asset(
              widget.sugestionURL == 'upcoming'
                  ? 'assets/icons/Fire.svg'
                  : 'assets/icons/${widget.sugestionURL}.svg',
              height: widget.sugestionURL != 'netflix' ? 32 : 100,
            ),
          ),
        ],
      ),
    );
  }
}
