import 'package:flutter/material.dart';
import 'package:go_on_get_it/constants/color_constants.dart';
import 'package:go_on_get_it/constants/font_constants.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import 'back_arrow.dart';

class FavoriteListShimmer extends StatelessWidget {
  const FavoriteListShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool _isMobileLayout = shortestSide < 600;

    int offset = 0;
    int time = 800;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _isMobileLayout
          ? AppBar(
        leading: BackArrow(),
        title: Align(
          alignment: Alignment.centerLeft,
          child: Transform(
            transform: Matrix4.translationValues(-10, 6.0, 0.0),
            child: Text(
              'Favorites'.tr,
              style: TextStyle(
                fontFamily: FontConstants.sourceSansProSemiBold,
                color: Colors.black,
                fontSize: 15.sp,
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
            child: Padding(
              padding: EdgeInsets.only(left: 1.w),
              child: Text(
                'Favourite List'.tr,
                style: TextStyle(
                  fontFamily: FontConstants.sourceSansProSemiBold,
                  color: Colors.black,
                  fontSize: 10.sp,
                ),
              ),
            ),
          ),
        ),
        titleSpacing: 0.7.w,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0,
            width: MediaQuery.of(context).size.width * 0.96,
            //color: ColorConstants.gray,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(0.8.h),
              child: ListView.builder(
                itemCount: 8,
                itemBuilder: (context, index) {
                  offset += 5;
                  time = 800 + offset;
                  return Shimmer.fromColors(
                    baseColor: ColorConstants.gray,
                    highlightColor: ColorConstants.whiteColor,
                    period: Duration(milliseconds: time),
                    child: Center(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 12.h,
                                width: 12.w,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorConstants.gray,
                                ),
                                margin: EdgeInsets.only(
                                  left: 3.w,
                                ),
                              ),
                              Container(
                                width: 65.w,
                                margin: EdgeInsets.only(
                                  left: 3.w,
                                ),
                                padding: EdgeInsets.all(
                                  2.w,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    //title
                                    Container(
                                      height: 3.h,
                                      width: 58.w,
                                      color: ColorConstants.gray,
                                    ),
                                    Container(
                                        height: 1.5.h,
                                        width: 40.w,
                                        color: ColorConstants.gray,
                                        margin: EdgeInsets.symmetric(
                                          vertical: 0.5.h,
                                        )),
                                    Container(
                                      height: 1.5.h,
                                      width: 40.w,
                                      color: ColorConstants.gray,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                //alignment: Alignment.topCenter,
                                height: 4.h,
                                width: 4.h,
                                margin: EdgeInsets.only(
                                  bottom: 4.h,
                                ),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorConstants.gray,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
