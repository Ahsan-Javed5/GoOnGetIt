import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_on_get_it/constants/color_constants.dart';
import 'package:go_on_get_it/models/enums/locale_type.dart';
import 'package:intl/intl.dart'; //for date format
import 'package:path_provider/path_provider.dart';

class Utils {
  ///user currency name and rate against USD

  //static String BASE_URL = "https://backend.goongetit.codesorbit.net/api/";
  static String BASE_URL = "https://backend.goongetit.codesorbit.net/";
  static var userLocation = ''.obs;

  static bool isRTL() {
    return Get.locale?.languageCode == 'fr';
  }

  static Locale getLocaleFromLocaleType(LocaleType type) {
    if (type == LocaleType.en) {
      return const Locale('en', 'US');
    } else {
      return const Locale('fr', 'FR');
    }
  }

  static String formatDateTime(String timestamp,
      {String format = 'dd MMM, yyyy'}) {
    var lc = Get.locale?.languageCode;
    if (timestamp.isEmpty) return '';
    final formattedTimestamp = DateTime.parse(timestamp);

    return DateFormat(format, lc).format(formattedTimestamp);
  }

  static String getMonthNameFromDate(String timestamp,
      {String format = 'MMMM'}) {
    if (timestamp.isEmpty) return '';
    final formattedTimestamp = DateTime.parse(timestamp);
    return DateFormat(format).format(formattedTimestamp);
  }

  static Future<File?> uInt8ListToTempImageFile(Uint8List image) async {
    File? thumbnailFile;
    try {
      final tempDir = await getTemporaryDirectory();
      thumbnailFile = await File('${tempDir.path}/image.jpg').create();
      thumbnailFile.writeAsBytesSync(image);
    } catch (e) {
      e.printError();
    }

    return thumbnailFile;
  }

  /// This method is used to get the id of a object when we give the value of the object
  /// for example if we provide List<Country> and v is 'Qatar' then it will return the
  /// id of the Qatar country in the list of countries
  /// Pseudo code
  /// Get List<Objects>
  /// Convert into Map<k,v> where key will be the name and value will be the id
  /// [localizedCheck] if set to true will check arabic and English strings
  /// otherwise it will only check for English name
  static String getIdOfValue(List<dynamic> l, String v,
      {bool localizedCheck = false}) {
    var map = localizedCheck
        ? {for (var v in l) v.localizedName: v.id}
        : {for (var v in l) v.name: v.id};
    return map[v].toString();
  }

  static void showSnack(String title, String msg, {bool isError = false}) {
    String filteredMessage = (msg.toLowerCase().contains('timeout') ||
            msg.toLowerCase().contains('socket'))
        ? 'Please check your internet'
        : msg.tr;
    Get.snackbar(
      title.tr,
      filteredMessage,
      backgroundColor:
          isError ? ColorConstants.redButtonBackground : ColorConstants.appBlue,
      colorText: ColorConstants.whiteColor,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(10),
    );
  }

  static Route createRoute(Widget screenToRoute) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screenToRoute,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static String getDate(String dateTime) {
    DateTime input =
        DateFormat('yyyy-MM-DDTHH:mm:ss.SSSSSSZ').parse(dateTime, true);
    return DateFormat('EEEE MMMM yy').format(input);
  }

  static String getTime(String dateTime) {
    DateTime input =
        DateFormat('yyyy-MM-DDTHH:mm:ss.SSSSSSZ').parse(dateTime, true);
    return DateFormat('h a').format(input);
  }

  static void navigateToNextScreen(BuildContext context, Widget widget) {
    Navigator.of(context).push(createRoute(widget));
  }

  ///decrypt string
}
