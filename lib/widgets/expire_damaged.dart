import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_on_get_it/constants/app_images.dart';
import 'package:go_on_get_it/constants/font_constants.dart';
import 'package:sizer/sizer.dart';

class ExpireDamagedCard extends StatelessWidget {
  const ExpireDamagedCard({
    Key? key,
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.quantity,
    this.isExpired,
    required this.date,
    required this.time,
    required this.price,
  }) : super(key: key);
  final int? id;
  final String? title;
  final String? imageUrl;
  final String? quantity;
  final String? price;
  final int? isExpired;
  final String? date;
  final String? time;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            height: 22.5.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.w),
                image: DecorationImage(
                    image: NetworkImage(imageUrl!), fit: BoxFit.cover)),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.w),
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.8),
                    const Color(0x002C2A2A),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: const [0.4, 1],
                ),
              ),
            )),
        Positioned(
            bottom: 1.5.h,
            left: 3.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title!,
                  style: TextStyle(
                    fontFamily: FontConstants.sourceSansProSemiBold,
                    fontSize: 13.sp,
                    color: Colors.white,
                  ),
                  strutStyle: StrutStyle(
                    height: 0.3.h,
                  ),
                ),
                Text(
                  '\$$price',
                  style: TextStyle(
                    fontFamily: FontConstants.sourceSansProSemiBold,
                    fontSize: 12.sp,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Quantity - $quantity'.tr,
                  style: TextStyle(
                    fontFamily: FontConstants.sourceSansProRegular,
                    fontSize: 11.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            )),
        Positioned(
            right: 3.5.w,
            bottom: 5.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      AppImages.clockIcon,
                      fit: BoxFit.cover,
                      height: 2.h,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      '$date',
                      style: TextStyle(
                        fontFamily: FontConstants.sourceSansProRegular,
                        fontSize: 10.sp,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Till $time'.tr,
                  style: TextStyle(
                    fontFamily: FontConstants.sourceSansProRegular,
                    fontSize: 10.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
