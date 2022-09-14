import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_on_get_it/constants/app_images.dart';
import 'package:go_on_get_it/constants/font_constants.dart';
import 'package:go_on_get_it/constants/routes.dart';
import 'package:go_on_get_it/data/local/my_hive.dart';
import 'package:go_on_get_it/screens/favourite/favorite_controller.dart';
import 'package:go_on_get_it/screens/location/controller/main_controller.dart';
import 'package:go_on_get_it/screens/shopDetail/shop_detail_controller.dart';
import 'package:go_on_get_it/utils/utils.dart';
import 'package:go_on_get_it/widgets/back_arrow.dart';
import 'package:go_on_get_it/widgets/detail_row_widget.dart';
import 'package:go_on_get_it/widgets/report_issue.dart';
import 'package:sizer/sizer.dart';

import '/widgets/expire_damaged.dart';
import '/widgets/text_with_leaves.dart';

class NearToExpireShopSeeAll extends StatefulWidget {
  const NearToExpireShopSeeAll({Key? key}) : super(key: key);

  @override
  State<NearToExpireShopSeeAll> createState() => _NearToExpireShopSeeAllState();
}

class _NearToExpireShopSeeAllState extends State<NearToExpireShopSeeAll> {
  FavoriteController favoriteController = Get.isRegistered<FavoriteController>()
      ? Get.find<FavoriteController>()
      : Get.put(FavoriteController());
  final mainController = Get.find<MainController>();
  final SubSubCategoryController shopDetailController =
      Get.find<SubSubCategoryController>();
  bool isFav = false;
  int pageIndex = 0;
  late String id, url, title, address, phone;
  RxBool isLiked = false.obs;
  late bool isExpiredDiscount;
  late bool isAllExpired;

  @override
  void initState() {
    super.initState();
    if (Get.previousRoute == Routes.notificationScreen) {
      favoriteController.notificationIsSeen();
    }
    var seeAll = Get.arguments as Map;
    id = seeAll['item'].id.toString();
    url = '${Utils.BASE_URL}${seeAll['item'].shopLogo}';
    title = seeAll['item'].name ?? '';
    address = seeAll['item'].address ?? '';
    phone = seeAll['item'].phone ?? '';
    isLiked.value = seeAll['item'].isLiked == 1 ? true : false;
    isAllExpired = seeAll['isAllExpired'];
    isExpiredDiscount = MyHive.getExpiredDiscount();
    addShopClick();
  }

  void addShopClick() {
    Future.delayed(100.milliseconds,
        () => shopDetailController.addShopClick(int.parse(id)));
  }

  void addOfferClick(int offerId) {
    Future.delayed(
        100.milliseconds, () => shopDetailController.addOfferClick(offerId));
  }

