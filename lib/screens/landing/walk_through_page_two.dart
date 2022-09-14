import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_on_get_it/constants/routes.dart';
import 'package:go_on_get_it/screens/landing/landing_screen.dart';
import 'package:go_on_get_it/screens/screen_background.dart';

class WalkThroughSecond extends StatelessWidget {
  const WalkThroughSecond({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScreenBackground(
      includePadding: false,
      child: SafeArea(
        child: LandingScreen(
            pagePos: 2,
            walkText: 'A lot of daily use and food products were wasted due to expiry now shop owners can reduce that garbage to place them on discount before they expire.',
            walkImage: 'assets/images/w2.png',
            nextRout: Routes.walkThroughThird),
      ),
    );
  }
}
