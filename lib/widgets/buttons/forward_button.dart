

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_on_get_it/constants/color_constants.dart';
import 'package:sizer/sizer.dart';

class ForwardButton extends StatelessWidget {
  final String? text;
  final VoidCallback onPressed;

  const ForwardButton({
    Key? key,
    this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool _isMobileLayout = shortestSide < 600;

    return TextButton(onPressed: onPressed, child: Stack(children: [
      Container(
        height: _isMobileLayout ? 8.h : 6.h,
        width: _isMobileLayout ? 8.h : 6.h,
        margin: EdgeInsets.all(_isMobileLayout ? 10 : 5),
        decoration: BoxDecoration(
          border: Border.all(color: ColorConstants.parrotDark, width: 1.0),
          borderRadius: const BorderRadius.all(Radius.elliptical(50, 50)),
        ),
      ),
      Positioned.fill(
        child: Align(
          alignment: Alignment.center,
          child: Container(
            height: 7.h,
            width: 7.h,
            margin: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: ColorConstants.parrotDark,
              borderRadius: BorderRadius.all(Radius.elliptical(50, 50)),
            ),
          ),
        ),
      ),
      Positioned.fill(
        child: Align(
          alignment: Alignment.center,
          child: SvgPicture.asset('assets/svgs/fr_arrow.svg'),
        ),
      ),

    ],)) ;

  }
}