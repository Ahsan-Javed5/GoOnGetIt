import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:go_on_get_it/constants/color_constants.dart';
import 'package:go_on_get_it/constants/routes.dart';
import 'package:go_on_get_it/data/local/my_hive.dart';
import 'package:go_on_get_it/data/local/user_location.dart';
import 'package:go_on_get_it/models/classes/near_to_expire/near_to_expire.dart';
import 'package:go_on_get_it/network/remote_repository.dart';
import 'package:go_on_get_it/utils/utils.dart';
import 'package:go_on_get_it/widgets/allow_location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:sizer/sizer.dart';

class MainController extends GetxController {
  RxInt tappedIndex = 0.obs;
  RxInt catalogIndex = 0.obs;
  var isDropdownOpened = false.obs;
  bool isCatalogDropDown = false;
  RxString itemSelected = "10 Km".obs;
  RxString seletedItem = "allNearMe".tr.obs;
  OverlayEntry? radiusLay;
  RxString selectedCat = 'catalog'.tr.obs;
  OverlayEntry? catalogLay;
  RxBool isThroughShops = false.obs;
  var isNearToExpireLoading = false.obs;
  var isLoading = false.obs;
  RxBool isMapMakerLoading = false.obs;
  RxList categories = [].obs;
  RxList<NearExpireRows> nearToExpire = <NearExpireRows>[].obs;
  RxList popular = [].obs;
  RxList latest = [].obs;
  RxList totalShops = [].obs;
  RxList popularOffers = [].obs;
  final Set<Marker> shopMarkers = {};
  RxString locationAddress = 'Loading'.tr.obs;
  RxBool isFirstTime = false.obs;
  late GoogleMapController mapController;
  final Completer<GoogleMapController> completerController = Completer();
  final GoogleMapsPlaces places =
      GoogleMapsPlaces(apiKey: 'AIzaSyD0ETkUaNH0X0k7Yyjpa_6_o0KnS0sA90o');
  TextEditingController emailController = TextEditingController();
  TextEditingController reportController = TextEditingController();
  RxBool isLocationFetchedLoading = false.obs;
  Position? position;
  LatLng? latLng;
  RxString? quantity = ''.obs;
  RxString? totalPrice = ''.obs;
  RxBool isShopNearToExpire = true.obs;
  RxBool isNearExpireLoading = false.obs;
  RxBool isSeeAll = false.obs;

  @override
  void onInit() async {
    super.onInit();
    if (MyHive.getLocation() != null && MyHive.getToken() != null) {
      locationAddress.value = await findAddress(MyHive.getLocation());
      getNearToExpire();
      getCategories();
      getShops(MyHive.getLocation());
    } else {
      Future.delayed(100.milliseconds, () {
        Get.dialog(const AllowLocation(), barrierDismissible: false);
      });
    }
  }

  void navigate() async {
    var result = await Get.toNamed(Routes.locationScreen);
    updateLocation(result);
  }

  @override
  void disposeId(Object id) {
    super.disposeId(id);
    emailController.dispose();
    reportController.dispose();
  }

  Future<void> userAuth(UserLocation type, String deviceId) async {
    isLoading.value = true;
    Map<String, dynamic> loginMap = {
      'uid': deviceId,
      'lat': type.latitude,
      'lng': type.longitude,
    };
    isFirstTime.value = await RemoteRepository.userAuth(loginMap);
    if (!isFirstTime.value && Get.isDialogOpen != null) {
      Get.back();
      getCategories();
      getShops(MyHive.getLocation());
      getNearToExpire(radius: MyHive.getRadius());
    }
  }

  void getCategories({int radius = 10}) async {
    isLoading.value = true;
    var location = MyHive.getLocation();
    Map<String, dynamic> categoriesMap = {
      'lat': location.latitude,
      'lng': location.longitude,
      'radius': radius,
    };
    categories.value =
        await RemoteRepository.getCategories(categoriesMap) ?? [];
    isLoading.value = false;
  }

