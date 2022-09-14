import 'package:flutter/material.dart';
import 'package:go_on_get_it/constants/color_constants.dart';

class ScreenBackground extends StatelessWidget {
  final Widget? child;
  final bool includePadding;

  const ScreenBackground(
      {Key? key, required this.child, this.includePadding = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          colors: [
            ColorConstants.whiteColor,
            ColorConstants.whiteColor,
          ],
        ),
      ),
      child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: child),
    );
  }
}