import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_on_get_it/constants/app_images.dart';
import 'package:go_on_get_it/constants/color_constants.dart';
import 'package:go_on_get_it/main.dart';
import 'package:go_on_get_it/screens/location/controller/location_controller.dart';
import 'package:go_on_get_it/screens/location/controller/main_controller.dart';
import 'package:go_on_get_it/screens/shopDetail/shop_detail_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

class ShopLocation extends StatelessWidget {
  const ShopLocation({Key? key}) : super(key: key);

  static LocationController controller = Get.find<LocationController>();
  static MainController mainController = Get.find<MainController>();
  static SubSubCategoryController shopDetailController = Get.find<SubSubCategoryController>();

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool _isMobileLayout = shortestSide < 600;
    String? _distanceInKm = Get.arguments['location']['distanceInKm'];
    int? _shopId = Get.arguments['shop_id'];
    controller.clearAllMarkers();
    if(_distanceInKm == null){
      shopDetailController.getShopByOfferId(_shopId!);
    }


    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SizedBox(
            height: Get.height,
            width: Get.width,
            child: GetBuilder<LocationController>(builder: (context) {
              return GoogleMap(
                mapType: MapType.normal,
                buildingsEnabled: true,
                zoomControlsEnabled: true,
                compassEnabled: true,
                markers: controller.markers,
                polylines: controller.polylines,
                zoomGesturesEnabled: true,
                myLocationEnabled: true,
                scrollGesturesEnabled: true,
                initialCameraPosition: CameraPosition(
                    target: LatLng(mainController.position?.latitude ?? mainController.latLng!.latitude, mainController.position?.longitude ?? mainController.latLng!.longitude),
                    zoom: 14.4746,
                    ),
                onMapCreated: (GoogleMapController c) async {
                  controller.mapController = c;
                  await controller.setPolyLines(destinationLatitude: double.parse(Get.arguments['location']['lat']), destinationLongitude: double.parse(Get.arguments['location']['long']));
                },
                onTap: controller.mapOnTap,
                rotateGesturesEnabled: true,
                tiltGesturesEnabled: true,
              );
            }),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: ColorConstants.parrotDark.withOpacity(0.2),
                      blurRadius: 15,
                      offset: const Offset(3, 3),
                    )
                  ],
                  color: ColorConstants.whiteColor,
                  borderRadius: BorderRadius.circular(3)),
              padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SvgPicture.asset(
                    AppImages.distanceIcon,
                    height: 2.h,
                    width: 2.h,
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Obx(() =>  shopDetailController.isLoading.value
                      ? Center(child: CircularProgressIndicator.adaptive())
                      : Text(
                    _distanceInKm == null
                        ? '${shopDetailController.distanceKm.toString()} Km'
                        : '${Get.arguments['location']['distanceInKm']} Km',
                    style: TextStyle(
                      fontSize: _isMobileLayout ? 10.sp : 7.sp,
                      color: Colors.green,
                    ),
                  ),)
                ],
              ),
            ),
          ),
          Positioned(
            top: 5.h,
            left: 4.w,
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: SvgPicture.asset(
                AppImages.backArrow,
              ),
            ),
          )
        ],
      ),
    );
  }
}
