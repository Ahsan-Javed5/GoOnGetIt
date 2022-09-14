import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_on_get_it/constants/color_constants.dart';
import 'package:go_on_get_it/constants/font_constants.dart';
import 'package:go_on_get_it/data/local/my_hive.dart';
import 'package:go_on_get_it/screens/location/controller/main_controller.dart';
import 'package:sizer/sizer.dart';

class BottomDialogue extends StatelessWidget {
   BottomDialogue({Key? key}) : super(key: key);

  // Controllers
  final MainController mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool _isMobileLayout = shortestSide < 600;

    return AlertDialog(
      contentPadding: EdgeInsets.fromLTRB(5.w, 1.h, 5.w, 5.h),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              color: const Color(0xFFEAEAEA),
              height: 0.3.h,
              width: 23.w,
            ),
            Image.asset(
              'assets/images/bell.png',
              width: _isMobileLayout ? 16.h : 12.h,
              height: _isMobileLayout ? 16.h : 12.h,
            ),
            Text(
              'expiredDiscountOffer'.tr,
              style: TextStyle(
                fontSize: _isMobileLayout ? 18.sp : 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 2.5.h),
              child: Text(
                'discount'.tr,
                style: TextStyle(
                  fontSize: _isMobileLayout ? 13.sp : 8.sp,
                ),
              ),
            ),
            _isMobileLayout ?
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  child: ElevatedButton(
                    onPressed: () {
                      MyHive.setExpiredDiscount(isExpiredDiscount: true);
                      mainController.isDiscountOffer();
                    },
                    child: Text(
                      'Yes'.tr,
                      style: const TextStyle(
                        color: ColorConstants.whiteColor,
                        fontFamily: FontConstants.sourceSansProRegular,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 3.w,
                ),
                OutlinedButton(
                  onPressed: () {
                    MyHive.setExpiredDiscount(isExpiredDiscount: false);
                    mainController.isDiscountOffer();
                  },
                  child: Text(
                    'No'.tr,
                    style: const TextStyle(
                      color: ColorConstants.appBlack,
                      fontFamily: FontConstants.sourceSansProRegular,
                    ),
                  ),
                ),
              ],
            ) :
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.32,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: ElevatedButton(
                    onPressed: () {
                      MyHive.setExpiredDiscount(isExpiredDiscount: true);
                      mainController.isDiscountOffer();
                    },
                    child: Text(
                      'Yes'.tr,
                      style: TextStyle(
                        color: ColorConstants.whiteColor,
                        fontFamily: FontConstants.sourceSansProRegular,
                        fontSize: 9.sp
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 4.w,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.32,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: OutlinedButton(
                    onPressed: () {
                      MyHive.setExpiredDiscount(isExpiredDiscount: false);
                      mainController.isDiscountOffer();
                    },
                    child: Text(
                      'No'.tr,
                      style: TextStyle(
                        color: ColorConstants.appBlack,
                        fontFamily: FontConstants.sourceSansProRegular,
                        fontSize: 9.sp
                      ),
                    ),
                  ),
                ),
              ],
            ) ,
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
    );
  }

}
