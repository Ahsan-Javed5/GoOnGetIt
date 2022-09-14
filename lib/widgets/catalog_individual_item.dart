import 'dart:math' as math;
import 'dart:io' show Platform;


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_on_get_it/constants/app_images.dart';
import 'package:go_on_get_it/constants/text_styles.dart';
import 'package:sizer/sizer.dart';

class CatalogIndividualItem extends StatelessWidget {
  final String title;
  final String iconUrl;
  final String imageUrl;
  final String discount;
  final String noOfShops;

   const CatalogIndividualItem(
    this.title,
    this.imageUrl,
    this.discount,
    this.noOfShops,
  {Key? key, this.iconUrl = ''}
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool _isMobileLayout = shortestSide < 600;

    return Stack(
      children: [
        !_isMobileLayout
            ? SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(2.w),
                    child: Center(
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                        errorWidget: (context, url, error) => SizedBox(
                          height: Get.height,
                          width: Get.width,
                          child: Image.asset(
                            "assets/images/food_background.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),),)
            : ClipRRect(
                borderRadius: BorderRadius.circular(2.w),
                child: Center(
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                    errorWidget: (context, url, error) => SizedBox(
                      height: Get.height,
                      width: Get.width,
                      child: Image.asset(
                        "assets/images/food_background.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
        _isMobileLayout
            ? Image.asset("assets/images/ic_banner.png")
            : Image.asset(
                'assets/images/ic_banner_tab2.png',
                height: 7.h,),
        Positioned(
          left: 2.w,
          bottom: 4.h,
          child: SvgPicture.asset(iconUrl, height: 4.h,),
        ),
        _isMobileLayout ?
        Positioned(
          left: Platform.isAndroid ?  2.7.w : 2.7.w,
          top:  Platform.isAndroid ? 1.9.h : 1.5.h,
          child: Transform.rotate(
            angle: -math.pi / 4,
            child: Text(
              discount + "%",
              style: caption.copyWith(color: Colors.white,),
            ),
          ),
        ) :
        Positioned(
          left: 1.5.w,
          top: 1.7.h,
          child: Transform.rotate(
            angle: -math.pi / 4,
            child: Text(
              discount + "%",
              style: caption.copyWith(color: Colors.white, fontSize: 6.sp),
            ),
          ),
        ),
        Positioned(
          left: 2.w,
          bottom: 8.5.h,
          child: Text(
            title,
            style: TextStyle(
              fontSize: _isMobileLayout ? 14.sp : 10.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          left: 2.w,
          bottom: 2.h,
          child: Container(
            height: 3.5.h,
            width: 3.5.h,
            decoration: BoxDecoration(
              color: Colors.white38,
              borderRadius: BorderRadius.circular(0.1.h)
            ),
            child: Padding(
              padding:  EdgeInsets.all(0.5.h),
              child: CachedNetworkImage(
                imageUrl: iconUrl,
                placeholder: (context, url) => Center(
                  child: Container(),
                ),
                errorWidget: (context, url, error) => SizedBox(
                  child: Image.asset(
                    AppImages.macdonaldRect,

                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 2.w,
          bottom: 2.h,
          child: Container(
            height: 3.5.h,
            width: 3.5.h,
            decoration: BoxDecoration(
              color: Colors.white38,
              borderRadius: BorderRadius.circular(0.1.h)
            ),
            child: Padding(
              padding:  EdgeInsets.all(0.5.h),
              child: CachedNetworkImage(
                imageUrl: iconUrl,
                placeholder: (context, url) => Center(
                  child: Container(),
                ),
                errorWidget: (context, url, error) => SizedBox(
                  child: Image.asset(
                    AppImages.macdonaldRect,

                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 2.h,
          right: 2.w,
          child: Container(
            padding: EdgeInsets.all(1.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Text(
              noOfShops + "+ Shops",
              style: TextStyle(
                color: Colors.white,
                fontSize: _isMobileLayout ? 11.sp : 8.sp,
              ),
            ),
          ),
        )
      ],
    );
  }
}
