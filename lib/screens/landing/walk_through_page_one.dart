import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_on_get_it/constants/routes.dart';
import 'package:go_on_get_it/data/local/my_hive.dart';
import 'package:go_on_get_it/screens/landing/landing_screen.dart';
import 'package:go_on_get_it/screens/screen_background.dart';

class WalkThroughFirst extends StatelessWidget {
  const WalkThroughFirst({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyHive.setToken(null);
    MyHive.setRadius(10);

    return const ScreenBackground(
      includePadding: false,
      child: SafeArea(
        child: LandingScreen(
          pagePos: 1,
          walkText: 'A lot of paper wasted in discount and our app is helping reduce that paper',
          walkImage: 'assets/images/w1.png',
          nextRout: Routes.walkThroughSecond,
        ),
      ),
    );
  }
}
