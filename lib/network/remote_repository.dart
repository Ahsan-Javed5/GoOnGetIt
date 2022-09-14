import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:go_on_get_it/data/local/my_hive.dart';
import 'package:go_on_get_it/models/classes/catagories/catagories_data.dart';
import 'package:go_on_get_it/models/classes/favorite/favorite.dart';
import 'package:go_on_get_it/models/classes/near_to_expire/near_to_expire.dart';
import 'package:go_on_get_it/models/classes/notifications/notifications_data.dart';
import 'package:go_on_get_it/models/classes/notifications/notifications_list_data.dart';
import 'package:go_on_get_it/models/classes/shop.dart';
import 'package:go_on_get_it/models/classes/shops/latestShops.dart';
import 'package:go_on_get_it/models/classes/shops/near_to_expire_shop_items.dart';
import 'package:go_on_get_it/models/classes/sub_category.dart';
import 'package:go_on_get_it/models/classes/user_data.dart';
import 'package:go_on_get_it/network/base_response.dart';
import 'package:go_on_get_it/network/remote_services.dart';

class RemoteRepository {
  static Future<List<NotificationDataRows>?> fetchNotificationList(
      Map<String, dynamic> query) async {
    final response =
        await GetIt.I<RemoteServices>().getRequest('user/notifications', query);
    if (response == null) {
      return null;
    }
    BaseResponse baseResponse = BaseResponse<dynamic>.fromJson(
        response, (data) => NotificationsData.fromJson(data));
    if (baseResponse.error != null && !baseResponse.error!) {
      NotificationsData data = baseResponse.data;
      if (data.rows != null && data.rows!.isNotEmpty) {
        return data.rows!.map((v) => v).toList();
      }
    }
    return null;
  }

  static Future<List<FavoriteDataRows?>?> fetchFavoriteList(
      Map<String, dynamic> query) async {
    final response =
        await GetIt.I<RemoteServices>().getRequest('user/get_favorites', query);
    if (response == null) {
      return null;
    }
    BaseResponse baseResponse = BaseResponse<dynamic>.fromJson(
        response, (data) => FavoriteData.fromJson(data));
    if (baseResponse.error != null && !baseResponse.error!) {
      FavoriteData data = baseResponse.data;
      if (data.rows != null && data.rows!.isNotEmpty) {
        return data.rows!.map((v) => v).toList();
      }
    }
    return null;
  }

  static Future<List<SubCategoryDataRows>?> fetchSubCategoryList(
      Map<String, dynamic> query) async {
    final response = await GetIt.I<RemoteServices>()
        .getRequest('user/sub_categories', query);
    if (response == null) {
      return null;
    }
    BaseResponse baseResponse = BaseResponse<dynamic>.fromJson(
        response, (data) => SubCategoryDataRows.fromJson(data));
    if (baseResponse.error != null && !baseResponse.error!) {
      List<SubCategoryDataRows> data = [];
      for (var item in baseResponse.data) {
        data.add(item);
      }
      return data;
    }
    return null;
  }

  static Future<List<ShopDataRows?>?> fetchShopsList(
      Map<String, dynamic> query) async {
    final response =
        await GetIt.I<RemoteServices>().getRequest('user/shops', query);
    if (response == null) {
      return null;
    }
    BaseResponse baseResponse = BaseResponse<dynamic>.fromJson(
        response, (data) => ShopData.fromJson(data));
    if (baseResponse.error != null && !baseResponse.error!) {
      ShopData data = baseResponse.data;
      if (data.rows != null && data.rows!.isNotEmpty) {
        return data.rows!.map((v) => v).toList();
      }
    }
    return null;
  }

  static Future<bool> userAuth(Map<String, dynamic> query) async {
    print('user auth');
    final response =
        await GetIt.I<RemoteServices>().postRequest('user/login', query);
    if (response == null) {
      return true;
    }
    BaseResponse baseResponse = BaseResponse<dynamic>.fromJson(
        response, (data) => UserData.fromJson(data));
    if (baseResponse.error != null && !baseResponse.error!) {
      var user = baseResponse.data;
      for (int i = 0; i < user.length; i++) {
        MyHive.setToken("Bearer " + baseResponse.data[i].token);
      }
      return false;
    }
    return true;
  }

