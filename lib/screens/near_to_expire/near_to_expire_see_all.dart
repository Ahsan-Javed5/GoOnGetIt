import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_on_get_it/constants/app_images.dart';
import 'package:go_on_get_it/constants/routes.dart';
import 'package:go_on_get_it/utils/utils.dart';
import 'package:go_on_get_it/widgets/expire_damaged.dart';
import 'package:sizer/sizer.dart';
import '/constants/font_constants.dart';
import '/widgets/back_arrow.dart';

class NearToExpireSeeAll extends StatelessWidget {
  const NearToExpireSeeAll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var seeAllNearExpires = Get.arguments as dynamic;
    return Scaffold(
      appBar: AppBar(
        leading: BackArrow(),
        title: Transform(
          transform: Matrix4.translationValues(-8, 6.0, 0.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Transform(
              transform: Matrix4.translationValues(-16, 0.0, 0.0),
              child: Text(
                'Near To Expire/Damaged'.tr,
                style: TextStyle(
                  fontFamily: FontConstants.sourceSansProSemiBold,
                  color: Colors.black,
                  fontSize: 15.sp,
                ),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 2.h,
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(
                horizontal: 4.w,
              ),
              shrinkWrap: true,
              itemCount: seeAllNearExpires['item'].length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(
                      Routes.nearToExpireSubScreen,
                      arguments: {
                        'isAllExpired': seeAllNearExpires['isAllExpired'],
                        'item': seeAllNearExpires['item'][index],
                        'location': {
                          'lat': seeAllNearExpires['item'][index]
                              .shopOwner
                              .lat
                              .toString(),
                          'long': seeAllNearExpires['item'][index]
                              .shopOwner
                              .long
                              .toString(),
                          'distanceInKm': seeAllNearExpires['item'][index]
                              .shopOwner
                              .distanceKm
                              .toString()
                        },
                      },
                    );
                  },
                  child: ExpireDamagedCard(
                    id: seeAllNearExpires['item'][index].id,
                    title: seeAllNearExpires['item'][index].name,
                    imageUrl:
                        '${Utils.BASE_URL}${seeAllNearExpires['item'][index].imageUrl}',
                    quantity: seeAllNearExpires['item'][index].quantity,
                    isExpired: seeAllNearExpires['item'][index].isExpired,
                    date: Utils.getDate(
                      seeAllNearExpires['item'][index].expiryDate,
                    ),
                    time: Utils.getTime(
                        seeAllNearExpires['item'][index].expiryDate),
                    price: seeAllNearExpires['item'][index].price,
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 2.h,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
