import 'package:flutter/material.dart';
import 'package:go_on_get_it/constants/font_constants.dart';
import 'package:go_on_get_it/widgets/back_arrow.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool _isMobileLayout = shortestSide < 600;

    return Scaffold(
      appBar: _isMobileLayout
          ? AppBar(
        leading: BackArrow(),
        title: Align(
          alignment: Alignment.centerLeft,
          child: Transform(
            transform: Matrix4.translationValues(-10, 6.0, 0.0),
            child: Padding(
              padding: EdgeInsets.only(left: 1.w),
              child: Text(
                'About Us'.tr,
                style: TextStyle(
                  fontFamily: FontConstants.sourceSansProSemiBold,
                  color: Colors.black,
                  fontSize: 15.sp,
                ),
              ),
            ),
          ),
        ),
        titleSpacing: 0.7.w,
        backgroundColor: Colors.transparent,
        elevation: 0,
      )
          : AppBar(
        toolbarHeight: 7.h,
        leading: BackArrow(),
        title: Align(
          alignment: Alignment.centerLeft,
          child: Transform(
            transform: Matrix4.translationValues(-10, 6.0, 0.0),
            child: Text(
              'About Us'.tr,
              style: TextStyle(
                fontFamily: FontConstants.sourceSansProSemiBold,
                color: Colors.black,
                fontSize: 10.sp,
              ),
            ),
          ),
        ),
        titleSpacing: 0.7.w,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 4.5.w, right: 4.5.w, top: 3.h),
        child: Text(
          'This is aboutUs Page Screen. It includes all the information about company'
          'history and progress. In this section you can find all details about the company'
          'This is aboutUs Page Screen. It includes all the information about company'
          'history and progress. In this section you can find all details about the company'
          'This is aboutUs Page Screen. It includes all the information about company'
          'history and progress. In this section you can find all details about the company'
          'This is aboutUs Page Screen. It includes all the information about company'
          'history and progress. In this section you can find all details about the company'
          'This is aboutUs Page Screen. It includes all the information about company'
          'history and progress. In this section you can find all details about the company'
          'This is aboutUs Page Screen. It includes all the information about company'
          'history and progress. In this section you can find all details about the company'
          'This is aboutUs Page Screen. It includes all the information about company'
          'history and progress. In this section you can find all details about the company'
          'This is aboutUs Page Screen. It includes all the information about company'
          'history and progress. In this section you can find all details about the company'
          'This is aboutUs Page Screen. It includes all the information about company'
          'history and progress. In this section you can find all details about the company',
          style: TextStyle(
            fontSize: _isMobileLayout ? 12.sp : 7.5.sp,
            fontFamily: FontConstants.sourceSansProRegular
            //fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