  static Future<List<CategoriesData>?> getCategories(
      Map<String, dynamic> query) async {
    final response =
        await GetIt.I<RemoteServices>().getRequest('user/categories', query);
    if (response == null) {
      return null;
    }
    BaseResponse baseResponse = BaseResponse<dynamic>.fromJson(
        response, (data) => CategoriesData.fromJson(data));
    if (baseResponse.error != null && !baseResponse.error!) {
      List<CategoriesData> data = [];
      for (var item in baseResponse.data) {
        data.add(item);
      }
      return data;
    }
    return null;
  }

  static Future<List<NearExpireRows?>?> getNearToExpire(
      Map<String, dynamic> query) async {
    try {
      final response = await GetIt.I<RemoteServices>()
          .getRequest('user/near_to_expire_item', query);
      if (response == null) {
        return null;
      }
      BaseResponse baseResponse = BaseResponse<dynamic>.fromJson(
          response, (data) => NearExpireData.fromJson(data));
      if (baseResponse.error != null && !baseResponse.error!) {
        NearExpireData data = baseResponse.data;
        if (data.rows != null && data.rows!.isNotEmpty) {
          return data.rows!.map((v) => v).toList();
        }
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<NearExpireShopData?> getShopNearToExpire(
      Map<String, dynamic> query) async {
    final response =
        await GetIt.I<RemoteServices>().getRequest('user/shop_items', query);
    if (response == null) {
      print('response is null');
      return null;
    }
    print('get near expire in remote service and response in not null');

    BaseResponse baseResponse = BaseResponse<dynamic>.fromJson(
        response, (data) => NearExpireShopData.fromJson(data));
    if (baseResponse.error != null && !baseResponse.error!) {
      return baseResponse.data;
    }
    return null;
  }

  static Future<double?> getShopById(
      Map<String, dynamic> query, int? id) async {
    final response =
        await GetIt.I<RemoteServices>().getRequest('user/offers/$id', query);
    if (response == null) {
      return null;
    }
    return response['data']['shop']['distance_km'];
  }

  static Future<dynamic> getShops(Map<String, dynamic> query) async {
    final response = await GetIt.I<RemoteServices>()
        .getRequest('user/popular_latest', query);
    if (response == null) {
      return null;
    }
    BaseResponse baseResponse =
        BaseResponse<dynamic>.fromJson(response, (data) => Data.fromJson(data));
    if (baseResponse.error != null && !baseResponse.error!) {
      return baseResponse.data;
    }
    return null;
  }

  static Future<void> postReport(Map<String, dynamic> query) async {
    final response = await GetIt.I<RemoteServices>()
        .postRequest('user/submit_report', query);
    if (response == null) {
      return;
    }
  }

  static Future<void> postReserve(Map<String, dynamic> query) async {
    try {
      final response = await GetIt.I<RemoteServices>()
          .postRequest('user/reserve_shop_items', {}, queryParams: query);
      if (response == null) {
        return;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  static contactUs(Map<String, dynamic> formData) async {
    final response = await GetIt.I<RemoteServices>()
        .postRequest('user/contact_us', formData);
    if (response == null) {
      return;
    }
  }

  static toggleLike(Map<String, dynamic> formData) async {
    final response = await GetIt.I<RemoteServices>()
        .postRequest('user/toggle_like', formData);
    if (response == null) {
      return null;
    }
    return response;
  }

  static addShopClick(Map<String, dynamic> formData) async {
    final response = await GetIt.I<RemoteServices>()
        .postRequest('user/add_shop_click', formData);
    if (response != null) {
      return response;
    } else {
      return null;
    }
  }

  static addOfferClick(Map<String, dynamic> formData) async {
    final response = await GetIt.I<RemoteServices>()
        .postRequest('user/add_offer_click', formData);
    if (response != null) {
      return response;
    } else {
      return null;
    }
  }

  static setNotificationSeen(Map<String, dynamic> formData) async {
    final response = await GetIt.I<RemoteServices>()
        .postRequest('user/notification/is_seen', formData);
    if (response == null) {
      return null;
    }
    return response;
  }
}
