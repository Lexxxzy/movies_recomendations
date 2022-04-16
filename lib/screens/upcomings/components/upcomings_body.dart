import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_recomendations/components/trending_favourite_movie.dart';
import '../../../providers/upcoming_movies_provider.dart';
import '../../../constants.dart';
import 'package:provider/provider.dart';

class UpcomingsBody extends StatefulWidget {
  const UpcomingsBody({Key? key}) : super(key: key);

  @override
  State<UpcomingsBody> createState() => _UpcomingsBodyState();
}

class _UpcomingsBodyState extends State<UpcomingsBody> {
  @override
  Widget build(BuildContext context) {
    final moviesData = Provider.of<UpcomingMovies>(context, listen: false);
    final movies = moviesData.upcomingMovies;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            buildUpcomingsHeader(),
            SingleChildScrollView(
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
            ),
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
          const Text(
            'Upcomings',
            style: TextStyle(
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
          SvgPicture.asset(
            'assets/icons/Fire.svg',
            height: 28,
          ),
        ],
      ),
    );
  }
}
