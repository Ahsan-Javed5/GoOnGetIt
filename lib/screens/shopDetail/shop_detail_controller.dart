import 'dart:developer';

import 'package:get/get.dart';
import 'package:go_on_get_it/data/local/my_hive.dart';
import 'package:go_on_get_it/models/classes/shop.dart';
import 'package:go_on_get_it/models/classes/shops/near_to_expire_shop_items.dart';
import 'package:go_on_get_it/network/remote_repository.dart';

class SubSubCategoryController extends GetxController {
  List<ShopDataRows> shopList = <ShopDataRows>[].obs;
  List<ShopDataRows> shopFilterList = <ShopDataRows>[].obs;
  NearExpireShopData? nearToExpire;
  List<ShopItems>? nearExpireShopItems;
  RxBool isLoading = false.obs;
  RxBool isSearching = false.obs;
  RxBool isNoItems = false.obs;
  RxDouble distanceKm = 0.0.obs;
  RxBool isNearToExpireLoading = false.obs;
  RxBool isSeeAll = false.obs;

  @override
  void onInit() {
    super.onInit();
    getShops();
  }

  void getShopNearToExpire({required String id}) async {
    isNearToExpireLoading.value = true;
    Map<String, dynamic> nearToExpireMap = {
      'shop_id': id,
    };
    nearToExpire =
        (await RemoteRepository.getShopNearToExpire(nearToExpireMap));
    nearExpireShopItems = nearToExpire?.rows?.shopItems
        ?.where((i) => int.parse(i.quantity.toString()) != 0)
        .toList();
    isNearToExpireLoading.value = false;
  }

  Future<void> getShops(
      {String? filter, String? categoryId, bool showLoading = true}) async {
    isNoItems.value = false;
    if (showLoading) {
      isLoading.value = true;
    } else {
      isLoading.value = false;
    }
    var location = MyHive.getLocation();
    Map<String, dynamic> queryParams = {
      'filter': filter ?? 'catalog',
      'category_id': categoryId,
      'radius': MyHive.getRadius(),
      'lat': location == null ? 33.6541844 : location.latitude,
      'lng': location == null ? 73.0668133 : location.longitude,
      'limit': -1,
      'offset': 0
    };
    var radius = MyHive.getRadius();
    var lat = location.latitude;
    var lng = location.longitude;
    print('filter: $filter');
    print('category id: $categoryId');
    print('radius: $radius');
    print('lat: $lat');
    print('lng: $lng');
    print(MyHive.getToken());
    Future.delayed(500.milliseconds, () async {
      try {
        if (shopList.isNotEmpty) {
          shopList.clear();
        }
        List<ShopDataRows> list = <ShopDataRows>[];
        list = (await RemoteRepository.fetchShopsList(queryParams))
                ?.cast<ShopDataRows>() ??
            [];

        if (MyHive.getExpiredDiscount() == false) {
          for (int i = 0; i < list.length; i++) {
            list[i].offers!.removeWhere((offer) => offer.isExpired == 1);
            shopList.add(list[i]);
          }

          List _shopList = [];
          _shopList.addAll(shopList);

          for (var item in _shopList) {
            if (item.shopItems.isEmpty) {
              shopList.removeWhere((shop) => shop.offers!.isEmpty);
            }
          }
        } else {
          list.removeWhere((shop) => shop.offers!.isEmpty);
          shopList.addAll(list);
        }
      } finally {
        isLoading.value = false;
        if (shopList.isEmpty) {
          isNoItems.value = true;
        }
        print('Get shops Reached');
      }
    });
  }

  Future<void> getSearchedShops({String? filter, String? searchedTitle}) async {
    isNoItems.value = false;
    isLoading.value = true;
    var location = MyHive.getLocation();
    Map<String, dynamic> queryParams = {
      'filter': filter,
      // 'category_id': categoryId,
      // 'radius': 5000,
      'item': searchedTitle,
      'shop': searchedTitle,
      'lat': location.latitude,
      'lng': location.longitude,
      'limit': -1,
      'offset': 0
    };
    Future.delayed(500.milliseconds, () async {
      try {
        if (shopList.isNotEmpty) {
          shopList.clear();
        }
        List<ShopDataRows> _searchedList = <ShopDataRows>[];
        _searchedList = (await RemoteRepository.fetchShopsList(queryParams))
                ?.cast<ShopDataRows>() ??
            [];

        if (MyHive.getExpiredDiscount() == false) {
          for (int i = 0; i < _searchedList.length; i++) {
            _searchedList[i]
                .offers!
                .removeWhere((offer) => offer.isExpired == 1);
          }
          _searchedList.removeWhere((shop) => shop.offers!.isEmpty);
          shopList = _searchedList.toSet().toList();
        } else {
          _searchedList.removeWhere((shop) => shop.offers!.isEmpty);
          shopList = _searchedList.toSet().toList();
          // shopList.addAll(_searchedList);
        }
      } finally {
        isLoading.value = false;
        if (shopList.isEmpty) {
          isNoItems.value = true;
        }
        log('Get Searched shops Reached');
      }
    });
  }

  Future<void> addShopClick(int shopID) async {
    Map<String, dynamic> queryParams = {
      'shop_id': shopID,
    };
    try {
      var response = await RemoteRepository.addShopClick(queryParams);
      if (!response['error']) {
        log(response['message']);
      }
    } catch (e) {
      log('Exception in AddShopClick : $e');
    }
  }

  Future<void> addOfferClick(int offerID) async {
    Map<String, dynamic> queryParams = {
      'offer_id': offerID,
    };
    try {
      var response = await RemoteRepository.addOfferClick(queryParams);
      if (!response['error']) {
        log(response['message']);
      }
    } catch (e) {
      log('Exception in addOfferClick : $e');
    }
  }

  void getShopsFilter(String filterString) {
    if (filterString.isNotEmpty) {
      shopFilterList = shopList
          .where((element) =>
              element.name!.toLowerCase().contains(filterString.toLowerCase()))
          .toList();
      log(shopFilterList.length.toString());
    }
  }

  Future<void> getShopByOfferId(int id) async {
    Future.delayed(const Duration(seconds: 1), () {
      isLoading.value = true;
      Map<String, dynamic> queryParams = {
        'Offset': 0,
        'Limit': 10,
        'lat': 26.7730,
        'lng': 26.7730,
      };
      Future.delayed(500.milliseconds, () async {
        try {
          distanceKm.value =
              (await RemoteRepository.getShopById(queryParams, id))!;
        } finally {
          print('Get shops By Id Reached');
        }
      });
      isLoading.value = false;
    });
  }
}