  @override
  Widget build(BuildContext context) {
    var seeAllData = Get.arguments as Map;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool _isMobileLayout = shortestSide < 600;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 8.h,
        titleSpacing: -2.5.w,
        leading: BackArrow(sendDataBack: true),
        title: Row(
          children: [
            Container(
              margin: EdgeInsets.only(top: 2.h, bottom: 2.h, left: 2.w),
              child: isAllExpired
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: ColorFiltered(
                        colorFilter: const ColorFilter.mode(
                          Colors.grey,
                          BlendMode.saturation,
                        ),
                        child: CircleAvatar(
                          radius: _isMobileLayout ? 7.w : 4.5.w,
                          backgroundImage: CachedNetworkImageProvider(
                            url,
                          ),
                        ),
                      ),
                    )
                  : CircleAvatar(
                      radius: _isMobileLayout ? 7.w : 4.5.w,
                      backgroundImage: CachedNetworkImageProvider(
                        url,
                      ),
                    ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 2.5.w),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontFamily: FontConstants.sourceSansProSemiBold,
                        fontSize: _isMobileLayout ? 12.sp : 7.sp,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 2.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 1.h),
                          child: SvgPicture.asset(
                            AppImages.locationSvg,
                            height: 1.5.h,
                            width: 1.5.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: 0.6.h,
                        ),
                        Flexible(
                          child: Text(
                            address,
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: FontConstants.sourceSansProRegular,
                              fontSize: _isMobileLayout ? 9.sp : 5.5.sp,
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Obx(
              () => shopDetailController.isLoading.value
                  ? Container()
                  : Padding(
                      padding: EdgeInsets.only(right: 4.w),
                      child: SizedBox(
                        width: _isMobileLayout ? 20.w : 12.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                bool isFav = await favoriteController
                                    .favoriteShopDetailToggle(int.parse(id));
                                if (isFav == true) {
                                  isLiked.value = true;
                                } else {
                                  isLiked.value = false;
                                }
                                // String filterValue = '';
                                // switch(Get.arguments['filter']){
                                //   case 'trending':
                                //     filterValue = 'trending';
                                //     break;
                                //   case 'allNearMe':
                                //     filterValue = 'near_me';
                                //     break;
                                //   case 'throughItem':
                                //     filterValue = 'item';
                                //     break;
                                //   case 'throughShops':
                                //     filterValue = 'shop';
                                //     break;
                                //   default:
                                //     filterValue = 'catalog';
                                //     break;
                                // }
                                // shopDetailController.getShops(filter: filterValue, categoryId: Get.arguments['id'], showLoading: false);
                              },
                              child: Obx(
                                () => SvgPicture.asset(
                                  isLiked.value
                                      ? AppImages.greenHeart
                                      : AppImages.icUnFav,
                                  width: _isMobileLayout ? 3.h : 3.h,
                                  height: _isMobileLayout ? 3.h : 3.h,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Get.bottomSheet(
                                ReportIssue(),
                                enableDrag: false,
                                isScrollControlled: true,
                              ),
                              child: SvgPicture.asset(
                                AppImages.circularInformationIcon,
                                width: _isMobileLayout ? 3.h : 3.h,
                                height: _isMobileLayout ? 3.h : 3.h,
                                //height: 1.5.h,
                                //width: 1.5.h,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 4.w,
              right: 4.w,
              top: 4.h,
            ),
            child: Container(
              decoration: BoxDecoration(
                  color: const Color(0xFFF0F0F0),
                  borderRadius: BorderRadius.circular(0.5.w)),
              height: 5.h,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      detailRowWidget(
                          context: context, title: phone, isPhone: true),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: Container(
                          color: Colors.grey,
                          width: 0.2.w,
                        ),
                      ),
                      detailRowWidget(
                          context: context,
                          title: 'Shop Location',
                          data: {
                            'shop_id': int?.parse(id),
                            'location': seeAllData['location'],
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const TextWithLeaves(' Near to Expire/Damaged'),
          SizedBox(
            height: 1.h,
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(
                horizontal: 4.w,
              ),
              shrinkWrap: true,
              itemCount: seeAllData['item'].shopItems!.length,
              itemBuilder: (context, index) {
                return int.parse((seeAllData['item'].shopItems?[index].quantity)
                            .toString()) ==
                        0
                    ? SizedBox()
                    : GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            Routes.nearToExpireSubScreen,
                            arguments: {
                              'isAllExpired': isAllExpired,
                              'item': seeAllData['item'].shopItems?[index],
                              'location': seeAllData['location'],
                            },
                          );
                        },
                        child: ExpireDamagedCard(
                          id: seeAllData['item'].shopItems?[index].id,
                          title: seeAllData['item'].shopItems?[index].name,
                          imageUrl:
                              '${Utils.BASE_URL}${seeAllData['item'].shopItems?[index].imageUrl}',
                          quantity:
                              seeAllData['item'].shopItems?[index].quantity,
                          date: Utils.getDate(
                            seeAllData['item']
                                .shopItems![index]
                                .expiryDate
                                .toString(),
                          ),
                          time: Utils.getTime(
                            seeAllData['item']
                                .shopItems![index]
                                .expiryDate
                                .toString(),
                          ),
                          price: seeAllData['item'].shopItems?[index].price,
                        ),
                      );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: Platform.isIOS ? 0.5.h : 2.h,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
