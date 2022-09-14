import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_on_get_it/constants/app_images.dart';
import 'package:go_on_get_it/constants/color_constants.dart';
import 'package:go_on_get_it/constants/font_constants.dart';
import 'package:go_on_get_it/constants/routes.dart';
import 'package:go_on_get_it/screens/favourite/favorite_controller.dart';
import 'package:go_on_get_it/screens/location/controller/main_controller.dart';
import 'package:go_on_get_it/screens/shopDetail/shop_detail_controller.dart';
import 'package:go_on_get_it/utils/utils.dart';
import 'package:sizer/sizer.dart';

class FavoriteIndividualItemForMobile extends StatelessWidget {
  SubSubCategoryController shopDetailController = Get.find<SubSubCategoryController>();
  FavoriteController favoriteController = Get.find<FavoriteController>();
  final MainController mainController = Get.find<MainController>();



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

  FavoriteIndividualItemForMobile({
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
                    // color: Colors.red,
                    margin: EdgeInsets.only(
                      left: 3.w,
                      top: 3.h,
                    ),
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
                            height: 4.h,
                            width: 4.h,
                          ),
                        ),
                      ),
                    )),
                Container(
                  width: 62.5.w,
                  margin: EdgeInsets.only(
                    top: 2.h,
                    left: 3.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: FontConstants.sourceSansProSemiBold,
                            // fontWeight: FontWeight.bold,
                            fontSize: 13.sp,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.all(0.7.h),
                            child: SvgPicture.asset(
                              'assets/svgs/phone.svg',
                              height: 1.5.h,
                              width: 1.5.h,
                            ),
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              contact,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: FontConstants.sourceSansProRegular,
                                fontSize: 10.5.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 0.3.h,
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.all(0.4.h),
                            child: SvgPicture.asset(
                              'assets/svgs/location.svg',
                              height: 1.5.h,
                              width: 1.5.h,
                            ),
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              address,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: FontConstants.sourceSansProRegular,
                                fontSize: 10.5.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Obx(
                  () => Container(
                    alignment: Alignment.topCenter,
                    //height: 5.h,
                    padding: EdgeInsets.only(bottom: 5.h, right: 1.w, top: 1.h),
                    child: InkWell(
                      splashColor: ColorConstants.parrotDark,
                      highlightColor: ColorConstants.parrotDark,
                      child: SvgPicture.asset(
                        isFav.value
                            ? 'assets/svgs/green_heart.svg'
                            : 'assets/svgs/ic_un_fav.svg',
                        height: 4.h,
                        width: 4.h,
                      ),
                      onTap: () async {
                        bool isShopSuccessfullyLiked = await favoriteController.favoriteToggle(shopId!);
                        if (isShopSuccessfullyLiked) {
                          isFav.value = !isFav.value;
                        }
                        if(filter != '') {
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
                          if(filterValue != 'item' && filterValue != 'shop') {
                            shopDetailController.getShops(filter: filterValue, categoryId: id, showLoading: false);
                          }else{
                          }
                        }
                        else{
                          favoriteController.favoriteSearchedList.clear();
                          favoriteController.onInit();
                        }
                      },
                    ),
                  ),
                )
              ],
            ),

            ///for moving to shop Location
            InkWell(
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
                margin: EdgeInsets.only(right: 2.w, bottom: 1.5.h, top: 1.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        right: 1.5.w,
                      ),
                      child: SvgPicture.asset(
                        'assets/svgs/distance_icon.svg',
                        height: 1.7.h,
                        width: 1.7.h,
                      ),
                    ),
                    Text(
                      distance,
                      style: TextStyle(
                        fontSize: 9.sp,
                        color: Colors.green,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 1.5.w,
                      ),
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
          ],
        ),
      ),
    );
  }
}

