import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_on_get_it/constants/app_images.dart';
import 'package:go_on_get_it/constants/color_constants.dart';
import 'package:go_on_get_it/constants/font_constants.dart';
import 'package:go_on_get_it/data/local/my_hive.dart';
import 'package:go_on_get_it/screens/location/controller/location_controller.dart';
import 'package:go_on_get_it/screens/location/controller/main_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import '/data/local/user_location.dart';

class LocationScreen extends StatelessWidget {
  LocationScreen({Key? key}) : super(key: key);

  LocationController controller = Get.find<LocationController>();
  static MainController mainController = Get.find<MainController>();
  late UserLocation loc = MyHive.getLocation();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SizedBox(
            height: Get.height,
            width: Get.width,
            child: GoogleMap(
              mapType: MapType.normal,
              buildingsEnabled: true,
              zoomControlsEnabled: true,
              compassEnabled: true,
              indoorViewEnabled: true,
              trafficEnabled: true,
              //markers: controller.markers,
              zoomGesturesEnabled: true,
              myLocationEnabled: true,
              //polylines: controller.polylines,
              scrollGesturesEnabled: true,
              initialCameraPosition: controller.kGooglePlex,
              onMapCreated: (GoogleMapController c) async {
                loc = MyHive.getLocation();
                controller.mapController = c;
                await controller.determinePosition();
              },
              markers: <Marker>{
                Marker(
                  draggable: true,
                  markerId: const MarkerId("1"),
                  position: LatLng(loc.latitude, loc.longitude),
                  icon: BitmapDescriptor.defaultMarker,
                ),
              },
              onTap: controller.mapOnTap,
              rotateGesturesEnabled: true,
              tiltGesturesEnabled: true,
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            left: 10,
            child: Container(
              height: 30.h,
              width: Get.width,
              decoration: BoxDecoration(
                color: ColorConstants.whiteColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: ColorConstants.grayLight.withOpacity(0.5),
                      offset: const Offset(4, 4),
                      blurRadius: 14)
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'address'.tr,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: ColorConstants.appBlack,
                          fontSize: 14.5.sp,
                          fontFamily: FontConstants.sourceSansProSemiBold),
                    ),
                    SizedBox(
                      height: 1.0.h,
                    ),
                    Container(
                      height: 7.0.h,
                      alignment: Alignment.centerLeft,
                      color: Colors.transparent,
                      child: TextFormField(
                        controller: controller.locationController,
                        readOnly: true,
                        textAlignVertical: TextAlignVertical.bottom,
                        autofocus: false,
                        onTap: () => controller.searchPlaces(context),
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          // isDense: true,
                          contentPadding:
                              EdgeInsets.only(bottom: 3.h, right: 2.h),

                          ///this property helps us to remove text cut from bottom it makes text field to take less space from bottom
                          hintText: 'address'.tr,
                          hintStyle: const TextStyle(
                            color: ColorConstants.appBlack,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: ColorConstants.grayLight,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: ColorConstants.grayLight,
                              width: 1.0,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                            borderSide: const BorderSide(
                                color: ColorConstants.grayLight, width: 2.0),
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: ColorConstants.appBlack,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),

                    ///Confirm Location Button
                    SizedBox(
                      width: Get.width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: ColorConstants.parrotDark,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 13.sp,
                              fontFamily: FontConstants.sourceSansProSemiBold),
                        ),
                        onPressed: () async {
                          print(controller.locationController.text);
                          await controller.confirmLocation(context);

                          ///you can confirm your location here!
                        },
                        child: Text(
                          'confirmLocation'.tr,
                          style: const TextStyle(
                            color: ColorConstants.whiteColor,
                            fontFamily: FontConstants.sourceSansProRegular,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
              child: SvgPicture.asset(AppImages.backArrow),
            ),
          )
        ],
      ),
    );
  }
}
