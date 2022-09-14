import 'dart:developer';

import 'package:get/get.dart';
import 'package:go_on_get_it/data/local/my_hive.dart';
import 'package:go_on_get_it/models/classes/favorite/favorite.dart';
import 'package:go_on_get_it/network/remote_repository.dart';

class FavoriteController extends GetxController {
  RxList<FavoriteDataRows>? favoriteList = <FavoriteDataRows>[].obs;
  List<FavoriteDataRows> favoriteSearchedList = <FavoriteDataRows>[].obs;
  RxBool isNoSearchItems = false.obs;
  RxBool isFav = true.obs;
  var text = 'op';
  int limit = 10;
  int offset = 0;
  var isLoading = false.obs;

  Future<void> fetchFavoriteListData({bool showLoading = true}) async {
    dynamic location = MyHive.getLocation();
    if (showLoading) {
      isLoading.value = true;
    } else {
      isLoading.value = false;
    }
    Map<String, dynamic> queryParams = {
      'lat': location.latitude,
      'lng': location.longitude,
    };
    Future.delayed(500.milliseconds, () async {
      try {
        favoriteList?.value =
            (await RemoteRepository.fetchFavoriteList(queryParams))
                    ?.cast<FavoriteDataRows>() ??
                [];

        if (MyHive.getExpiredDiscount() == false) {
          for (int i = 0; i < favoriteList!.length; i++) {
            favoriteList![i]
                .Offers!
                .removeWhere((offer) => offer!.isExpired == 1);
            favoriteList![i].shopItems!.removeWhere(
                (item) => int.parse(item!.quantity.toString()) == 0);
          }
          favoriteList?.removeWhere(
              (shop) => (shop.shopItems!.isEmpty && shop.Offers!.isEmpty));
        } else {
          for (int i = 0; i < favoriteList!.length; i++) {
            favoriteList![i].shopItems!.removeWhere(
                (item) => int.parse(item!.quantity.toString()) == 0);
          }
          favoriteList?.removeWhere(
              (shop) => (shop.shopItems!.isEmpty && shop.Offers!.isEmpty));
        }
      } finally {
        isLoading.value = false;
      }
    });
  }

  void fetchFavoriteSearch({required String value, Function()? updateList}) {
    isNoSearchItems.value = false;
    favoriteSearchedList.clear();
    // favoriteSearchedList.addAll(favoriteList!);
    if (value.length > 1) {
      for (var favItem in favoriteList!) {
        if (favItem.name!.toLowerCase().contains(value.toLowerCase())) {
          favoriteSearchedList.add(favItem);
        }
      }
      updateList!();
      if (favoriteSearchedList.isEmpty) {
        isNoSearchItems.value = true;
      }
    } else {
      favoriteSearchedList.clear();
    }
  }

  Future<bool> favoriteToggle(int shopId) async {
    Map<String, dynamic> formData = {
      'shop_id': shopId,
    };
    dynamic response = await RemoteRepository.toggleLike(formData);
    if (!response['error']) {
      log(response.toString());
      return true;
    } else {
      return false;
    }
  }

  Future<bool> favoriteShopDetailToggle(int shopId) async {
    Map<String, dynamic> formData = {
      'shop_id': shopId,
    };
    dynamic response = await RemoteRepository.toggleLike(formData);
    if (response['message'] == 'Shop unliked successfully') {
      log(response.toString());
      return false;
    } else {
      return true;
    }
  }

  void notificationIsSeen() async {
    Map<String, dynamic> formData = {
      // 'notification_id':id,
    };
    await RemoteRepository.setNotificationSeen(formData);
  }
}
