import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:go_on_get_it/data/local/user_location.dart';
import 'package:go_on_get_it/models/classes/notifications/notifications_list_data.dart';
import 'package:go_on_get_it/network/remote_repository.dart';
import '/data/local/my_hive.dart';

class NotificationController extends GetxController {
  RxList<NotificationDataRows> notificationList = <NotificationDataRows>[].obs;

  int limit = 10;
  int offset = 0;
  var type = 'new';
  var isLoading = false.obs;
  late ShopItemsNotification itemDetail;

  @override
  void onInit() {
    fetchNotificationData(MyHive.getLocation());
    super.onInit();
  }

  Future<void> fetchNotificationData(UserLocation location) async {
    isLoading.value = true;
    Map<String, dynamic> queryParams = {
      'limit': limit,
      'offset': offset,
      'text': type,
      'lat': location.latitude,
      'lng': location.longitude,
    };
    Future.delayed(500.milliseconds, () async {
      try {
        notificationList.value =
            await RemoteRepository.fetchNotificationList(queryParams) ?? [];
        if (kDebugMode) print(notificationList);

        if (MyHive.getExpiredDiscount() == false) {
          for (int i = 0; i < notificationList.length; i++) {
            notificationList[i]
                .shopOwner
                ?.offers!
                .removeWhere((offer) => offer.isExpired == 1);
            notificationList[i].shopOwner?.shopItems!.removeWhere(
                (item) => int.parse(item.quantity.toString()) == 0);
          }
          notificationList.removeWhere((shop) =>
              ((shop.shopOwner!.offers!.isEmpty &&
                      shop.shopOwner!.offers!.isEmpty) &&
                  shop.notificationType == 'offer'));

          notificationList.removeWhere((shop) =>
              (shop.shopOwner!.shopItems!.isEmpty &&
                  shop.notificationType == 'item'));

          List<NotificationDataRows> _notificationList = notificationList;

          for (int i = 0; i < _notificationList.length; i++) {
            bool check = false;
            if (_notificationList[i].notificationType == 'item') {
              for (int j = 0;
                  j < _notificationList[i].shopOwner!.shopItems!.length;
                  j++) {
                if (_notificationList[i].itemId ==
                    _notificationList[i].shopOwner!.shopItems![j].id) {
                  check = true;
                  break;
                }
              }
            }
            if (check == false) {
              notificationList.removeAt(i);
            }
          }
        } else {
          for (int i = 0; i < notificationList.length; i++) {
            notificationList[i].shopOwner!.shopItems!.removeWhere(
                (item) => int.parse(item.quantity.toString()) == 0);
          }
          notificationList.removeWhere((shop) =>
              ((shop.shopOwner!.offers!.isEmpty &&
                      shop.shopOwner!.offers!.isEmpty) &&
                  shop.notificationType == 'offer'));

          notificationList.removeWhere((shop) =>
              (shop.shopOwner!.shopItems!.isEmpty &&
                  shop.notificationType == 'item'));

          List<NotificationDataRows> _notificationList = notificationList;

          for (int i = 0; i < _notificationList.length; i++) {
            bool check = false;
            if (_notificationList[i].notificationType == 'item') {
              for (int j = 0;
                  j < _notificationList[i].shopOwner!.shopItems!.length;
                  j++) {
                if (_notificationList[i].itemId ==
                    _notificationList[i].shopOwner!.shopItems![j].id) {
                  check = true;
                  break;
                }
              }
            }
            if (check == false) {
              notificationList.removeAt(i);
            }
          }
        }
      } finally {
        isLoading.value = false;
        update();
      }
    });
  }
}