  Future<void> getNearToExpire({int radius = 10}) async {
    isNearToExpireLoading.value = true;
    var location = MyHive.getLocation();
    var r = MyHive.getRadius();
    Map<String, dynamic> nearToExpireMap = {
      'lat': location.latitude,
      'lng': location.longitude,
      'radius': r,
    };
    try {
      nearToExpire.clear();
      nearToExpire.value =
          (await RemoteRepository.getNearToExpire(nearToExpireMap))
                  ?.cast<NearExpireRows>() ??
              [];
      nearToExpire.value = nearToExpire
          .where((i) => int.parse(i.quantity.toString()) != 0)
          .toList();
      update();
      isNearToExpireLoading.value = false;
    } catch (e) {
      log(e.toString());
    }
  }

  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS

    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }

  showSearch(bool isShow) {
    isThroughShops.value = isShow;
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  ///initial Position
  final CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  ///current Location
  Future<void> determinePosition() async {
    isLocationFetchedLoading.value = true;
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    log('Permission status : $permission');
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    position = await getCurrentLocation();
    MyHive.setLocation(UserLocation(
        longitude: position!.longitude, latitude: position!.latitude));
    locationAddress.value = await findAddress(MyHive.getLocation());
    isLocationFetchedLoading.value = false;
    //if user first time
    // if (MyHive.getToken() == null) {
    //   var deviceId = await _getId() ?? '';
    //   userAuth(MyHive.getLocation(), deviceId);
    // }
  }

  void isDiscountOffer() async {
    if (MyHive.getToken() == null) {
      var deviceId = await _getId() ?? '';
      userAuth(MyHive.getLocation(), deviceId);
    }
    Get.back();
  }

  Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  void updateLocation(result) async {
    //if user first time from map....
    locationAddress.value = await findAddress(MyHive.getLocation());
    if (MyHive.getToken() == null) {
      var deviceId = await _getId() ?? '';
      userAuth(result, deviceId);
    } else {
      getCategories();
      getShops(MyHive.getLocation());
      getNearToExpire();
    }
  }

  Future<String> findAddress(UserLocation type) async {
    var placeMarkers =
        await placemarkFromCoordinates(type.latitude, type.longitude);
    for (var i in placeMarkers) {
      log('Location Name :${i.name}');
      log('Location Street :${i.street}');
      log('Location Country :${i.country}');
      log('Location Locality :${i.locality}');
      log('Location SubLocality :${i.subLocality}');
      log('Location Administrative Area :${i.administrativeArea}');
    }
    var secondIndex = placeMarkers[0];
    var completeAddress =
        "${secondIndex.subLocality} ${secondIndex.street} ${secondIndex.administrativeArea} ${secondIndex.country}";
    return completeAddress;
  }

  void getShops(location) async {
    Map<String, dynamic> shopMap = {
      'lat': location.latitude,
      'lng': location.longitude,
    };

    var value = await RemoteRepository.getShops(shopMap);

    List _latestList = [];
    List _popularList = [];

    latest.clear();
    for (var item in value.latest) {
      _latestList.add(item);
    }

    popular.clear();
    for (var item in value.popular) {
      _popularList.add(item);
    }

    if (MyHive.getExpiredDiscount() == false) {
      for (int i = 0; i < _latestList.length; i++) {
        _latestList[i].offers!.removeWhere((offer) => offer.isExpired == 1);
        latest.add(_latestList[i]);

        _popularList[i].offers!.removeWhere((offer) => offer.isExpired == 1);
        popular.add(_popularList[i]);
      }
      List _popularShops = [];
      _popularShops.addAll(popular);

      for (var item in _popularShops) {
        if (item.shopItems.isEmpty) {
          popular.removeWhere((shop) => shop.offers.isEmpty);
        }
      }

      List _latestShops = [];
      _latestShops.addAll(latest);
      for (var item in _latestShops) {
        if (item.shopItems.isEmpty) {
          latest.removeWhere((shop) => shop.offers.isEmpty);
        }
      }
      totalShops.addAll(latest);
      totalShops.addAll(popular);
    } else {
      _latestList.removeWhere((shop) => shop.offers!.isEmpty);
      latest.addAll(_latestList);
      totalShops.addAll(_latestList);

      _popularList.removeWhere((shop) => shop.offers!.isEmpty);
      popular.addAll(_popularList);
      totalShops.addAll(_popularList);
    }
    getAllShopsMarkers();
  }

  getAllShopsMarkers() async {
    isMapMakerLoading.value = true;
    print('LEN: ${totalShops.length}');
    for (int i = 0; i < totalShops.length; i++) {
      String _shopLogo = totalShops[i].shopLogo == null
          ? 'https://www.pngitem.com/pimgs/m/400-4001128_mcdonald-s-logo-png-transparent-background-mcdonalds-logo.png'
          : Utils.BASE_URL + totalShops[i].shopLogo;
      final resizedMarkerImageBytes =
          await getShopImagesAsBitMap(shopLogo: _shopLogo);
      var lat = double.tryParse(totalShops[i].lat) ?? 0;
      var long = double.tryParse(totalShops[i].long) ?? 0;
      shopMarkers.add(Marker(
        markerId: MarkerId(i.toString()),
        position: LatLng(lat, long), //position of marker
        icon: BitmapDescriptor.fromBytes(resizedMarkerImageBytes),
        infoWindow: InfoWindow(
          title: totalShops[i].name,
        ),
      ));
    }
    isMapMakerLoading.value = false;
  }

  ///post report api
  void postReport() async {
    setLoading(true);
    Map<String, dynamic> reportMap = {
      "email": emailController.value.text,
      "description": reportController.value.text
    };
    await RemoteRepository.postReport(reportMap);
    setLoading(false);
    Get.back();
    emailController.clear();
    reportController.clear();
  }

  void postReserve(
      int id, String name, String quantity, String dateTime) async {
    setLoading(true);
    final MainController mainController = Get.find<MainController>();
    Map<String, dynamic> reserveMap = {
      'item_id': id,
      'quantity': quantity,
      'pickup_time': dateTime,
      'customer_name': name,
    };
    await RemoteRepository.postReserve(reserveMap);
    await mainController.getNearToExpire();
    setLoading(false);
    Get.snackbar(
      'Reservation Completed',
      '',
      instantInit: true,
      colorText: ColorConstants.whiteColor,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: ColorConstants.parrotGreen,
    );
    Get.offAndToNamed(Routes.homeScreen);
    //Get.back();
  }

  ///loader.....
  void setLoading(bool isLoading) {
    if (isLoading && !Get.isDialogOpen!) {
      Get.defaultDialog(
        title: "",
        content: const CircularProgressIndicator(strokeWidth: 4),
      );
    } else if (Get.isDialogOpen!) {
      Get.back();
    }
  }

  void contact(Map<String, dynamic> formData) async {
    setLoading(true);
    await RemoteRepository.contactUs(formData);
    setLoading(false);
  }

  Future<Uint8List> getShopImagesAsBitMap({required String shopLogo}) async {
    double _targetWidth = 12.h;
    final File markerImageFile =
        await DefaultCacheManager().getSingleFile(shopLogo);
    final Uint8List markerImageBytes = await markerImageFile.readAsBytes();

    final Codec markerImageCodec = await instantiateImageCodec(
      markerImageBytes,
      targetWidth: _targetWidth.toInt(),
    );

    final FrameInfo frameInfo = await markerImageCodec.getNextFrame();
    final ByteData? byteData = await frameInfo.image.toByteData(
      format: ImageByteFormat.png,
    );

    final Uint8List resizedMarkerImageBytes = byteData!.buffer.asUint8List();
    return resizedMarkerImageBytes;
  }
}
