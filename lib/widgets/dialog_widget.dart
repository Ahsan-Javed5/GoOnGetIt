import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_on_get_it/constants/color_constants.dart';
import 'package:go_on_get_it/constants/font_constants.dart';
import 'package:sizer/sizer.dart';

Future<dynamic> dialogWidget({required BuildContext context, required String title}){
  var shortestSide = MediaQuery.of(context).size.shortestSide;
  final bool _isMobileLayout = shortestSide < 600;

  return Get.defaultDialog(
      title: '',
      content: Padding(
        padding: EdgeInsets.only(bottom: 2.h),
        child: Column(
          children: [
            Text(title,
              style: TextStyle(
                fontFamily: FontConstants.sourceSansProBold,
                fontSize: _isMobileLayout ? 12.sp : 7.sp,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 3.h,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.38,
              height: MediaQuery.of(context).size.height * 0.06,
              child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('Okay', style: TextStyle(
                    color: ColorConstants.whiteColor,
                    fontFamily: FontConstants.sourceSansProBold,
                    fontSize:  _isMobileLayout ? 12.sp : 7.sp,
                  ),)),
            ),
          ],
        ),
      )
  );
}