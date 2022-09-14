import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_on_get_it/constants/app_images.dart';
import 'package:go_on_get_it/constants/color_constants.dart';
import 'package:go_on_get_it/screens/location/controller/main_controller.dart';
import 'package:sizer/sizer.dart';

class ReportIssue extends StatelessWidget {
  ReportIssue({Key? key}) : super(key: key);
  final MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool _isMobileLayout = shortestSide < 600;

    return _isMobileLayout
        ? SingleChildScrollView(
        child: Container(
          height: 55.h,
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          decoration: BoxDecoration(
            color: ColorConstants.whiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4.h),
              topRight: Radius.circular(4.h),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                color: const Color(0xFFEAEAEA),
                height: 0.3.h,
                width: 23.w,
                margin: EdgeInsets.only(top: 1.h, bottom: 4.h),
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 1.w),
                    child: SvgPicture.asset(
                      AppImages.report,
                      height: 2.3.h,
                      width: 2.3.h,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 3.w, bottom: 0.5.h),
                    child: Text(
                      'Report an issue'.tr,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 2.5.h,
                  bottom: 1.h,
                  left: 1.w,
                  right: 1.w
                ),
                height: 7.h,
                child: TextFormField(
                  controller: mainController.emailController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                      top: 0.5.h,
                      left: 3.w,
                    ),
                    fillColor: Colors.transparent,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(1.w),
                      ),
                      borderSide: BorderSide(
                        width: 0.5.h,
                      ),
                    ),
                    hintText: 'emailAddress'.tr,
                    suffixIcon: GestureDetector(
                      onTap: () => mainController.emailController.clear(),
                      child: SvgPicture.asset(
                        AppImages.cancel,
                        height: 0.2.w,
                        width: 0.2.w,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.25,
                margin: EdgeInsets.only(bottom: 1.h, left: 1.w, right: 1.w),
                child: TextFormField(
                  controller: mainController.reportController,
                  maxLines: 7,
                  decoration: InputDecoration(
                    fillColor: Colors.transparent,
                    hintText: 'typeaReport'.tr,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(1.h),
                        ),
                        borderSide: BorderSide(
                          width: 0.5.w,
                        )),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        mainController.postReport();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: 1.7.h,
                          horizontal: 15.5.w,
                        ),
                      ),
                      child: Text(
                        'submit'.tr,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: 1.7.h,
                          horizontal: 15.5.w,
                        ),
                      ),
                      child: Text('cancel'.tr),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )
        : SingleChildScrollView(
      child: Container(
        height: 61.h,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          color: ColorConstants.whiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(_isMobileLayout ? 10 : 5.h),
            topRight: Radius.circular(_isMobileLayout ? 10 : 5.h),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: const Color(0xFFEAEAEA),
              height: 0.3.h,
              width: 23.w,
              margin: EdgeInsets.only(top: 1.h, bottom: 4.h),
            ),
            Padding(
              padding: EdgeInsets.only(left: _isMobileLayout ? 0.w : 3.w,),
              child: Row(
                children: [
                  SvgPicture.asset(
                    AppImages.report,
                    height: 2.3.h,
                    width: 2.3.h,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 3.w, bottom: 0.5.h),
                    child: Text(
                      'Report'.tr,
                      style: TextStyle(
                        fontSize: 9.5.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 4.h,
                bottom: 2.h,
              ),
              height: 6.h,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: TextFormField(
                  controller: mainController.emailController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                      top: _isMobileLayout ? 0.5.h : 2.h,
                      left: 3.w,
                    ),
                    fillColor: Colors.transparent,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(0.7.w),
                      ),
                      borderSide: BorderSide(
                        width: 0.5.h,
                      ),
                    ),
                    hintText: 'emailAddress'.tr,
                    hintStyle: TextStyle(
                      fontSize: 8.5.sp
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () => mainController.emailController.clear(),
                      child: SvgPicture.asset(
                        AppImages.cancel,
                        height: 0.2.w,
                        width: 0.2.w,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.25,
                margin: EdgeInsets.only(bottom: 5.h),
                child: TextFormField(
                  controller: mainController.reportController,
                  maxLines: _isMobileLayout ? 7 : 14,
                  decoration: InputDecoration(
                    fillColor: Colors.transparent,
                    hintText: 'typeaReport'.tr,
                    hintStyle: TextStyle(
                      fontSize: 8.5.sp
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(0.7.h),
                        ),
                        borderSide: BorderSide(
                          width: 0.5.w,
                        )),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.5.w),
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: ElevatedButton(
                      onPressed: () {
                        mainController.postReport();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: 1.3.h,
                          horizontal: 1.w,
                        ),
                      ),
                      child: Text(
                        'submit'.tr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8.5.sp
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 2.w),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: OutlinedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: 1.3.h,
                            horizontal: 1.w,
                          ),
                        ),
                        child: Text('cancel'.tr,
                          style: TextStyle(
                              fontSize: 8.5.sp
                          ),),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}