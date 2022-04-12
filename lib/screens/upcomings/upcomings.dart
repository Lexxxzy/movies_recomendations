import 'package:flutter/material.dart';
import 'package:movies_recomendations/constants.dart';

import 'components/upcomings_body.dart';

class Upcomings extends StatelessWidget {
  const Upcomings({Key? key}) : super(key: key);
  static const routeName = '/upcomings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: UpcomingsBody(),
    );
  }
}
