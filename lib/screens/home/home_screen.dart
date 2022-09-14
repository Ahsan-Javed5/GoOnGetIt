import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_on_get_it/constants/app_images.dart';
import 'package:go_on_get_it/constants/color_constants.dart';
import 'package:go_on_get_it/constants/font_constants.dart';
import 'package:go_on_get_it/data/local/my_hive.dart';
import 'package:go_on_get_it/screens/location/controller/location_controller.dart';
import 'package:go_on_get_it/screens/location/controller/main_controller.dart';
import 'package:go_on_get_it/screens/shopDetail/shop_detail_controller.dart';
import 'package:go_on_get_it/utils/utils.dart';
import 'package:go_on_get_it/widgets/dropdown/catalog_dropdown.dart';
import 'package:go_on_get_it/widgets/dropdown/custom_dropdown.dart';
import 'package:go_on_get_it/widgets/expire_damaged.dart';
import 'package:go_on_get_it/widgets/no_shops_found.dart';
import 'package:go_on_get_it/widgets/text_with_leaves.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '/constants/routes.dart';
import '/widgets/catalog_individual_item.dart';
import '/widgets/main_drawer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  ///Controllers
  final MainController mainController = Get.put(MainController());
  final LocationController locationController = Get.put(LocationController());
  final SubSubCategoryController shopDetailController =
      Get.put(SubSubCategoryController());
  final _singleChildScrollController = ScrollController();
  final int pageIndex = 0;
  bool isExpiredDiscount = MyHive.getExpiredDiscount();

  @override
  Widget build(BuildContext context) {
    rebuildAllChildren(context);
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool _isMobileLayout = shortestSide < 600;

    return Scaffold(
      onDrawerChanged: (isOpened) {
        if (isOpened) {
          dropDownControl();
        }
      },
      appBar: AppBar(
        leading: Transform.translate(
          offset: const Offset(-4, 0),
          child: Builder(builder: (context) {
            return InkWell(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: Padding(
                padding: EdgeInsets.only(top: _isMobileLayout ? 0 : 2.h),
                child: SvgPicture.asset(
                  'assets/svgs/drawer_icon.svg',
                  fit: BoxFit.scaleDown,
                ),
              ),
            );
          }),
        ),
        titleSpacing: 1.w,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(top: _isMobileLayout ? 0 : 2.h),
            child: Text(
              'Sjekk Tilbud'.tr,
              style: TextStyle(
                fontFamily: FontConstants.sourceSansProSemiBold,
                color: Colors.black,
                fontSize: _isMobileLayout ? 15.sp : 10.5.sp,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: const MainDrawer(),

      ///body
      body: GestureDetector(
        onTap: () {
          dropDownControl();
        },
        onVerticalDragDown: (drag) {
          dropDownControl();
        },
        child: Obx(
          () => mainController.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  controller: _singleChildScrollController,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.7.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 2.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: InkWell(
                                    onTap: () async {
                                      mainController.navigate();
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: _isMobileLayout ? 0 : 2.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  'currentLocation'.tr,
                                                  style: TextStyle(
                                                    fontFamily: FontConstants
                                                        .sourceSansProRegular,
                                                    fontSize: _isMobileLayout
                                                        ? 11.sp
                                                        : 9.sp,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(0.8.h),
                                                child: SvgPicture.asset(
                                                  AppImages.smallArrowIcon,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Obx(
                                            () => Text(
                                              mainController
                                                  .locationAddress.value,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: _isMobileLayout
                                                    ? 15.sp
                                                    : 9.sp,
                                                color: const Color.fromRGBO(
                                                    64, 201, 121, 1),
                                                fontFamily: FontConstants
                                                    .sourceSansProSemiBold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomDropdown(
                                    radiusText: "radius".tr,
                                    dropDownCallBack: (overlay) {
                                      mainController.radiusLay = overlay;
                                    },
                                    selectValue: (value) {
                                      ///splitting value from string
                                      value ??= '10 Km';
                                      var values = value.split(' ');

                                      /// Setting radius
                                      MyHive.setRadius(int.parse(values[0]));

                                      ///passing radius to categories
                                      mainController.getCategories(
                                          radius: int.tryParse(values[0])!);

                                      ///passing radius to near to expire list
                                      mainController.getNearToExpire(
                                          radius: int.tryParse(values[0])!);
                                    },
                                  ),

                                  ///catalog dropdown widget....
                                  CatalogDropdown(
                                    iconData: Icons.arrow_drop_down,
                                    radiusText: 'Catalog',
                                    callBack: (catalog) {
                                      mainController.catalogLay = catalog;
                                    },
                                    selectedvalue: (String value) {
                                      if (value == "throughShops" ||
                                          value == "Søk etter butikk") {
                                        Get.toNamed(Routes.shopScreen,
                                            arguments: {
                                              'catalogTitle': 'throughShops',
                                              'id': '',
                                              'filter': 'shop'
                                            });
                                        mainController.selectedCat.value =
                                            'throughShops';
                                      } else if (value == "throughItem" ||
                                          value == "Søk etter vare") {
                                        Get.toNamed(Routes.shopScreen,
                                            arguments: {
                                              'catalogTitle': 'throughItem',
                                              'id': '',
                                              'filter': 'item'
                                            });
                                        mainController.selectedCat.value =
                                            'throughItem';
                                      } else if (value == "allNearMe" ||
                                          value == "Alt i nærheten") {
                                        Get.toNamed(Routes.shopScreen,
                                            arguments: {
                                              'catalogTitle': 'allNearMe',
                                              'id': '',
                                              'filter': 'near_me'
                                            });
                                        mainController.selectedCat.value =
                                            'allNearMe';
                                      } else if (value == "trending" ||
                                          value == "Trender") {
                                        Get.toNamed(Routes.shopScreen,
                                            arguments: {
                                              'catalogTitle': 'trending',
                                              'id': '',
                                              'filter': 'trending'
                                            });
                                        mainController.selectedCat.value =
                                            'trending';
                                      }
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextWithLeaves('catalog'.tr),
                            GestureDetector(
                              onTap: () {
                                _singleChildScrollController.animateTo(
                                    _singleChildScrollController
                                        .position.maxScrollExtent,
                                    curve: Curves.easeOut,
                                    duration: const Duration(seconds: 1));
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  right: 3.w,
                                  bottom: 0.7.h,
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: 1.75.h,
                                  horizontal: 2.5.w,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0.5.h),
                                  color:
                                      const Color.fromRGBO(64, 201, 121, 0.09),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                        right: 1.5.w,
                                      ),
                                      child: SvgPicture.asset(
                                        'assets/svgs/distance_icon.svg',
                                        height: 2.h,
                                        width: 2.h,
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                    Text(
                                      'kart'.tr,
                                      style: TextStyle(
                                        fontFamily:
                                            FontConstants.sourceSansProRegular,
                                        fontSize:
                                            _isMobileLayout ? 11.sp : 6.5.sp,
                                        color: const Color.fromRGBO(
                                            64, 201, 121, 1.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (ctx, index) {
                            return GestureDetector(
                              onTap: () {
                                mainController.isShopNearToExpire.value = true;
                                if (mainController.catalogLay != null) {
                                  mainController.catalogLay?.remove();
                                  mainController.catalogLay = null;
                                  mainController.isCatalogDropDown = false;
                                }
                                if (mainController.radiusLay != null) {
                                  mainController.radiusLay?.remove();
                                  mainController.isDropdownOpened.value = false;
                                  mainController.radiusLay = null;
                                }

                                if (mainController.categories[index]
                                        .SubCategories.length >
                                    0) {
                                  ///SUB CAT EXISTED
                                  Get.toNamed(Routes.catalog2Screen,
                                      arguments: {
                                        'id': mainController
                                            .categories[index].id
                                            .toString(),
                                        'title': mainController
                                            .categories[index].name,
                                      });
                                } else {
                                  ///moving to subSubCategory Screen
                                  log('SUB CAT NOT EXISTED');
                                  Get.toNamed(
                                    Routes.shopScreen,
                                    arguments: {
                                      'catalogTitle':
                                          mainController.categories[index].name,
                                      'id': mainController.categories[index].id
                                          .toString(),
                                      'filter': 'catalog'
                                    },
                                  );
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        _isMobileLayout ? 2.4.w : 1.3.w),
                                child: CatalogIndividualItem(
                                  mainController.categories[index].name,
                                  Utils.BASE_URL +
                                      mainController.categories[index].image,
                                  mainController.categories[index].discount,
                                  mainController.categories[index].shopCounts
                                      .toString(),
                                  iconUrl: Utils.BASE_URL +
                                      mainController.categories[index].icon
                                          .toString(),
                                ),
                              ),
                            );
                          },
                          itemCount: mainController.categories.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: _isMobileLayout ? 8 / 9 : 8 / 7.3,
                            mainAxisSpacing: _isMobileLayout ? 1.2.h : 2.h,
                            crossAxisSpacing: _isMobileLayout ? 0.01.h : 0.1.h,
                            crossAxisCount: 2,
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),

                        ///Near to Expire/Damaged
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextWithLeaves('Near To Expire/Damaged'.tr),
                            GestureDetector(
                              onTap: () async {
                                mainController.isSeeAll.value = true;
                                mainController.isShopNearToExpire.value = false;
                                await Get.toNamed(
                                  Routes.nearToExpireSeeAll,
                                  arguments: {
                                    'isAllExpired':
                                        isExpiredDiscount ? false : false,
                                    'item': mainController.nearToExpire,
                                  },
                                );
                                mainController.getNearToExpire();
                                mainController.isShopNearToExpire.value = true;
                                mainController.isSeeAll.value = false;
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
                        Obx(
                          () => mainController.isNearToExpireLoading.value
                              ? const Center(child: CircularProgressIndicator())
                              : CarouselSlider(
                                  options: CarouselOptions(
                                    height: 22.5.h,
                                    aspectRatio: 16 / 9,
                                    viewportFraction: 0.95,
                                    initialPage: 0,
                                    enableInfiniteScroll: true,
                                    reverse: false,
                                    autoPlay:
                                        mainController.nearToExpire.length == 1
                                            ? false
                                            : true,
                                    autoPlayInterval:
                                        const Duration(seconds: 5),
                                    autoPlayAnimationDuration:
                                        const Duration(milliseconds: 800),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enlargeCenterPage: true,
                                    scrollPhysics: mainController
                                                .nearToExpire.length ==
                                            1
                                        ? const NeverScrollableScrollPhysics()
                                        : const ScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                  ),
                                  items: mainController.nearToExpire.map(
                                    (i) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return GestureDetector(
                                            onTap: () async {
                                              mainController.isShopNearToExpire
                                                  .value = false;
                                              await Get.toNamed(
                                                Routes.nearToExpireSubScreen,
                                                arguments: {
                                                  'isAllExpired':
                                                      isExpiredDiscount
                                                          ? false
                                                          : false,
                                                  'item': i,
                                                  'location': {
                                                    'lat': i.shopOwner!.lat
                                                        .toString(),
                                                    'long': i.shopOwner!.long
                                                        .toString(),
                                                    'distanceInKm': i
                                                        .shopOwner!.distanceKm
                                                        .toString()
                                                  },
                                                },
                                              );
                                              mainController.isShopNearToExpire
                                                  .value = true;
                                              mainController.getNearToExpire();
                                            },
                                            child: ExpireDamagedCard(
                                              id: i.shopId as int,
                                              title: i.name as String,
                                              imageUrl:
                                                  '${Utils.BASE_URL}${i.imageUrl}',
                                              quantity: i.quantity as String,
                                              price: i.price as String,
                                              isExpired: i.isExpired as int,
                                              date: Utils.getDate(
                                                  i.expiryDate as String),
                                              time: Utils.getTime(
                                                  i.expiryDate as String),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ).toList(),
                                ),
                        ),
                        SizedBox(
                          height: 3.5.h,
                        ),
                        TextWithLeaves('popularShops'.tr),

                        ///Popular Shops
                        Container(
                          height: 11.5.h,
                          margin: EdgeInsets.only(top: 1.5.h),
                          child: MyHive.getToken() == null
                              ? const SizedBox()
                              : mainController.popular.isEmpty
                                  ? noShopsFound('No Popular Shops Found')
                                  : ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: mainController.popular.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 2.0.w),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: SizedBox(
                                                height: 4.h,
                                                width: 11.5.h,
                                                child: mainController
                                                            .popular[index]
                                                            .shopLogo !=
                                                        null
                                                    ? CachedNetworkImage(
                                                        height: 4.h,
                                                        width: 4.w,
                                                        maxHeightDiskCache: 150,
                                                        fit: BoxFit.cover,
                                                        imageUrl: Utils
                                                                .BASE_URL +
                                                            mainController
                                                                .popular[index]
                                                                .shopLogo,
                                                        placeholder:
                                                            (context, url) =>
                                                                const Center(
                                                          child:
                                                              CircularProgressIndicator
                                                                  .adaptive(),
                                                        ),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            SizedBox(
                                                          height: Get.height,
                                                          width: Get.width,
                                                          child: Image.asset(
                                                            AppImages
                                                                .macdonaldRect,
                                                            fit: BoxFit.cover,
                                                            height: 4.h,
                                                            width: 4.h,
                                                          ),
                                                        ),
                                                      )
                                                    : Image.asset(
                                                        AppImages.macdonaldRect,
                                                        fit: BoxFit.cover,
                                                        height: 4.h,
                                                        width: 4.h,
                                                      ),
                                              ),
                                            ),
                                          ),
                                          onTap: () {
                                            shopDetailController
                                                .getShopNearToExpire(
                                                    id: mainController
                                                        .popular[index].id
                                                        .toString());
                                            Get.toNamed(
                                              Routes
                                                  .nextToCatalogIndividualScreen,
                                              arguments: {
                                                'iconUrl':
                                                    '${Utils.BASE_URL}${mainController.popular[index].shopLogo}',
                                                'title': mainController
                                                    .popular[index].name,
                                                'offers': mainController
                                                    .popular[index].offers,
                                                'address': mainController
                                                    .popular[index].address,
                                                'shop_id': mainController
                                                    .popular[index].id,
                                                'isLiked': mainController
                                                            .popular[index]
                                                            .isLiked ==
                                                        1
                                                    ? true.obs
                                                    : false.obs,
                                                'phone': mainController
                                                    .popular[index].phone
                                                    .toString(),
                                                'location': {
                                                  'lat': mainController
                                                      .popular[index].lat
                                                      .toString(),
                                                  'long': mainController
                                                      .popular[index].long
                                                      .toString(),
                                                  'distanceInKm': mainController
                                                      .popular[index].distanceKm
                                                      .toString()
                                                }
                                              },
                                            );
                                          },
                                        );
                                      },
                                    ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        TextWithLeaves('latestShops'.tr),

                        ///Latest Shops
                        Container(
                          height: 11.5.h,
                          margin: EdgeInsets.only(top: 1.5.h),
                          child: MyHive.getToken() == null
                              ? const SizedBox()
                              : mainController.latest.isEmpty
                                  ? noShopsFound('No Latest Shops Found')
                                  : ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: mainController.latest.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            shopDetailController
                                                .getShopNearToExpire(
                                                    id: mainController
                                                        .latest[index].id
                                                        .toString());
                                            Get.toNamed(
                                                Routes
                                                    .nextToCatalogIndividualScreen,
                                                arguments: {
                                                  'iconUrl':
                                                      '${Utils.BASE_URL}${mainController.latest[index].shopLogo}',
                                                  'title': mainController
                                                      .latest[index].name,
                                                  'offers': mainController
                                                      .latest[index].offers,
                                                  'address': mainController
                                                      .latest[index].address,
                                                  'shop_id': mainController
                                                      .latest[index].id,
                                                  'isLiked': mainController
                                                              .latest[index]
                                                              .isLiked ==
                                                          1
                                                      ? true.obs
                                                      : false.obs,
                                                  'phone': mainController
                                                      .latest[index].phone
                                                      .toString(),
                                                  'location': {
                                                    'lat': mainController
                                                        .latest[index].lat
                                                        .toString(),
                                                    'long': mainController
                                                        .latest[index].long
                                                        .toString(),
                                                    'distanceInKm':
                                                        mainController
                                                            .latest[index]
                                                            .distanceKm
                                                            .toString()
                                                  }
                                                });
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 2.0.w),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: SizedBox(
                                                height: 4.h,
                                                width: 11.5.h,
                                                child: mainController
                                                            .latest[index]
                                                            .shopLogo !=
                                                        null
                                                    ? CachedNetworkImage(
                                                        height: 4.h,
                                                        width: 4.w,
                                                        maxHeightDiskCache: 150,
                                                        fit: BoxFit.cover,
                                                        imageUrl:
                                                            '${Utils.BASE_URL}${mainController.latest[index].shopLogo}',
                                                        placeholder:
                                                            (context, url) =>
                                                                const Center(
                                                          child:
                                                              CircularProgressIndicator
                                                                  .adaptive(),
                                                        ),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            SizedBox(
                                                          height: Get.height,
                                                          width: Get.width,
                                                          child: Image.asset(
                                                            AppImages
                                                                .macdonaldRect,
                                                            fit: BoxFit.cover,
                                                            height: 4.h,
                                                            width: 4.h,
                                                          ),
                                                        ),
                                                      )
                                                    : Image.asset(
                                                        AppImages.macdonaldRect,
                                                        height: 4.h,
                                                        width: 4.h,
                                                        fit: BoxFit.cover,
                                                      ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        //GoogleMap
                        MyHive.getToken() == null
                            ? const SizedBox()
                            : Container(
                                margin: EdgeInsets.symmetric(horizontal: 3.w),
                                width: Get.width,
                                height: 40.h,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Obx(() => mainController
                                          .isMapMakerLoading.value
                                      ? SizedBox(
                                          height: 3.h,
                                          width: 3.h,
                                          child: const Center(
                                              child:
                                                  CircularProgressIndicator()))
                                      : GoogleMap(
                                          mapType: MapType.normal,
                                          zoomControlsEnabled: true,
                                          compassEnabled: true,
                                          indoorViewEnabled: true,
                                          trafficEnabled: true,
                                          zoomGesturesEnabled: true,
                                          gestureRecognizers: Set()
                                            ..add(Factory<PanGestureRecognizer>(
                                                () => PanGestureRecognizer())),
                                          myLocationEnabled: true,
                                          scrollGesturesEnabled: true,
                                          initialCameraPosition: CameraPosition(
                                            target: LatLng(
                                                mainController
                                                        .position?.latitude ??
                                                    mainController
                                                        .latLng!.latitude,
                                                mainController
                                                        .position?.longitude ??
                                                    mainController
                                                        .latLng!.longitude),
                                            zoom: 10,
                                          ),
                                          onMapCreated:
                                              (GoogleMapController c) async {},
                                          rotateGesturesEnabled: true,
                                          tiltGesturesEnabled: true,
                                          markers: mainController.shopMarkers)),
                                ),
                              ),
                        SizedBox(
                          height: 3.h,
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  void dropDownControl() {
    if (mainController.catalogLay != null) {
      mainController.catalogLay?.remove();
      mainController.catalogLay = null;
      mainController.isCatalogDropDown = false;
    }
    if (mainController.radiusLay != null) {
      mainController.radiusLay?.remove();
      mainController.isDropdownOpened.value = false;
      mainController.radiusLay = null;
    }
  }

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }
}
