// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:movies_recomendations/components/splash_screen.dart';
import 'package:movies_recomendations/screens/recomendations/recomendations.dart';

import '../constants.dart';
import '../screens/favourite/favourite_screen.dart';
import '../screens/home/components/body.dart';

class CategotiesMenu extends StatefulWidget {
  bool isLoading;
  CategotiesMenu({required this.isLoading});
  @override
  State<CategotiesMenu> createState() => _CategotiesMenuState();
}

class _CategotiesMenuState extends State<CategotiesMenu>
    with TickerProviderStateMixin {
  late TabController _tabController;

  int currentIndex = 0;

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 45,
          width: double.maxFinite,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: TabBar(
                labelColor: kTextColor,
                unselectedLabelColor: kTextGreyColor,
                controller: _tabController,
                isScrollable: true,
                unselectedLabelStyle: TextStyle(
                  fontFamily: "SFProDisplay",
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
                labelStyle: TextStyle(
                  fontFamily: "SFProDisplay",
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
                indicator: CustomTabIndicator(),
                labelPadding: EdgeInsets.only(
                    right: kDefaultPadding - 7, left: kDefaultPadding - 7),
                tabs: const [
                  Tab(
                    text: "Popular",
                  ),
                  Tab(
                    text: "You might like",
                  ),
                  Tab(
                    text: "Favourite",
                  ),
                  Tab(
                    text: "Loved",
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: kDefaultPadding),
          child: Container(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                kToolbarHeight -
                kBottomNavigationBarHeight,
            width: double.maxFinite,
            child: TabBarView(
              controller: _tabController,
              children: [
                widget.isLoading
                    ? Container(child: SplashScreen())
                    : MainScreenWidgets(_tabController),
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: RecomendationsScreen(),
                ),
                FavouritesScreen(_tabController),
                Container()
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CustomTabIndicator extends Decoration {
  final double radius;

  final Color color;

  final double indicatorHeight;

  const CustomTabIndicator({
    this.radius = 10,
    this.indicatorHeight = 4,
    this.color = kMainColor,
  });

  @override
  _CustomPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomPainter(
      this,
      onChanged,
      radius,
      color,
      indicatorHeight,
    );
  }
}

class _CustomPainter extends BoxPainter {
  final CustomTabIndicator decoration;
  final double radius;
  final Color color;
  final double indicatorHeight;

  _CustomPainter(
    this.decoration,
    VoidCallback? onChanged,
    this.radius,
    this.color,
    this.indicatorHeight,
  ) : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);

    final Paint paint = Paint();
    double xAxisPos = offset.dx + configuration.size!.width / 2;
    double yAxisPos = offset.dy + configuration.size!.height - 3;
    paint.color = color;

    RRect fullRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(xAxisPos, yAxisPos),
        width: configuration.size!.width / 2,
        height: indicatorHeight,
      ),
      Radius.circular(radius),
    );

    canvas.drawRRect(fullRect, paint);
  }
}
