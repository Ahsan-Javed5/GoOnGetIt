import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_on_get_it/constants/color_constants.dart';
import 'package:go_on_get_it/constants/font_constants.dart';
import 'package:go_on_get_it/constants/routes.dart';
import 'package:go_on_get_it/widgets/buttons/custom_oval_button.dart';
import 'package:go_on_get_it/widgets/buttons/forward_button.dart';
import 'package:sizer/sizer.dart';

class LandingScreen extends StatelessWidget {
  final int pagePos;
  final String? walkImage;
  final String? walkText;
  final String nextRout;

  const LandingScreen(
      {Key? key,
      required this.pagePos,
      this.walkImage,
      this.walkText,
      required this.nextRout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool _isMobileLayout = shortestSide < 600;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Expanded(
              child: Column(
            children: [
              Align(
                child: Padding(
                  padding: EdgeInsets.only(right: 4.w, top: _isMobileLayout ? 0 : 2.5.h),
                  child: CustomOvalButton(
                    text: 'Skip',
                    onPressed: () {
                      Get.offAllNamed(Routes.homeScreen);
                    },
                  ),
                ),
                alignment: Alignment.centerRight,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child:  Padding(
                    padding: EdgeInsets.only(top: 1.h),
                    child: Image.asset(walkImage ?? ''),
                  )
                )
              )
            ],
          )),
          Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Align(
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(start: _isMobileLayout ? 5.w : 30.w, end: _isMobileLayout ? 5.w : 30.w, bottom: _isMobileLayout ? 0 : 3.h),
                    child: Text(
                      walkText ?? '',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: FontConstants.sourceSansProRegular,
                        fontSize: _isMobileLayout ? 13.sp : 8.sp,
                      ),
                    ),
                  ),
                  alignment: Alignment.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 4.w,
                      ),
                      Container(
                        height: 1.2.h,
                        width: _isMobileLayout ? pagePos == 1 ? 10.w : 5.w : pagePos == 1 ? 5.w : 3.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: pagePos == 1
                                ? ColorConstants.parrotDark
                                : ColorConstants.grayLevel6),
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      Container(
                        height: 1.2.h,
                        width: _isMobileLayout ? pagePos == 2 ? 10.w : 5.w : pagePos == 2 ? 5.w : 3.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: pagePos == 2
                                ? ColorConstants.parrotDark
                                : ColorConstants.grayLevel6),
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      Container(
                        height: 1.2.h,
                        width: _isMobileLayout ? pagePos == 3 ? 10.w : 5.w : pagePos == 3 ? 5.w : 3.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: pagePos == 3
                              ? ColorConstants.parrotDark
                              : ColorConstants.grayLevel6,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: _isMobileLayout ? 1.w : 3.w),
                    child: ForwardButton(onPressed: () {
                      if (nextRout.isEmpty) {
                        Get.offAllNamed(Routes.homeScreen);
                      } else {
                        Get.toNamed(nextRout);
                      }
                    }),
                  ),
                ],
              ),
              SizedBox(height: _isMobileLayout ? 0 : 3.5.h,),
              Row(
                children: [
                  SizedBox(
                    width: 4.w,
                  ),
                  _isMobileLayout
                      ? SvgPicture.asset('assets/svgs/double_leaf.svg')
                      : SvgPicture.asset('assets/svgs/double_leaf.svg', height: 14.h,),
                ],
              )
            ],
          ),
          ),
        ],
      ),
    );
  }
}
