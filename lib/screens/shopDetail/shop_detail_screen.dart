import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_on_get_it/constants/app_images.dart';
import 'package:go_on_get_it/constants/color_constants.dart';
import 'package:go_on_get_it/constants/font_constants.dart';
import 'package:go_on_get_it/constants/routes.dart';
import 'package:go_on_get_it/constants/text_styles.dart';
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

class ShopDetailScreen extends StatefulWidget {
  const ShopDetailScreen({Key? key}) : super(key: key);

  @override
  State<ShopDetailScreen> createState() => _ShopDetailScreenState();
}

class _ShopDetailScreenState extends State<ShopDetailScreen> {
  FavoriteController favoriteController = Get.isRegistered<FavoriteController>()
      ? Get.find<FavoriteController>()
      : Get.put(FavoriteController());
  final mainController = Get.find<MainController>();
  final SubSubCategoryController shopDetailController =
      Get.find<SubSubCategoryController>();
  bool isFav = false;
  int pageIndex = 0;
  late String url, title, address, phone;
  late int id;
  RxBool isLiked = false.obs;
  List offers = [];
  late bool isExpiredDiscount;
  bool isAllExpired = true;

  @override
  void initState() {
    super.initState();
    if (Get.previousRoute == Routes.notificationScreen) {
      favoriteController.notificationIsSeen();
    }
    id = Get.arguments['shop_id'];
    print(id);
    url = Get.arguments['iconUrl'] ?? '';
    title = Get.arguments['title'] ?? '';
    address = Get.arguments['address'] ?? '';
    phone = Get.arguments['phone'] ?? '';
    offers = Get.arguments["offers"];
    isLiked = Get.arguments["isLiked"];
    isExpiredDiscount = MyHive.getExpiredDiscount();
    addShopClick();
    if (offers.isEmpty) {
      isAllExpired = false;
    } else {
      for (var offer in offers) {
        if (offer.isExpired == 0) {
          isAllExpired = false;
        }
      }
    }
  }

  void addShopClick() {
    Future.delayed(100.milliseconds,
        () => shopDetailController.addShopClick(Get.arguments['shop_id']));
  }

