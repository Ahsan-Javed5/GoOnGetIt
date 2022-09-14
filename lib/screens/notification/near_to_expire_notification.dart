import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_on_get_it/constants/app_images.dart';
import 'package:go_on_get_it/constants/color_constants.dart';
import 'package:go_on_get_it/constants/font_constants.dart';
import 'package:go_on_get_it/constants/routes.dart';
import 'package:go_on_get_it/models/classes/notifications/notifications_list_data.dart';
import 'package:go_on_get_it/screens/favourite/favorite_controller.dart';
import 'package:go_on_get_it/screens/location/controller/main_controller.dart';
import 'package:go_on_get_it/screens/notification/notification_controller.dart';
import 'package:go_on_get_it/screens/shopDetail/shop_detail_controller.dart';
import 'package:go_on_get_it/utils/utils.dart';
import 'package:go_on_get_it/widgets/back_arrow.dart';
import 'package:go_on_get_it/widgets/detail_row_widget.dart';
import 'package:go_on_get_it/widgets/report_issue.dart';
import 'package:go_on_get_it/widgets/reserve_bottom_sheet.dart';
import 'package:sizer/sizer.dart';
import '/widgets/text_with_leaves.dart';

class NearToExpireNotification extends StatefulWidget {
  const NearToExpireNotification({Key? key}) : super(key: key);

  @override
  State<NearToExpireNotification> createState() =>
      _NearToExpireNotificationState();
}

class _NearToExpireNotificationState extends State<NearToExpireNotification> {
  FavoriteController favoriteController = Get.isRegistered<FavoriteController>()
      ? Get.find<FavoriteController>()
      : Get.put(FavoriteController());
  final NotificationController notificationController =
      Get.find<NotificationController>();
  final shopDetailController = Get.find<SubSubCategoryController>();
  final mainController = Get.find<MainController>();
  bool isFav = false;
  late int id, itemId;
  late String url,
      title,
      address,
      phone,
      name,
      quantity,
      price,
      imageUrl,
      date,
      time,
      lat,
      long,
      distanceInKm;
  RxBool isLiked = false.obs;
  late bool isExpiredDiscount;
  bool isAllExpired = true;
  RxBool isLoading = false.obs;

  @override
  void initState() {
    if (Get.previousRoute == Routes.notificationScreen) {
      favoriteController.notificationIsSeen();
    }
    var shopData = Get.arguments as NotificationDataRows;
    for (int i = 0; i < shopData.shopOwner!.shopItems!.length; i++) {
      if (shopData.shopOwner!.shopItems![i].id == shopData.itemId) {
        notificationController.itemDetail = shopData.shopOwner!.shopItems![i];
      }
    }
    id = shopData.shopId!;
    itemId = shopData.itemId!;
    lat = shopData.shopOwner!.lat!;
    long = shopData.shopOwner!.long!;
    url = '${Utils.BASE_URL}${shopData.shopOwner!.shopLogo}';
    title = shopData.shopOwner!.name!;
    address = shopData.shopOwner!.address!;
    phone = shopData.shopOwner!.phone!;
    name = notificationController.itemDetail.name!;
    price = notificationController.itemDetail.price!;
    quantity = notificationController.itemDetail.quantity!;
    date =
        Utils.getDate(notificationController.itemDetail.expiryDate as String);
    time =
        Utils.getTime(notificationController.itemDetail.expiryDate as String);
    imageUrl = '${Utils.BASE_URL}${notificationController.itemDetail.imageUrl}';
    // offers = Get.arguments["offers"];
    isLiked.value = shopData.shopOwner?.isLiked == 1 ? true : false;
    // isExpiredDiscount = MyHive.getExpiredDiscount();
    addShopClick(shopData.shopOwner?.id);
    isLoading.value = false;
    // for (var offers in offers) {
    //   if (offers.isExpired == 0) {
    //     isAllExpired = false;
    //   }
    // }
    super.initState();
  }

  void addShopClick(int? id) {
    Future.delayed(
        100.milliseconds, () => shopDetailController.addShopClick(id!));
  }

  void addOfferClick(int offerId) {
    Future.delayed(
        100.milliseconds, () => shopDetailController.addOfferClick(offerId));
  }

  @override
  Widget build(BuildContext context) {
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
              child: CircleAvatar(
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
                                    .favoriteShopDetailToggle(id);
                                if (isFav == true) {
                                  isLiked.value = true;
                                } else {
                                  isLiked.value = false;
                                }
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
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 4.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 3.h,
              ),
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
                            'shop_id': id,
                            'location': {
                              'lat': lat,
                              'long': long,
                            }
                          }),
                    ],
                  ),
                ),
              ),
            ),
            const TextWithLeaves('Near To Expire/Damaged'),
            Container(
              margin: EdgeInsets.only(
                top: 1.h,
              ),
              height: 35.h,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  4.w,
                ),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        color: ColorConstants.blackShade,
                        fontSize: 14.5.sp,
                        fontFamily: FontConstants.sourceSansProSemiBold,
                      ),
                    ),
                    Text(
                      '\$${price}',
                      style: TextStyle(
                        color: ColorConstants.blackShade,
                        fontSize: 11.sp,
                        fontFamily: FontConstants.sourceSansProSemiBold,
                      ),
                    ),
                    Text(
                      'Quantity - ${quantity}',
                      style: TextStyle(
                        color: ColorConstants.blackShade,
                        fontSize: 11.sp,
                        fontFamily: FontConstants.sourceSansProRegular,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppImages.clockIconWhiteTick,
                          fit: BoxFit.cover,
                          height: 2.h,
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(
                          '$date',
                          style: TextStyle(
                            fontFamily: FontConstants.sourceSansProBold,
                            fontSize: 9.5.sp,
                            color: ColorConstants.blackShade,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Till $time'.tr,
                      style: TextStyle(
                        fontFamily: FontConstants.sourceSansProBold,
                        fontSize: 9.5.sp,
                        color: ColorConstants.blackShade,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 4.h,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.bottomSheet(
                    ReserveBottomDialog(
                      shopData: {
                        'name': name,
                        'quantity': quantity,
                        'price': price,
                        'id': itemId,
                      },
                    ),
                    enableDrag: false,
                    isScrollControlled: true,
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    vertical: 1.5.h,
                  ),
                ),
                child: Text(
                  'Reserve'.tr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: FontConstants.sourceSansProRegular,
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
