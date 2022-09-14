import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:go_on_get_it/constants/app_images.dart';
import 'package:go_on_get_it/constants/routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        //height: double.infinity,
        child: getFirstPage(),
      ),
    );
  }

  getFirstPage() {
    Future.delayed(const Duration(seconds: 3), () {
      Get.toNamed(Routes.walkThroughFirst);
    });
    return Image.asset(
      AppImages.splashScreen,
      fit: BoxFit.contain,
    );
  }
}
