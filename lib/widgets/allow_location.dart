import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_on_get_it/constants/color_constants.dart';
import 'package:go_on_get_it/constants/font_constants.dart';
import 'package:go_on_get_it/constants/routes.dart';
import 'package:go_on_get_it/screens/location/controller/main_controller.dart';
import 'package:go_on_get_it/widgets/bottom_dialogue.dart';
import 'package:sizer/sizer.dart';

class AllowLocation extends StatelessWidget {
  const AllowLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.find<MainController>();
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool _isMobileLayout = shortestSide < 600;

    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        //title: const Text("Alert Dialog"),
        contentPadding: EdgeInsets.fromLTRB(5.w, 1.h, 5.w, 5.h),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.23,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                color: const Color(0xFFEAEAEA),
                height: 0.3.h,
                width: 23.w,
              ),
              Text(
                'allowLocation'.tr,
                style: TextStyle(
                  fontSize: _isMobileLayout ? 18.sp : 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 3.h),
                child: Text(
                  'permission'.tr,
                  style: TextStyle(
                    fontSize: _isMobileLayout ? 13.sp : 09.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _isMobileLayout ?
                      Obx(() => SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: ElevatedButton(
                          onPressed:  mainController.isLocationFetchedLoading.value
                              ? null
                              : () async {
                            await mainController.determinePosition();
                            Get.back();
                            Get.dialog(
                              BottomDialogue(),
                              barrierDismissible: false,
                            );
                          },
                          child: mainController.isLocationFetchedLoading.value
                              ? Platform.isAndroid
                              ? Center(child: SizedBox(
                              height: 2.h,
                              width: 2.h,
                              child: const CircularProgressIndicator.adaptive(valueColor: AlwaysStoppedAnimation<Color>(Colors.white), )))
                             : const Center(child: CircularProgressIndicator.adaptive(valueColor: AlwaysStoppedAnimation<Color>(Colors.white),),)
                              :  Text(
                            'currentLocation'.tr,
                            style: TextStyle(
                              color: ColorConstants.whiteColor,
                              fontFamily: FontConstants.sourceSansProRegular,
                              fontSize: 13.sp ,
                            ),
                          ),
                        ),
                      ),
                      ) :
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.32,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: Obx(() =>  ElevatedButton(
                          onPressed: mainController.isLocationFetchedLoading.value
                              ? null
                              : () async {
                            await mainController.determinePosition();
                            Get.back();
                            Get.dialog(
                              BottomDialogue(),
                              barrierDismissible: false,
                            );
                          },
                          child: mainController.isLocationFetchedLoading.value
                              ? const Center(child: CircularProgressIndicator.adaptive(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)))
                              :  Text(
                            'currentLocation'.tr,
                            style: TextStyle(
                              color: ColorConstants.whiteColor,
                              fontFamily: FontConstants.sourceSansProRegular,
                              fontSize:  9.sp,
                            ),
                          ),
                        ),),
                      ),

                      SizedBox(
                        width: 3.w,
                      ),
                      _isMobileLayout ?
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: Obx(() => OutlinedButton(
                          onPressed: mainController.isLocationFetchedLoading.value
                              ? null
                              :  () {
                            Get.back();
                            Get.toNamed(Routes.locationScreen);
                          },
                          child: Text(
                            'otherLocation'.tr,
                            style: TextStyle(
                              color: ColorConstants.appBlack,
                              fontFamily: FontConstants.sourceSansProRegular,
                              fontSize: 13.sp,
                            ),
                          ),
                        ),)
                      ) :
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.32,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: Obx(() =>  OutlinedButton(
                          onPressed: mainController.isLocationFetchedLoading.value
                              ? null
                              : () {
                            Get.back();
                            Get.toNamed(Routes.locationScreen);
                          },
                          child: Text(
                            'otherLocation'.tr,
                            style: TextStyle(
                              color: ColorConstants.appBlack,
                              fontFamily: FontConstants.sourceSansProRegular,
                              fontSize: 9.sp,
                            ),
                          ),
                        ),)
                      )
                      ,
                    ],
                  ),
            ],
          ),
        ),
        alignment: Alignment.bottomCenter,
        insetPadding: const EdgeInsets.all(0.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(3.h),
            topRight: Radius.circular(3.h),
          ),
        ),
      ),
    );
  }
}
