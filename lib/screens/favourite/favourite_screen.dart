import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_on_get_it/constants/font_constants.dart';
import 'package:go_on_get_it/constants/routes.dart';
import 'package:go_on_get_it/screens/favourite/favorite_controller.dart';
import 'package:go_on_get_it/screens/location/controller/main_controller.dart';
import 'package:go_on_get_it/screens/shopDetail/shop_detail_controller.dart';
import 'package:go_on_get_it/utils/space.dart';
import 'package:go_on_get_it/utils/utils.dart';
import 'package:go_on_get_it/widgets/back_arrow.dart';
import 'package:go_on_get_it/widgets/favorite_individual_item_mobile.dart';
import 'package:go_on_get_it/widgets/favorite_list_shimmer.dart';
import 'package:go_on_get_it/widgets/search_view.dart';
import 'package:sizer/sizer.dart';
import '/widgets/favorite_individual_item_tablet.dart';

class FavoriteListScreen extends StatefulWidget {
  const FavoriteListScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteListScreen> createState() => _FavoriteListScreenState();
}

class _FavoriteListScreenState extends State<FavoriteListScreen> {
  final FavoriteController _favoriteController = Get.put(FavoriteController());
  final MainController mainController = Get.find<MainController>();
  final SubSubCategoryController shopDetailController =
      Get.find<SubSubCategoryController>();

