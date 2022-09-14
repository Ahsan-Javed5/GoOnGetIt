import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_on_get_it/screens/landing/landing_screen.dart';
import 'package:go_on_get_it/screens/screen_background.dart';

class WalkThroughThird extends StatelessWidget {
  const WalkThroughThird({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScreenBackground(
      includePadding: false,
      child: SafeArea(
        child: LandingScreen(
            pagePos: 3,
            walkText: 'Our app is helping people find discounts near them.',
            walkImage: 'assets/images/w3.png',
            nextRout: ''),
      ),
    );
  }
}
