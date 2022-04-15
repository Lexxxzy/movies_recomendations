import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_recomendations/components/shimmer_widget.dart';

import '../constants.dart';

class SplashScreenFavourite extends StatelessWidget {
  const SplashScreenFavourite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) {
              return buildFavouriteShimmer(context);
            },
          ),
        ),
      ),
    );
  }

  Widget buildFavouriteShimmer(context) => Padding(
        padding: const EdgeInsets.only(
          bottom: kDefaultPadding,
          left: kDefaultPadding,
          right: kDefaultPadding,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ShimmerWidget.rectengular(
              height: 100,
              width: 111,
              shapeBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ShimmerWidget.rectengular(
                        height: 10,
                        width: MediaQuery.of(context).size.width * 0.2,
                        shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ShimmerWidget.rectengular(
                    height: 12,
                    width: MediaQuery.of(context).size.width * 0.5,
                    shapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ShimmerWidget.rectengular(
                    height: 10,
                    width: MediaQuery.of(context).size.width * 0.3,
                    shapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: SvgPicture.asset(
                'assets/icons/HeartOutlined.svg',
                height: 20,
                alignment: Alignment.topRight,
              ),
            ),
          ],
        ),
      );
}