  @override
  void initState() {
    _favoriteController.fetchFavoriteListData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool _isMobileLayout = shortestSide < 600;
    return Obx(
      () => _favoriteController.isLoading.value
          ? const FavoriteListShimmer()
          : Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: _isMobileLayout
                  ? AppBar(
                      leading: BackArrow(
                        sendDataBack: true,
                      ),
                      title: Align(
                        alignment: Alignment.centerLeft,
                        child: Transform(
                          transform: Matrix4.translationValues(-10, 6.0, 0.0),
                          child: Text(
                            'Favorites'.tr,
                            style: TextStyle(
                              fontFamily: FontConstants.sourceSansProSemiBold,
                              color: Colors.black,
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                      ),
                      titleSpacing: 0.7.w,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    )
                  : AppBar(
                      toolbarHeight: 7.h,
                      leading: BackArrow(),
                      title: Align(
                        alignment: Alignment.centerLeft,
                        child: Transform(
                          transform: Matrix4.translationValues(-10, 6.0, 0.0),
                          child: Padding(
                            padding: EdgeInsets.only(left: 1.w),
                            child: Text(
                              'Favourite List'.tr,
                              style: TextStyle(
                                fontFamily: FontConstants.sourceSansProSemiBold,
                                color: Colors.black,
                                fontSize: 10.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                      titleSpacing: 0.7.w,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
              body: (_favoriteController.favoriteList!.isEmpty &&
                      !_favoriteController.isNoSearchItems.value)
                  ? Center(
                      child: Text(
                        'No Favorites',
                        style:
                            TextStyle(fontSize: _isMobileLayout ? 12.sp : 8.sp),
                      ),
                    )
                  : Column(
                      children: [
                        Spaces.y2,
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: Spaces.normX(2)),
                          height: Spaces.normY(6.6),
                          width: Get.width,
                          child: SearchView(
                            isFavoriteScreen: true,
                            onChange: (value) {
                              _favoriteController.fetchFavoriteSearch(
                                  value: value,
                                  updateList: () {
                                    setState(() {});
                                  });
                              // _favoriteController.favoriteSearchedList.clear();
                              // _favoriteController.favoriteSearchedList.addAll(_favoriteController.favoriteList!);
                              // if(value.length > 1){
                              //   _favoriteController.favoriteList!.clear();
                              //   for (var favItem in _favoriteController.favoriteSearchedList) {
                              //     if(favItem.name!.toLowerCase().contains(value.toLowerCase())){
                              //       _favoriteController.favoriteList!.add(favItem);
                              //     }
                              //   }
                              //   setState(() {});
                              // }
                            },
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: Spaces.normX(3),
                                vertical: Spaces.normY(1)),
                            child: !_isMobileLayout
                                ? _favoriteController.isNoSearchItems.value
                                    ? Padding(
                                        padding: EdgeInsets.only(top: 3.h),
                                        child: const Text('No Items found'),
                                      )
                                    : GridView.builder(
                                        itemCount: _favoriteController
                                                .favoriteSearchedList.isNotEmpty
                                            ? _favoriteController
                                                .favoriteSearchedList.length
                                            : _favoriteController
                                                .favoriteList!.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 8 / 3.9,
                                          mainAxisSpacing: 1.h,
                                          crossAxisSpacing: 1.h,
                                          crossAxisCount: 2,
                                        ),
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () async {
                                              final result = await Get.toNamed(
                                                  Routes
                                                      .nextToCatalogIndividualScreen,
                                                  arguments: {
                                                    'title': _favoriteController
                                                        .favoriteList![index]
                                                        .name
                                                        .toString(),
                                                    'address':
                                                        _favoriteController
                                                            .favoriteList![
                                                                index]
                                                            .address
                                                            .toString(),
                                                    'iconUrl':
                                                        '${Utils.BASE_URL}${_favoriteController.favoriteList![index].shopLogo}',
                                                    'shop_id':
                                                        _favoriteController
                                                            .favoriteList![
                                                                index]
                                                            .id!,
                                                    'phone': _favoriteController
                                                        .favoriteList![index]
                                                        .phone
                                                        .toString(),
                                                    'offers':
                                                        _favoriteController
                                                            .favoriteList![
                                                                index]
                                                            .Offers!,
                                                    'isLiked': _favoriteController
                                                                .favoriteList![
                                                                    index]
                                                                .isLiked ==
                                                            1
                                                        ? true.obs
                                                        : false.obs,
                                                    'location': {
                                                      'lat': _favoriteController
                                                          .favoriteList![index]
                                                          .lat
                                                          .toString(),
                                                      'long':
                                                          _favoriteController
                                                              .favoriteList![
                                                                  index]
                                                              .long
                                                              .toString(),
                                                      'distanceInKm':
                                                          _favoriteController
                                                              .favoriteList![
                                                                  index]
                                                              .distanceKm
                                                              .toString()
                                                    }
                                                  });
                                              _favoriteController
                                                  .favoriteSearchedList
                                                  .clear();
                                              _favoriteController.onInit();
                                            },
                                            child:
                                                FavoriteIndividualItemsForTab(
                                                    title: _favoriteController
                                                            .favoriteSearchedList
                                                            .isNotEmpty
                                                        ? _favoriteController
                                                            .favoriteSearchedList[
                                                                index]
                                                            .name!
                                                        : _favoriteController
                                                            .favoriteList![
                                                                index]
                                                            .name!,
                                                    iconUrl: _favoriteController
                                                            .favoriteSearchedList
                                                            .isNotEmpty
                                                        ? _favoriteController
                                                            .favoriteSearchedList[
                                                                index]
                                                            .shopLogo
                                                            .toString()
                                                        : _favoriteController.favoriteList![index].shopLogo
                                                            .toString(),
                                                    address: _favoriteController
                                                            .favoriteSearchedList
                                                            .isNotEmpty
                                                        ? _favoriteController
                                                            .favoriteSearchedList[
                                                                index]
                                                            .address!
                                                        : _favoriteController
                                                            .favoriteList![
                                                                index]
                                                            .address!,
                                                    contact: _favoriteController
                                                            .favoriteSearchedList
                                                            .isNotEmpty
                                                        ? _favoriteController.favoriteSearchedList[index].phone!
                                                        : _favoriteController.favoriteList![index].phone!,
                                                    distance: _favoriteController.favoriteSearchedList.isNotEmpty ? '${_favoriteController.favoriteSearchedList[index].distanceKm!.toString()}km ago' : '${_favoriteController.favoriteList![index].distanceKm!.toString()}km ago',
                                                    position: index,
                                                    shopId: _favoriteController.favoriteSearchedList.isNotEmpty ? _favoriteController.favoriteSearchedList[index].id! : _favoriteController.favoriteList![index].id!,
                                                    isLiked: _favoriteController.favoriteSearchedList.isNotEmpty
                                                        ? _favoriteController.favoriteSearchedList[index].isLiked == 1
                                                            ? true.obs
                                                            : false.obs
                                                        : _favoriteController.favoriteList![index].isLiked == 1
                                                            ? true.obs
                                                            : false.obs,
                                                    filter: '',
                                                    id: '',
                                                    location: {
                                                  'lat': _favoriteController
                                                          .favoriteSearchedList
                                                          .isNotEmpty
                                                      ? _favoriteController
                                                          .favoriteSearchedList[
                                                              index]
                                                          .lat
                                                          .toString()
                                                      : _favoriteController
                                                          .favoriteList![index]
                                                          .lat
                                                          .toString(),
                                                  'long': _favoriteController
                                                          .favoriteSearchedList
                                                          .isNotEmpty
                                                      ? _favoriteController
                                                          .favoriteSearchedList[
                                                              index]
                                                          .long
                                                          .toString()
                                                      : _favoriteController
                                                          .favoriteList![index]
                                                          .long
                                                          .toString(),
                                                  'distanceInKm': _favoriteController
                                                          .favoriteSearchedList
                                                          .isNotEmpty
                                                      ? _favoriteController
                                                          .favoriteSearchedList[
                                                              index]
                                                          .distanceKm
                                                          .toString()
                                                      : _favoriteController
                                                          .favoriteList![index]
                                                          .distanceKm
                                                          .toString()
                                                }),
                                          );
                                        },
                                      )
                                : _favoriteController.isNoSearchItems.value
                                    ? Padding(
                                        padding: EdgeInsets.only(top: 3.h),
                                        child: const Text('No Items found'),
                                      )
                                    : ListView.builder(
                                        itemCount: _favoriteController
                                                .favoriteSearchedList.isNotEmpty
                                            ? _favoriteController
                                                .favoriteSearchedList.length
                                            : _favoriteController
                                                .favoriteList!.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () async {
                                              shopDetailController
                                                  .getShopNearToExpire(
                                                      id: _favoriteController
                                                          .favoriteList![index]
                                                          .id
                                                          .toString());
                                              await Get.toNamed(
                                                  Routes
                                                      .nextToCatalogIndividualScreen,
                                                  arguments: {
                                                    'title': _favoriteController
                                                        .favoriteList![index]
                                                        .name
                                                        .toString(),
                                                    'address':
                                                        _favoriteController
                                                            .favoriteList![
                                                                index]
                                                            .address
                                                            .toString(),
                                                    'iconUrl':
                                                        '${Utils.BASE_URL}${_favoriteController.favoriteList![index].shopLogo}',
                                                    'shop_id':
                                                        _favoriteController
                                                            .favoriteList![
                                                                index]
                                                            .id!,
                                                    'phone': _favoriteController
                                                        .favoriteList![index]
                                                        .phone
                                                        .toString(),
                                                    'offers':
                                                        _favoriteController
                                                            .favoriteList![
                                                                index]
                                                            .Offers!,
                                                    'isLiked': _favoriteController
                                                                .favoriteList![
                                                                    index]
                                                                .isLiked ==
                                                            1
                                                        ? true.obs
                                                        : false.obs,
                                                    'location': {
                                                      'lat': _favoriteController
                                                          .favoriteList![index]
                                                          .lat
                                                          .toString(),
                                                      'long':
                                                          _favoriteController
                                                              .favoriteList![
                                                                  index]
                                                              .long
                                                              .toString(),
                                                      'distanceInKm':
                                                          _favoriteController
                                                              .favoriteList![
                                                                  index]
                                                              .distanceKm
                                                              .toString()
                                                    }
                                                  });
                                              mainController.getNearToExpire();
                                              _favoriteController
                                                  .favoriteSearchedList
                                                  .clear();
                                              _favoriteController.onInit();
                                            },
                                            child:
                                                FavoriteIndividualItemForMobile(
                                                    title: _favoriteController
                                                            .favoriteSearchedList
                                                            .isNotEmpty
                                                        ? _favoriteController
                                                            .favoriteSearchedList[
                                                                index]
                                                            .name!
                                                        : _favoriteController
                                                            .favoriteList![
                                                                index]
                                                            .name!,
                                                    iconUrl: _favoriteController
                                                            .favoriteSearchedList
                                                            .isNotEmpty
                                                        ? _favoriteController
                                                            .favoriteSearchedList[
                                                                index]
                                                            .shopLogo
                                                            .toString()
                                                        : _favoriteController.favoriteList![index].shopLogo
                                                            .toString(),
                                                    address: _favoriteController
                                                            .favoriteSearchedList
                                                            .isNotEmpty
                                                        ? _favoriteController
                                                            .favoriteSearchedList[
                                                                index]
                                                            .address!
                                                        : _favoriteController
                                                            .favoriteList![
                                                                index]
                                                            .address!,
                                                    contact: _favoriteController
                                                            .favoriteSearchedList
                                                            .isNotEmpty
                                                        ? _favoriteController.favoriteSearchedList[index].phone!
                                                        : _favoriteController.favoriteList![index].phone!,
                                                    distance: _favoriteController.favoriteSearchedList.isNotEmpty ? '${_favoriteController.favoriteSearchedList[index].distanceKm!.toString()}km ago' : '${_favoriteController.favoriteList![index].distanceKm!.toString()}km ago',
                                                    position: index,
                                                    shopId: _favoriteController.favoriteSearchedList.isNotEmpty ? _favoriteController.favoriteSearchedList[index].id! : _favoriteController.favoriteList![index].id!,
                                                    isLiked: _favoriteController.favoriteSearchedList.isNotEmpty
                                                        ? _favoriteController.favoriteSearchedList[index].isLiked == 1
                                                            ? true.obs
                                                            : false.obs
                                                        : _favoriteController.favoriteList![index].isLiked == 1
                                                            ? true.obs
                                                            : false.obs,
                                                    filter: '',
                                                    id: '',
                                                    location: {
                                                  'lat': _favoriteController
                                                          .favoriteSearchedList
                                                          .isNotEmpty
                                                      ? _favoriteController
                                                          .favoriteSearchedList[
                                                              index]
                                                          .lat
                                                          .toString()
                                                      : _favoriteController
                                                          .favoriteList![index]
                                                          .lat
                                                          .toString(),
                                                  'long': _favoriteController
                                                          .favoriteSearchedList
                                                          .isNotEmpty
                                                      ? _favoriteController
                                                          .favoriteSearchedList[
                                                              index]
                                                          .long
                                                          .toString()
                                                      : _favoriteController
                                                          .favoriteList![index]
                                                          .long
                                                          .toString(),
                                                  'distanceInKm': _favoriteController
                                                          .favoriteSearchedList
                                                          .isNotEmpty
                                                      ? _favoriteController
                                                          .favoriteSearchedList[
                                                              index]
                                                          .distanceKm
                                                          .toString()
                                                      : _favoriteController
                                                          .favoriteList![index]
                                                          .distanceKm
                                                          .toString()
                                                }),
                                          );
                                        },
                                      ),
                          ),
                        ),
                      ],
                    ),
            ),
    );
  }
}
