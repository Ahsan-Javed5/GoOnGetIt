import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_on_get_it/constants/app_images.dart';
import 'package:go_on_get_it/constants/font_constants.dart';
import 'package:go_on_get_it/constants/routes.dart';
import 'package:go_on_get_it/data/local/my_hive.dart';
import 'package:go_on_get_it/screens/categories/sub_category_controller.dart';
import 'package:go_on_get_it/screens/location/controller/main_controller.dart';
import 'package:go_on_get_it/utils/utils.dart';
import 'package:go_on_get_it/widgets/catalog_individual_item.dart';
import 'package:go_on_get_it/widgets/customer_appbar.dart';
import 'package:go_on_get_it/widgets/dropdown/catalog_dropdown.dart';
import 'package:go_on_get_it/widgets/text_with_leaves.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

class SubSubCategoryScreen extends StatefulWidget {
  const SubSubCategoryScreen({Key? key}) : super(key: key);

  @override
  State<SubSubCategoryScreen> createState() => _SubSubCategoryScreenState();
}

class _SubSubCategoryScreenState extends State<SubSubCategoryScreen> {
  final MainController locationController = Get.put(MainController());
  final SubCategoryController subCategoryController = Get.put(SubCategoryController());
  final MainController mainController = Get.find<MainController>();

  final CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  final String selectedItem = Get.arguments?["title"] ?? 'UnSelected';
  final String id = Get.arguments?["id"];
  bool isDropDownValueChanged = false;

