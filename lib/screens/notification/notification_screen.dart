import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_on_get_it/constants/app_images.dart';
import 'package:go_on_get_it/constants/font_constants.dart';
import 'package:go_on_get_it/constants/routes.dart';
import 'package:go_on_get_it/data/local/my_hive.dart';
import 'package:go_on_get_it/screens/notification/notification_controller.dart';
import 'package:go_on_get_it/utils/utils.dart';
import 'package:go_on_get_it/widgets/back_arrow.dart';
import 'package:go_on_get_it/widgets/notification_list_shimmer.dart';
import 'package:sizer/sizer.dart';

import '../shopDetail/shop_detail_controller.dart';
import '/widgets/notification_individual_item.dart';

class NotificationListScreen extends StatelessWidget {
  NotificationListScreen({Key? key}) : super(key: key);
  final NotificationController notificationController =
      Get.put(NotificationController());
  final SubSubCategoryController shopDetailController =
      Get.find<SubSubCategoryController>();
  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool _isMobileLayout = shortestSide < 600;
    notificationController.fetchNotificationData(MyHive.getLocation());
    return Obx(() => notificationController.isLoading.value
        ? const NotificationListShimmer()
        : Scaffold(
            key: UniqueKey(),
            resizeToAvoidBottomInset: false,
            appBar: _isMobileLayout
                ? AppBar(
                    leading: BackArrow(),
                    title: Align(
                      alignment: Alignment.centerLeft,
                      child: Transform(
                        transform: Matrix4.translationValues(-10, 6.0, 0.0),
                        child: Padding(
                          padding: EdgeInsets.only(left: 1.w),
                          child: Text(
                            'Notifications'.tr,
                            style: TextStyle(
                              fontFamily: FontConstants.sourceSansProSemiBold,
                              color: Colors.black,
                              fontSize: 15.sp,
                            ),
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
                        child: Text(
                          'Notifications'.tr,
                          style: TextStyle(
                            fontFamily: FontConstants.sourceSansProSemiBold,
                            color: Colors.black,
                            fontSize: 10.sp,
                          ),
                        ),
                      ),
                    ),
                    titleSpacing: 0.7.w,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
            body: GetBuilder<NotificationController>(builder: (controller) {
              return controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    AppImages.notificationBackground),
                                alignment: Alignment.bottomCenter,
                              ),
                            ),
                            //height: MediaQuery.of(context).size.height * 0.76,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 4.w, right: 4.w, top: 3.h),
                              child: ListView.builder(
                                shrinkWrap: false,
                                itemCount: controller.notificationList.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () async {
                                      shopDetailController.getShopNearToExpire(
                                          id: controller
                                              .notificationList[index].shopId
                                              .toString());
                                      if (controller.notificationList[index]
                                              .notificationType ==
                                          'offer') {
                                        await Get.toNamed(
                                            Routes
                                                .nextToCatalogIndividualScreen,
                                            arguments: {
                                              'iconUrl':
                                                  '${Utils.BASE_URL}${controller.notificationList[index].shopOwner?.shopLogo}',
                                              'title': controller
                                                  .notificationList[index]
                                                  .shopOwner!
                                                  .name,
                                              'address': controller
                                                  .notificationList[index]
                                                  .shopOwner
                                                  ?.address,
                                              'id': controller
                                                  .notificationList[index].id,
                                              'shop_id': controller
                                                  .notificationList[index]
                                                  .shopId,
                                              'phone': controller
                                                  .notificationList[index]
                                                  .shopOwner
                                                  ?.phone,
                                              'isLiked': controller
                                                          .notificationList[
                                                              index]
                                                          .shopOwner
                                                          ?.isLiked ==
                                                      1
                                                  ? true.obs
                                                  : false.obs,
                                              'offers': controller
                                                  .notificationList[index]
                                                  .shopOwner
                                                  ?.offers,
                                              'location': {
                                                'lat': controller
                                                    .notificationList[index]
                                                    .shopOwner
                                                    ?.lat
                                                    .toString(),
                                                'long': controller
                                                    .notificationList[index]
                                                    .shopOwner
                                                    ?.long
                                                    .toString(),
                                                'distanceInKm': controller
                                                    .notificationList[index]
                                                    .shopOwner
                                                    ?.distanceKm
                                                    .toString(),
                                                // 'distanceInKm': controller.notificationList[index].shopOwner?.distanceKm.toString()
                                              }
                                            });
                                        notificationController.onInit();
                                      } else {
                                        await Get.toNamed(
                                          Routes.nearToExpireNotification,
                                          arguments: controller
                                              .notificationList[index],
                                        );
                                        notificationController.onInit();
                                      }
                                    },
                                    child: NotificationIndividualItem(
                                      controller
                                          .notificationList[index].title!.tr,
                                      controller.notificationList[index].body!,
                                      controller.notificationList[index]
                                              .shopOwner?.shopLogo ??
                                          AppImages.macdonaldRect,
                                      controller
                                          .notificationList[index].isSeen!,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
            }),
          ));
  }
}
