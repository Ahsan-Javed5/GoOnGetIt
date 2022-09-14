import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:go_on_get_it/constants/color_constants.dart';
import 'package:go_on_get_it/data/local/my_hive.dart';
import 'package:go_on_get_it/data/local/user_location.dart';
import 'package:go_on_get_it/screens/location/controller/main_controller.dart';
import 'package:go_on_get_it/widgets/bottom_dialogue.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class LocationController extends GetxController {
  RxString locationAddress = "No Location".obs;
  late GoogleMapController mapController;
  final Completer<GoogleMapController> completerController = Completer();
  TextEditingController locationController = TextEditingController();
  Set<Polyline> polylines = <Polyline>{};
  List<LatLng> polylineCoordinates = [];
  Set<Marker> markers = <Marker>{};
  late PolylinePoints polylinePoints = PolylinePoints();
  final GoogleMapsPlaces places =
      GoogleMapsPlaces(apiKey: 'AIzaSyCu-ABefBRYdaO5NIEOEELDBIbjjPsx1tQ');
  final MainController _mainController = Get.find<MainController>();

  LocationController get getController => Get.find();

  @override
  void dispose() {
    mapController.dispose();
    locationController.dispose();

    super.dispose();
  }

  ///initial Position
  final CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  ///Camera Animatest
  Future<void> _animateCameraToLocation(double lat, double lng) async {
    await mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, lng),
          zoom: 18.7,
        ),
      ),
    );
  }

  mapOnTap(LatLng lattLong) async {
    log(lattLong.latitude.toString());
    await _animateCameraToLocation(lattLong.latitude, lattLong.longitude);
    locationController.text = await findAddress(latLng: lattLong);
  }

  ///current Location
  Future<void> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
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
    //Position position = await getCurrentLocation();
    UserLocation location = MyHive.getLocation();
    MyHive.setLocation(UserLocation(
        longitude: location.longitude, latitude: location.latitude));

    await _animateCameraToLocation(location.latitude, location.longitude);
    locationController.text = await findAddress(
        latLng: LatLng(location.latitude, location.longitude));
  }

  Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    await _animateCameraToLocation(position.latitude, position.longitude);
    return position;
  }

  Future<String> findAddress({required LatLng latLng}) async {
    var placeMarkers =
        await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    var completeAddress =
        '${placeMarkers.first.subLocality},${placeMarkers.first.locality},${placeMarkers.first.country}';
    return completeAddress;
  }

  /// for Places search
  Future<void> searchPlaces(BuildContext context) async {
    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: 'AIzaSyCu-ABefBRYdaO5NIEOEELDBIbjjPsx1tQ',
      onError: _onError,
      radius: 10000000,

      ///radius for area to search
      types: [],
      strictbounds: false,
      mode: Mode.overlay,
      language: 'en',
      decoration: InputDecoration(
        fillColor: Colors.white,
        hintText: 'Location',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      components: [Component(Component.country, 'pk')],
    );
    if (p != null) {
      await _displayPrediction(p, context);
    }
  }

  ///show places predictions
  Future<void> _displayPrediction(Prediction p, BuildContext context) async {
    if (p != null) {
      PlacesDetailsResponse detail =
          await places.getDetailsByPlaceId(p.placeId!);
      locationController.text = detail.result.formattedAddress!;
      MyHive.setLocation(UserLocation(
          longitude: detail.result.geometry!.location.lng,
          latitude: detail.result.geometry!.location.lat));
      _animateCameraToLocation(detail.result.geometry!.location.lat,
          detail.result.geometry!.location.lng);
    }
  }

  Future<void> confirmLocation(BuildContext context) async {
    _mainController.locationAddress.value = locationController.text;
    List locations =
        await locationFromAddress(_mainController.locationAddress.value);
    _mainController.latLng =
        LatLng(locations[0].latitude, locations[0].longitude);
    MyHive.setLocation(UserLocation(
        latitude: locations[0].latitude, longitude: locations[0].longitude));
    _mainController.position = null;

    ///for moving back to previous page
    Get.back(result: MyHive.getLocation(), canPop: true, closeOverlays: true);
    Get.dialog(
      BottomDialogue(),
      barrierDismissible: false,
    );
    // Get.until((route) => route.settings.name == '/homeScreen');
  }

  void _onError(PlacesAutocompleteResponse value) {
    Get.showSnackbar(GetSnackBar(
      title: 'Error',
      message: value.errorMessage,
    ));
  }

  Future<void> setPolyLines(
      {required double destinationLatitude,
      required double destinationLongitude}) async {
    LatLng desLocation = LatLng(destinationLatitude, destinationLongitude);
    Position userLocation = await getCurrentLocation();
    addPolylines(
        LatLng(
            _mainController.position == null
                ? _mainController.latLng!.latitude
                : userLocation.latitude,
            _mainController.position == null
                ? _mainController.latLng!.longitude
                : userLocation.longitude),
        desLocation);
    addMarkerToSet(desLocation);
    addMarkerToSet(LatLng(
        _mainController.position == null
            ? _mainController.latLng!.latitude
            : userLocation.latitude,
        _mainController.position == null
            ? _mainController.latLng!.longitude
            : userLocation.longitude));
    animateCameraToMakeVisibleBothMarkers(
        startLatitude: userLocation.latitude,
        startLongitude: userLocation.longitude,
        destinationLatitude: desLocation.latitude,
        destinationLongitude: desLocation.longitude);
    update();
  }

  void addPolylines(LatLng userLocation, LatLng desLocation) async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyCu-ABefBRYdaO5NIEOEELDBIbjjPsx1tQ',
      PointLatLng(userLocation.latitude, userLocation.longitude),
      PointLatLng(desLocation.latitude, desLocation.longitude),
    );
    polylineCoordinates.clear();
    for (var point in result.points) {
      ///addding points to corrdinates
      polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    }

    ///adding to polylines
    polylines.add(Polyline(
        width: 8,
        polylineId: const PolylineId('polyLine'),
        color: ColorConstants.parrotDark,
        points: polylineCoordinates));
    update();
  }

  void addMarkerToSet(LatLng locationOfMarker) {
    markers.add(Marker(
      markerId: MarkerId(locationOfMarker.toString()),
      position: locationOfMarker,
    ));
    update();
  }

  void animateCameraToMakeVisibleBothMarkers(
      {required double startLatitude,
      required double startLongitude,
      required double destinationLatitude,
      required double destinationLongitude}) {
    double miny = (startLatitude <= destinationLatitude)
        ? startLatitude
        : destinationLatitude;
    double minx = (startLongitude <= destinationLongitude)
        ? startLongitude
        : destinationLongitude;
    double maxy = (startLatitude <= destinationLatitude)
        ? destinationLatitude
        : startLatitude;
    double maxx = (startLongitude <= destinationLongitude)
        ? destinationLongitude
        : startLongitude;
    double southWestLatitude = miny;
    double southWestLongitude = minx;
    double northEastLatitude = maxy;
    double northEastLongitude = maxx;
    mapController.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          northeast: LatLng(northEastLatitude, northEastLongitude),
          southwest: LatLng(southWestLatitude, southWestLongitude),
        ),
        100.0,
      ),
    );
  }

  void clearAllMarkers() {
    markers.clear();
    update();
  }
}
