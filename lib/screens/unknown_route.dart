import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnknownRoutePage extends StatelessWidget {
  const UnknownRoutePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Text(
          'Unknown route',
          style: Get.textTheme.headline1,
        ),
      ),
    );
  }
}
