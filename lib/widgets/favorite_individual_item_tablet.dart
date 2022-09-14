import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_on_get_it/constants/app_images.dart';
import 'package:go_on_get_it/constants/font_constants.dart';
import 'package:go_on_get_it/constants/routes.dart';
import 'package:go_on_get_it/screens/favourite/favorite_controller.dart';
import 'package:go_on_get_it/screens/shopDetail/shop_detail_controller.dart';
import 'package:go_on_get_it/utils/utils.dart';
import 'package:sizer/sizer.dart';

class FavoriteIndividualItemsForTab extends StatelessWidget {
  SubSubCategoryController shopDetailController =
      Get.find<SubSubCategoryController>();
  FavoriteController favoriteController = Get.find<FavoriteController>();

  final String title;
  final String iconUrl;
  final String address;
  final String contact;
  final String distance;
  final int position;
  final int? shopId;
  final RxBool? isLiked;
  String filter;
  String id;
  Map<String, dynamic> location;


  FavoriteIndividualItemsForTab({
    Key? key,
    required this.title,
    required this.iconUrl,
    required this.address,
    required this.contact,
    required this.distance,
    this.isLiked,
    required this.position,
    this.shopId,
    required this.filter,
    required this.id,
    required this.location
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    RxBool isFav = isLiked ?? false.obs;
    return Center(
      child: Card(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                    margin: EdgeInsets.only(left: 1.h, top: 1.h),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CachedNetworkImage(
                        height: 6.h,
                        width: 6.h,
                        fit: BoxFit.cover,
                        imageUrl: Utils.BASE_URL + iconUrl,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                        errorWidget: (context, url, error) => SizedBox(
                          height: Get.height,
                          width: Get.width,
                          child: Image.asset(
                            AppImages.macdonaldRect,
                            fit: BoxFit.cover,
                            height: 6.5.h,
                            width: 6.5.h,
                          ),
                        ),
                      ),
                    )),
                Container(
                  // width: 30.w,
                  margin: EdgeInsets.only(
                    top: 2.h,
                    left: 1.7.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 24.w,
                        child: Text(
                          title,
                          style: TextStyle(
                            fontFamily: FontConstants.sourceSansProSemiBold,
                            // fontWeight: FontWeight.bold,
                            fontSize: 7.sp,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 1.h),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/svgs/phone.svg',
                              height: 1.3.h,
                              width: 1.3.h,
                            ),
                            SizedBox(
                              width: 1.h,
                            ),
                            SizedBox(
                              width: 24.w,
                              child: Text(
                                contact,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily:
                                      FontConstants.sourceSansProRegular,
                                  fontSize: 5.5.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 1.h),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/svgs/location.svg',
                              height: 1.3.h,
                              width: 1.3.h,
                            ),
                            SizedBox(
                              width: 1.h,
                            ),
                            SizedBox(
                              width: 24.w,
                              child: Text(
                                address,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily:
                                      FontConstants.sourceSansProRegular,
                                  fontSize: 5.5.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                  () => Container(
                    alignment: Alignment.topCenter,
                    //height: 5.h,
                    padding: EdgeInsets.only(
                      top: 2.h,
                      bottom: 5.h,
                    ),
                    child: GestureDetector(
                      child: SvgPicture.asset(
                        isFav.value
                            ? 'assets/svgs/green_heart.svg'
                            : 'assets/svgs/ic_un_fav.svg',
                        height: 3.3.h,
                        width: 3.3.h,
                      ),
                      onTap: () async {
                        bool isShopSuccessfullyLiked = await favoriteController.favoriteToggle(shopId!);
                        if (isShopSuccessfullyLiked) {
                          isFav.value = !isFav.value;
                        }
                        String filterValue = '';
                        switch (filter) {
                          case 'trending':
                            filterValue = 'trending';
                            break;
                          case 'allNearMe':
                            filterValue = 'near_me';
                            break;
                          case 'throughItem':
                            filterValue = 'item';
                            break;
                          case 'throughShops':
                            filterValue = 'shop';
                            break;
                          default:
                            filterValue = 'catalog';
                            break;
                        }

                        if(filter != '') {
                          if(filterValue != 'item' && filterValue != 'shop') {
                            shopDetailController.getShops(filter: filterValue, categoryId: id, showLoading: false);
                          }
                        }else{
                          favoriteController.onInit();
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 1.5.h),
              child: InkWell(
                onTap: () {
                  Get.toNamed(Routes.shopLocation, arguments: {
                    'location': {
                      'lat':  location['lat'],
                      'long': location['long'],
                      'distanceInKm': location['distanceInKm'],
                    }
                  });
                },
                child: Container(
                  //height: 2.h,
                  alignment: Alignment.bottomRight,
                  margin: EdgeInsets.only(right: 2.w, bottom: 1.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          right: 1.5.w,
                        ),
                        child: SvgPicture.asset(
                          'assets/svgs/distance_icon.svg',
                          height: 1.3.h,
                          width: 1.3.h,
                        ),
                      ),
                      Text(
                        distance,
                        style: TextStyle(
                          fontSize: 5.5.sp,
                          color: Colors.green,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 1.5.w,),
                        child: SvgPicture.asset(
                          'assets/svgs/small_arrow_icon.svg',
                          height: 1.2.h,
                          width: 1.2.h,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
