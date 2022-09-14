import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_on_get_it/constants/app_images.dart';
import 'package:go_on_get_it/constants/font_constants.dart';
import 'package:sizer/sizer.dart';

class TextWithLeaves extends StatelessWidget {
  final String title;

  const TextWithLeaves(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool _isMobileLayout = shortestSide < 600;

    return Padding(
      padding: EdgeInsets.only(
        left: 2.8.w,
        top: 2.h,
        bottom: 1.h,
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            bottom: 2.h,
            child: _isMobileLayout
                ? SvgPicture.asset(AppImages.darkGreenLeaves)
                : SvgPicture.asset(AppImages.darkGreenLeaves, height: 2.5.h,),
          ),
          Positioned(
            //top: 4.h,
            child: Padding(
              padding: EdgeInsets.only(
                right: _isMobileLayout ? 2.5.h : 2.2.h,
                top: 2.7.h,
              ),
              child: Text(
                title,
                style: TextStyle(
                  fontSize:  _isMobileLayout ? 17.sp : 10.sp,
                  fontFamily: FontConstants.sourceSansProSemiBold,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
