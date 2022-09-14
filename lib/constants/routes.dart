import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:go_on_get_it/screens/about_us/aboutus_screen.dart';
import 'package:go_on_get_it/screens/categories/sub_category_screen.dart';
import 'package:go_on_get_it/screens/categories/shop_screen.dart';
import 'package:go_on_get_it/screens/categories/sub_sub_category_screen.dart';
import 'package:go_on_get_it/screens/contact/contact_us.dart';
import 'package:go_on_get_it/screens/favourite/favourite_screen.dart';
import 'package:go_on_get_it/screens/home/home_screen.dart';
import 'package:go_on_get_it/screens/landing/walk_through_page_one.dart';
import 'package:go_on_get_it/screens/landing/walk_through_page_three.dart';
import 'package:go_on_get_it/screens/landing/walk_through_page_two.dart';
import 'package:go_on_get_it/screens/language/language_screen.dart';
import 'package:go_on_get_it/screens/location/view/location_screen.dart';
import 'package:go_on_get_it/screens/near_to_expire/near_to_expire_see_all.dart';
import 'package:go_on_get_it/screens/near_to_expire/near_to_expire_shop_see_all.dart';
import 'package:go_on_get_it/screens/near_to_expire/near_to_expire_sub_screen.dart';
import 'package:go_on_get_it/screens/notification/near_to_expire_notification.dart';
import 'package:go_on_get_it/screens/notification/notification_screen.dart';
import 'package:go_on_get_it/screens/shopDetail/shop_detail_screen.dart';
import 'package:go_on_get_it/screens/shop_location.dart';
import 'package:go_on_get_it/screens/splash_screen.dart';
import 'package:go_on_get_it/screens/unknown_route.dart';

class Routes {
  //App ase URL
  // static const String baseUrl = 'https://814b-115-186-141-41.ngrok.io/';
  // static const String baseUrl = 'https://backend-fitness.codesorbit.net/';
  static const String baseUrl = 'https://api.fitandmore.app/';

  static const String noPageFound = '/noPageFound';
  static const String shopLocation = '/ShopLocation';
  static const String walkThroughFirst = '/walkThroughFirst';
  static const String walkThroughSecond = '/walkThroughSecond';
  static const String walkThroughThird = '/walkThroughThird';
  static const String home = '/home';
  static const String homeScreen = '/homeScreen';
  static const String notificationScreen = '/notificationScreen';
  static const String favoriteScreen = '/favoriteScreen';
  static const String languageScreen = '/languageScreen';
  static const String aboutUsScreen = '/aboutUsScreen';
  static const String shopScreen = '/shopScreen';
  static const String subSubCategoryScreen = '/SubSubCategoryScreen';
  static const String contactus = '/contactus';
  static const String nextToCatalogIndividualScreen =
      '/nextToCatalogIndividualScreen';
  static const String locationScreen = '/locationScreen';
  static const String catalog2Screen = '/catalog2Screen';
  static const String nearToExpireSeeAll = '/nearToExpireSeeAll';
  static const String nearToExpireShopSeeAll = '/nearToExpireShopSeeAll';
  static const String nearToExpireSubScreen = '/nearToExpireSubScreen';
  static const String nearToExpireNotification = '/nearToExpireNotification';
  static const String splashScreen = '/splashScreen';

  static getUnknownRoute() {
    return GetPage(
      name: noPageFound,
      page: () => const UnknownRoutePage(),
      transition: Transition.zoom,
    );
  }

  static getInitialRoute() {
    return splashScreen;
  }

  static getPages() {
    return [
      GetPage(
        name: splashScreen,
        page: () => const SplashScreen(),
      ),
      GetPage(
        name: walkThroughFirst,
        page: () => const WalkThroughFirst(),
      ),
      GetPage(
        name: walkThroughSecond,
        page: () => const WalkThroughSecond(),
      ),
      GetPage(
        name: walkThroughThird,
        page: () => const WalkThroughThird(),
      ),
      GetPage(
        name: homeScreen,
        page: () => HomeScreen(),
      ),
      GetPage(
        name: notificationScreen,
        page: () => NotificationListScreen(),
      ),
      GetPage(
        name: favoriteScreen,
        page: () => FavoriteListScreen(),
      ),
      GetPage(
        name: languageScreen,
        page: () => const LanguageScreen(),
      ),
      GetPage(
        name: aboutUsScreen,
        page: () => const AboutUsScreen(),
      ),
      GetPage(
        name: contactus,
        page: () => ContactUs(),
      ),
      GetPage(
        name: nextToCatalogIndividualScreen,
        page: () => const ShopDetailScreen(),
      ),
      GetPage(
        name: locationScreen,
        page: () => LocationScreen(),
      ),
      GetPage(
        name: catalog2Screen,
        page: () => SubCategoryScreen(),
      ),
      GetPage(
        name: shopLocation,
        page: () => const ShopLocation(),
      ),
      GetPage(
        name: shopScreen,
        page: () => const ShopScreen(),
      ),
      GetPage(
        name: subSubCategoryScreen,
        page: () => const SubSubCategoryScreen(),
      ),
      GetPage(
        name: nearToExpireSeeAll,
        page: () => const NearToExpireSeeAll(),
      ),
      GetPage(
        name: nearToExpireSubScreen,
        page: () => const NearToExpireSubScreen(),
      ),
      GetPage(
        name: nearToExpireShopSeeAll,
        page: () => const NearToExpireShopSeeAll(),
      ),
      GetPage(
        name: nearToExpireNotification,
        page: () => const NearToExpireNotification(),
      ),
    ];
  }

  static to(String route, {Map<String, dynamic>? arguments}) =>
      Get.toNamed(route, arguments: arguments);

  static offAllTo(String route, {Map<String, dynamic>? arguments}) =>
      Get.offAllNamed(route, arguments: arguments);

  static offTo(String route, {Map<String, dynamic>? arguments}) =>
      Get.offNamed(route, arguments: arguments);

  static back() => Get.back();
}