  @override
  void initState() {
    subCategoryController.fetchSubCategories(categoryId: id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool _isMobileLayout = shortestSide < 600;
    mainController.seletedItem.value = 'Catalog';

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, 1);
        return Future.value(false);
      },
      child: Scaffold(
        onDrawerChanged: (isOpened) {
          if (isOpened) {
            if (locationController.catalogLay != null) {
              locationController.catalogLay?.remove();
              locationController.catalogLay = null;
              locationController.isCatalogDropDown = false;
            }
            if (locationController.radiusLay != null) {
              locationController.radiusLay?.remove();
              locationController.isDropdownOpened.value = false;
              locationController.radiusLay = null;
            }
          }
        },
        resizeToAvoidBottomInset: false,
        appBar: CustomeAppBar(
          title: 'Sjekk Tilbud',
          onPressed: () {
            if (locationController.catalogLay != null) {
              locationController.catalogLay?.remove();
              locationController.catalogLay = null;
              locationController.isCatalogDropDown = false;
            }
            Navigator.pop(context, 1);
            return;

          },
        ),
        //drawer: const MainDrawer(),
        body: GestureDetector(
            onTap: () {
              if (locationController.catalogLay != null) {
                locationController.catalogLay?.remove();
                locationController.catalogLay = null;
                locationController.isCatalogDropDown = false;
              }
              if (locationController.radiusLay != null) {
                locationController.radiusLay?.remove();
                locationController.isDropdownOpened.value = false;
                locationController.radiusLay = null;
              }
            },
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 2.w,
                  right: 2.w,
                  child: Image.asset(
                    AppImages.notificationBackground,
                    // height: 10.h,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.7.w),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 2.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: _isMobileLayout ? 0 : 2.h),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Get.toNamed(Routes.locationScreen);
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'currentLocation'.tr,
                                                style: TextStyle(
                                                  fontFamily: FontConstants.sourceSansProRegular,
                                                  fontSize: _isMobileLayout ? 11.sp : 9.sp,
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
                                        ),
                                        Obx(
                                              () => Container(
                                            margin: EdgeInsets.only(top: 0.5.h),
                                            width: 48.w,
                                            height: 3.h,
                                            child: Text(
                                              locationController
                                                  .locationAddress.value,
                                              style: TextStyle(
                                                fontSize: _isMobileLayout ?  14.5.sp : 9.sp,
                                                color: const Color.fromRGBO(
                                                    64, 201, 121, 1),
                                                fontFamily: FontConstants
                                                    .sourceSansProSemiBold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    CatalogDropdown(
                                      iconData: Icons.arrow_drop_down,
                                      radiusText: mainController.seletedItem.value.tr,
                                      callBack: (catalog) {
                                        mainController.catalogLay = catalog;
                                      },
                                      selectedvalue: (String value) {
                                        if (value == "throughShops" ||
                                            value == "Søk etter butikk") {
                                          Get.toNamed(Routes.shopScreen,
                                              arguments: {
                                                'catalogTitle': 'throughShops',
                                                'id': id,
                                                'filter': 'shop'
                                              });
                                          mainController.selectedCat.value = 'throughShops';
                                        } else if (value == "throughItem" ||
                                            value == "Søk etter vare") {
                                          Get.toNamed(Routes.shopScreen,
                                              arguments: {
                                                'catalogTitle': 'throughItem',
                                                'id': id,
                                                'filter': 'item'
                                              });
                                          mainController.selectedCat.value = 'throughItem';
                                        } else if (value == "allNearMe" ||
                                            value == "Alt i nærheten") {
                                          Get.toNamed(Routes.shopScreen,
                                              arguments: {
                                                'catalogTitle': 'allNearMe',
                                                'id': id,
                                                'filter': 'near_me'
                                              });
                                          mainController.selectedCat.value = 'allNearMe';
                                        } else if (value == "trending" ||
                                            value == "Trender") {
                                          Get.toNamed(Routes.shopScreen,
                                              arguments: {
                                                'catalogTitle': 'trending',
                                                'id': id,
                                                'filter': 'trending'
                                              });
                                          mainController.selectedCat.value = 'trending';
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextWithLeaves(selectedItem),
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),

                          Obx(
                                () =>  subCategoryController.isLoading.value
                                ? const CircularProgressIndicator.adaptive()
                                : GridView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (ctx, index) {
                                return GestureDetector(
                                  onTap: () {
                                    if (locationController.catalogLay != null) {
                                      locationController.catalogLay?.remove();
                                      locationController.catalogLay = null;
                                      locationController.isCatalogDropDown = false;
                                    }
                                    if (locationController.radiusLay != null) {
                                      locationController.radiusLay?.remove();
                                      locationController.isDropdownOpened.value = false;
                                      locationController.radiusLay = null;
                                    }


                                    // print('------');
                                    // print(subCategoryController.subCategoryList[index].subCategories.toString());
                                    // print(subCategoryController.subCategoryList[index].id.toString());
                                      ///moving to shop Screen
                                      Get.toNamed(
                                        Routes.shopScreen,
                                        arguments: {
                                          'catalogTitle': subCategoryController.subCategoryList[index].name.toString(),
                                          'id': subCategoryController.subCategoryList[index].id.toString(),
                                          'filter': 'catalog',
                                        },
                                      );
                                    },
                                  child: Center(
                                    child: Padding(
                                      padding: _isMobileLayout
                                          ? EdgeInsets.symmetric(horizontal:  2.4.w)
                                          : EdgeInsets.all(1.h) ,
                                      child: CatalogIndividualItem(
                                        subCategoryController.subCategoryList[index].name.toString(),
                                        Utils.BASE_URL + subCategoryController.subCategoryList[index].image!,
                                        subCategoryController.subCategoryList[index].discount!.toString(),
                                        subCategoryController.subCategoryList[index].shopCounts.toString(),
                                        iconUrl: Utils.BASE_URL + subCategoryController.subCategoryList[index].icon!,
                                      ),),
                                  ),
                                );
                              },
                              itemCount: subCategoryController.subCategoryList.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: _isMobileLayout ? 8 / 9 : 8 / 7.3,
                                mainAxisSpacing:  _isMobileLayout ? 1.2.h : 0.1.h,
                                crossAxisSpacing: _isMobileLayout ? 0.01.h : 0.1.h,
                                crossAxisCount: 2,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
