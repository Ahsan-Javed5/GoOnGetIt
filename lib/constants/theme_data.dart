import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_on_get_it/constants/color_constants.dart';
import 'package:go_on_get_it/constants/font_constants.dart';
import 'package:sizer/sizer.dart';

ThemeData getAppThemeData() {
  return ThemeData(
    primaryColor: ColorConstants.whiteColor,
    accentColor: ColorConstants.accentColor,
    unselectedWidgetColor: ColorConstants.unSelectedWidgetColor,
    primaryColorDark: ColorConstants.whiteColor,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: ColorConstants.parrotDark,
    ),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: ColorConstants.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: ColorConstants.transparent,
      ),
    ),
    primarySwatch: const MaterialColor(0xFF40C979, {
      50: ColorConstants.grayVeryLight,
      100: ColorConstants.grayLight,
      200: ColorConstants.gray,
      300: ColorConstants.grayLevel2,
      400: ColorConstants.grayDark,
      500: ColorConstants.whiteGrayButtonBackground,
      600: ColorConstants.unSelectedWidgetColor,
      700: ColorConstants.dividerColor,
      800: ColorConstants.primaryDarkColor,
      900: ColorConstants.appBlack
    }),
    bottomAppBarColor: ColorConstants.appBlack,
    fontFamily: FontConstants.sourceSansProRegular,
    shadowColor: ColorConstants.shadowColor,
    focusColor: ColorConstants.appBlack,
    highlightColor: ColorConstants.whiteGrayButtonBackground,
    hintColor: ColorConstants.bodyTextColor,
    splashColor: ColorConstants.grayVeryLight,
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: ColorConstants.bodyTextColor,
        fontSize: 11.5.sp,
        fontFamily: FontConstants.sourceSansProRegular,
      ),
      hintStyle: TextStyle(
        color: ColorConstants.bodyTextColor,
        fontSize: 12.5.sp,
      ),
      focusColor: ColorConstants.appBlack,
      filled: true,
      fillColor: ColorConstants.appBlack,
    ),

    tabBarTheme: TabBarTheme(
      unselectedLabelColor: ColorConstants.unSelectedWidgetColor,
      labelColor: ColorConstants.appBlue,
      indicatorSize: TabBarIndicatorSize.tab,
      labelPadding: EdgeInsets.only(bottom: 1.0.w, left: 3.5.w, right: 3.5.w),
      indicator: BoxDecoration(
          border: Border(
              bottom: BorderSide(width: 0.8.w, color: ColorConstants.appBlue))),
      unselectedLabelStyle: TextStyle(
        fontSize: 14.5.sp,
        fontFamily: FontConstants.sourceSansProLight,
      ),
      labelStyle: TextStyle(
        fontSize: 14.5.sp,
        color: ColorConstants.appBlue,
        fontFamily: FontConstants.sourceSansProLight,
      ),
    ),

    /// Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: ColorConstants.blackShade, width: 1),
        primary: ColorConstants.blackShade,
        padding: EdgeInsets.symmetric(vertical: 1.6.h),
        minimumSize: Size(40.w, 2.h),
      ),
    ),

    /// Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: ColorConstants.parrotGreen,
        padding: EdgeInsets.symmetric(vertical: 1.7.h),
        minimumSize: Size(40.w, 2.h),
      ),
    ),

    /// Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: ColorConstants.appBlue,
        padding: EdgeInsets.zero,
        textStyle: TextStyle(
          fontSize: 11.0.sp,
          fontFamily: FontConstants.sourceSansProRegular,
        ),
      ),
    ),

    /// Icon Button Theme
    iconTheme: const IconThemeData(
      color: ColorConstants.appBlack,
    ),

    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 23.0.sp,
        letterSpacing: -0.5,
        fontFamily: FontConstants.sourceSansProBold,
        color: ColorConstants.appBlack,
      ),
      headline4: TextStyle(
        fontSize: 13.0.sp,
        fontFamily: FontConstants.sourceSansProBold,
        color: ColorConstants.appBlack,
      ),
      headline5: TextStyle(
          fontSize: 13.5.sp,

          ///Medium changed with Light
          fontFamily: FontConstants.sourceSansProLight,
          color: ColorConstants.appBlack),

      /// This style automatically applies on all the [Text]
      bodyText2: TextStyle(
        fontSize: 11.sp,
        fontWeight: FontWeight.w300,
        fontFamily: FontConstants.sourceSansProRegular,
        color: ColorConstants.grayLevel2,
      ),

      /// Using this style for radio button text and other place with 16.0.sp and #0d1111 color
      bodyText1: TextStyle(
        fontSize: 13.0.sp,
        fontFamily: FontConstants.sourceSansProRegular,
        color: ColorConstants.appBlack,
      ),

      /// This style automatically applies on the text of [ElevatedButton, OutlinedButton]
      /// also we can define different text style for these button in there respective
      /// theme data above
      button: TextStyle(
        fontSize: 13.0.sp,
        fontFamily: FontConstants.sourceSansProSemiBold,
        color: Colors.white,
      ),

      //text size semiBold black
      headline6: TextStyle(
        fontSize: 13.sp,
        fontFamily: FontConstants.sourceSansProSemiBold,
        color: ColorConstants.appBlack,
      ),
    ),
  );
}