  void addOfferClick(int offerId) {
    Future.delayed(
        100.milliseconds, () => shopDetailController.addOfferClick(offerId));
  }

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool _isMobileLayout = shortestSide < 600;
    PageController _pageController = PageController(
      initialPage: pageIndex,
    );
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
              child: isExpiredDiscount
                  ? isAllExpired
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
                      // offers['name'],
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
                            // offers['address'],
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
                                    .favoriteShopDetailToggle(
                                        Get.arguments['shop_id']);
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ///shop contact and location section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
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
                              'shop_id': Get.arguments['shop_id'],
                              'location': Get.arguments['location'],
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            ///show banners
            offers.isEmpty
                ? SizedBox()
                : Container(
                    height: 57.h,
                    padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 1.h),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        3.w,
                      ),
                      child: Stack(
                        children: [
                          ///if offers in not null it will show banners
                          ///ternary operator used
                          offers != null
                              ? PageView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  onPageChanged: _onPageChanged,
                                  itemCount: offers.length,
                                  controller: _pageController,
                                  itemBuilder: (context, index) {
                                    addOfferClick(offers[index].id);
                                    return FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: isExpiredDiscount
                                          ? ColorFiltered(
                                              colorFilter:
                                                  offers[index].isExpired == 1
                                                      ? const ColorFilter.mode(
                                                          Colors.white,
                                                          BlendMode.saturation,
                                                        )
                                                      : const ColorFilter.mode(
                                                          Colors.transparent,
                                                          BlendMode.multiply,
                                                        ),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl: Utils.BASE_URL +
                                                    offers[index].bannerImage!,
                                                placeholder: (context, url) =>
                                                    Transform.scale(
                                                        scale: 0.1,
                                                        child: const ColorFiltered(
                                                            colorFilter:
                                                                ColorFilter.mode(
                                                                    Colors
                                                                        .white,
                                                                    BlendMode
                                                                        .multiply),
                                                            child:
                                                                CircularProgressIndicator
                                                                    .adaptive())),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Transform.scale(
                                                  scale: 0.1,
                                                  child: const ColorFiltered(
                                                    colorFilter:
                                                        ColorFilter.mode(
                                                            Colors.white,
                                                            BlendMode.multiply),
                                                    child: Icon(
                                                      Icons.error,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : offers[index].isExpired != 1
                                              ? CachedNetworkImage(
                                                  fit: BoxFit.fill,
                                                  imageUrl: Utils.BASE_URL +
                                                      offers[index]
                                                          .bannerImage!,
                                                  placeholder: (context, url) =>
                                                      Transform.scale(
                                                          scale: 0.1,
                                                          child:
                                                              const ColorFiltered(
                                                                  colorFilter:
                                                                      ColorFilter
                                                                          .mode(
                                                                    Colors
                                                                        .transparent,
                                                                    BlendMode
                                                                        .multiply,
                                                                  ),
                                                                  child: CircularProgressIndicator
                                                                      .adaptive())),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Transform.scale(
                                                    scale: 0.1,
                                                    child: const ColorFiltered(
                                                      colorFilter:
                                                          ColorFilter.mode(
                                                        Colors.transparent,
                                                        BlendMode.multiply,
                                                      ),
                                                      child: Icon(
                                                        Icons.error,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Padding(
                                                  padding: EdgeInsets.all(4.h),
                                                  child: SizedBox(
                                                    child: Center(
                                                      child: Text(
                                                        'Banner Expired',
                                                        style: TextStyle(
                                                            fontSize: 8.sp),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                    );
                                  },
                                )

                              ///if offers is null it will display message no banners found
                              : Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'No banners found',
                                      style: TextStyle(fontSize: 12.sp),
                                    ),
                                  ),
                                ),

                          ///move page to previous
                          Visibility(
                            visible: false,
                            child: GestureDetector(
                              child: Align(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  height: 7.5.h,
                                  width: 7.5.h,
                                  child: Icon(
                                    Icons.navigate_before,
                                    color:
                                        const Color.fromRGBO(64, 201, 121, 1.0),
                                    size: 6.h,
                                  ),
                                ),
                                alignment: Alignment.centerLeft,
                              ),
                              onTap: () {
                                if (pageIndex > 0) {
                                  pageIndex--;
                                  _pageController.jumpToPage(pageIndex);
                                }
                              },
                            ),
                          ),

                          ///move page to next
                          Visibility(
                            visible: false,
                            child: GestureDetector(
                              child: Align(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  height: 7.5.h,
                                  width: 7.5.h,
                                  child: Icon(
                                    Icons.navigate_next,
                                    color:
                                        const Color.fromRGBO(64, 201, 121, 1.0),
                                    size: 6.h,
                                  ),
                                ),
                                alignment: Alignment.centerRight,
                              ),
                              onTap: () {
                                if (pageIndex < 2) {
                                  pageIndex++;
                                  _pageController.jumpToPage(pageIndex);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

            ///banner counter
            offers.isEmpty
                ? SizedBox()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      offers != null
                          ? Padding(
                              padding: EdgeInsets.only(left: 4.w, top: 2.h),
                              child: Text(
                                offers.isEmpty
                                    ? 'showing'.tr +
                                        " " +
                                        '0' +
                                        "/" +
                                        offers.length.toString()
                                    : 'showing'.tr +
                                        " " +
                                        (pageIndex + 1).toString() +
                                        "/" +
                                        offers.length.toString(),
                                style: subtitle1.copyWith(
                                    color: ColorConstants.blackShade,
                                    fontSize: _isMobileLayout ? 12.sp : 9.sp),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),

            ///only margin
            offers.isEmpty
                ? SizedBox()
                : SizedBox(
                    height: 2.h,
                  ),

            ///Near to Expire/Damaged
            Obx(() => shopDetailController.isNearToExpireLoading.value
                ? SizedBox()
                : shopDetailController.nearExpireShopItems!.isEmpty
                    ? SizedBox()
                    : Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextWithLeaves('Near To Expire/Damaged'.tr),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.nearToExpireShopSeeAll,
                                      arguments: {
                                        'isAllExpired': isExpiredDiscount
                                            ? isAllExpired
                                            : false,
                                        'item': shopDetailController
                                            .nearToExpire?.rows,
                                        'location': Get.arguments['location'],
                                      });
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                    bottom: 1.h,
                                    right: 3.w,
                                  ),
                                  child: Text(
                                    'See All'.tr,
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: ColorConstants.parrotDark,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          CarouselSlider(
                            options: CarouselOptions(
                              height: 22.5.h,
                              aspectRatio: 16 / 9,
                              viewportFraction: 0.95,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: true,
                              autoPlay: false,
                              autoPlayInterval: const Duration(seconds: 15),
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              scrollPhysics: shopDetailController
                                          .nearExpireShopItems?.length ==
                                      1
                                  ? const NeverScrollableScrollPhysics()
                                  : const ScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                            ),
                            items: shopDetailController.nearExpireShopItems
                                ?.map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.toNamed(
                                        Routes.nearToExpireSubScreen,
                                        arguments: {
                                          'isAllExpired': isExpiredDiscount
                                              ? isAllExpired
                                              : false,
                                          'item': i,
                                          'location': Get.arguments['location'],
                                        },
                                      );
                                    },
                                    child: ExpireDamagedCard(
                                      id: i.id as int,
                                      title: i.name as String,
                                      imageUrl:
                                          '${Utils.BASE_URL}${i.imageUrl}',
                                      quantity: i.quantity as String,
                                      price: i.price as String,
                                      //isExpired: i.shopItems![0].i as int,
                                      date:
                                          Utils.getDate(i.expiryDate as String),
                                      time:
                                          Utils.getTime(i.expiryDate as String),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        ],
                      )),

            ///end of near to expire/damaged
            ///margin
            SizedBox(
              height: 4.h,
            ),
          ],
        ),
      ),
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      pageIndex = index;
    });
  }
}
