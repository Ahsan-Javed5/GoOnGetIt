import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_on_get_it/constants/app_images.dart';
import 'package:go_on_get_it/constants/color_constants.dart';
import 'package:go_on_get_it/constants/font_constants.dart';
import 'package:go_on_get_it/screens/favourite/favorite_controller.dart';
import 'package:go_on_get_it/utils/utils.dart';
import 'package:sizer/sizer.dart';

class NotificationIndividualItem extends StatelessWidget {
  final String title;
  final String description;
  final String iconUrl;
  final int noOfNotifications;

  NotificationIndividualItem(
    this.title,
    this.description,
    this.iconUrl,
    this.noOfNotifications,
  );

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool _isMobileLayout = shortestSide < 600;
    final FavoriteController _favoriteController = Get.put(FavoriteController());
    return Center(
      child: Container(
        margin: EdgeInsets.only(bottom: 1.h),
        child: Card(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  padding: EdgeInsets.only(
                    top: 2.h, left: 2.h, right: 2.h, bottom: 2.h
                    //left: 5,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.w),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      height: 7.h,
                      width: 7.h,
                      imageUrl: Utils.BASE_URL + iconUrl,
                      placeholder: (context, url) => Image.asset(
                        AppImages.betaRect,
                        fit: BoxFit.cover,
                        height: 7.h,
                        width: 7.h,
                      ),
                      errorWidget: (context, url, error) =>
                          SizedBox(
                            child: Image.asset(
                              AppImages.macdonaldRect,
                              fit: BoxFit.cover,
                              height: 7.h,
                              width: 7.h,
                            ),
                          ),
                    ),
                  )
              ),
              Expanded(
                child: Container(
                  height: _isMobileLayout ? 9.h : 10.h,
                  margin: EdgeInsets.only(
                    bottom: 1.h,
                    //left: 5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontFamily: FontConstants.sourceSansProSemiBold,
                          fontSize: _isMobileLayout ? 14.sp : 9.sp,
                        ),
                      ),
                      Text(
                        description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(
                          fontFamily: FontConstants.sourceSansProRegular,
                          fontSize: _isMobileLayout ? 12.sp : 7.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: 3.w,
                ),
                child: Container(
                  height: 3.h,
                  width: 3.h,
                  //margin: const EdgeInsets.all(100.0),
                  decoration: const BoxDecoration(
                      color: ColorConstants.parrotGreen, shape: BoxShape.circle),
                  child: Center(
                    child: Text(
                      '$noOfNotifications',
                      style: TextStyle(
                        color: ColorConstants.whiteColor,
                        fontFamily: FontConstants.sourceSansProRegular,
                        fontSize: _isMobileLayout ? 11.sp : 7.sp
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
