import 'package:flutter/material.dart';
import 'package:movies_recomendations/constants.dart';

import 'components/suggestions_body.dart';

class Upcomings extends StatelessWidget {
  const Upcomings({Key? key}) : super(key: key);
  static const routeName = '/suggested-films';

  @override
  Widget build(BuildContext context) {
    final sugestionURL = (ModalRoute.of(context)?.settings.arguments ??
        <String, String>{}) as Map;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SuggestionsDefaultBody(
        sugestionURL: sugestionURL['sugestionURL'],
      ),
    );
  }
}
