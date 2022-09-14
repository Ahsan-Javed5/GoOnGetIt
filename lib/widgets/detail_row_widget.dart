import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_on_get_it/constants/app_images.dart';
import 'package:go_on_get_it/constants/font_constants.dart';
import 'package:go_on_get_it/constants/routes.dart';
import 'package:sizer/sizer.dart';

import 'dialog_widget.dart';

Widget detailRowWidget({required BuildContext context, bool isPhone = false, required String title, dynamic data}){
  var shortestSide = MediaQuery.of(context).size.shortestSide;
  final bool _isMobileLayout = shortestSide < 600;
  return  InkWell(
    onTap: () async {
      if(isPhone){
        try {
          String number = title.toString();
          if (number == '') {
            dialogWidget(title: 'No Phone Number Found', context: context);
          }
          else {
            await FlutterPhoneDirectCaller.callNumber(number);
          }
        }catch(e){
          log("Error thrown: ${e.toString()}");
        }
      }else{
        if (data['location']['lat'] == '') {
          dialogWidget(title: 'No Shop Location Found', context: context);
        }else {
          Get.toNamed(Routes.shopLocation, arguments: data);
        }
      }
    },
    child: Row(
      children: [
        SvgPicture.asset(
          isPhone ? AppImages.phone : AppImages.circularDistanceIcon,
          height: 1.9.h,
          width: 1.9.h,
        ),
        SizedBox(
          width: 1.h,
        ),
        SizedBox(
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily:
              FontConstants.sourceSansProRegular,
              fontSize: _isMobileLayout ? 10.sp : 6.sp,
            ),
          ),
        ),
      ],
    ),
  );
}