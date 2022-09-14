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
import 'package:go_on_get_it/widgets/back_arrow.dart';
import 'package:go_on_get_it/widgets/detail_row_widget.dart';
import 'package:go_on_get_it/widgets/report_issue.dart';
import 'package:go_on_get_it/widgets/reserve_bottom_sheet.dart';
import 'package:sizer/sizer.dart';
import '/widgets/text_with_leaves.dart';

class NearToExpireSubScreen extends StatefulWidget {
  const NearToExpireSubScreen({Key? key}) : super(key: key);

  @override
  State<NearToExpireSubScreen> createState() => _NearToExpireSubScreenState();
}

class _NearToExpireSubScreenState extends State<NearToExpireSubScreen> {
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
  late Map location;
  late bool isExpiredDiscount;
  bool isAllExpired = true;
  RxBool isLoading = false.obs;
  late FavoriteController favoriteController;
  @override
  void initState() {
    super.initState();
    favoriteController = Get.isRegistered<FavoriteController>()
        ? Get.find<FavoriteController>()
        : Get.put(FavoriteController());
    if (Get.previousRoute == Routes.notificationScreen) {
      favoriteController.notificationIsSeen();
    }
    var shopDataList = Get.arguments as dynamic;
    id = shopDataList['item'].shopId;
    itemId = shopDataList['item'].id;
    lat = mainController.isShopNearToExpire.value
        ? shopDetailController.nearToExpire?.rows?.lat
        : shopDataList['item'].shopOwner?.lat;
    long = mainController.isShopNearToExpire.value
        ? shopDetailController.nearToExpire?.rows?.long
        : shopDataList['item'].shopOwner?.long;
    location = shopDataList['location'];
    url =
        '${Utils.BASE_URL}${mainController.isShopNearToExpire.value ? shopDetailController.nearToExpire?.rows?.shopLogo : shopDataList['item'].shopOwner?.shopLogo}';
    title = mainController.isShopNearToExpire.value
        ? shopDetailController.nearToExpire?.rows?.name
        : shopDataList['item'].shopOwner?.name ?? '';
    address = mainController.isShopNearToExpire.value
        ? shopDetailController.nearToExpire?.rows?.address
        : shopDataList['item'].shopOwner?.address ?? '';
    phone = mainController.isShopNearToExpire.value
        ? shopDetailController.nearToExpire?.rows?.phone
        : shopDataList['item'].shopOwner?.phone ?? '';
    name = mainController.isShopNearToExpire.value
        ? shopDataList['item'].name
        : shopDataList['item'].name;
    price = mainController.isShopNearToExpire.value
        ? shopDataList['item'].price
        : shopDataList['item'].price;
    quantity = mainController.isShopNearToExpire.value
        ? shopDataList['item'].quantity
        : shopDataList['item'].quantity;
    date = Utils.getDate(shopDataList['item'].expiryDate as String);
    time = Utils.getTime(shopDataList['item'].expiryDate as String);
    imageUrl =
        '${Utils.BASE_URL}${mainController.isShopNearToExpire.value ? shopDataList['item'].imageUrl : shopDataList['item'].imageUrl}';
    // offers = Get.arguments["offers"];
    isLiked.value = mainController.isShopNearToExpire.value
        ? shopDetailController.nearToExpire?.rows?.isLiked == 1
            ? true
            : false
        : shopDataList['item'].shopOwner?.isLiked == 1
            ? true
            : false;
    isAllExpired = shopDataList['isAllExpired'];
    // isExpiredDiscount = MyHive.getExpiredDiscount();
    addShopClick(shopDetailController.nearToExpire?.rows?.id);
    isLoading.value = false;
    // for (var offers in offers) {
    //   if (offers.isExpired == 0) {
    //     isAllExpired = false;
    //   }
    // }
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
                            'location': location,
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
