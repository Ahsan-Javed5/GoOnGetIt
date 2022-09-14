import 'package:flutter/material.dart';
import 'package:go_on_get_it/constants/color_constants.dart';
import 'package:go_on_get_it/constants/font_constants.dart';
import 'package:sizer/sizer.dart';

///define ur textStyle here and use them in UI
var captionTextStyle = TextStyle(
  fontFamily: FontConstants.sourceSansProRegular,
  fontSize: 16.sp,
);
var h1 = TextStyle(
    fontFamily: FontConstants.sourceSansProBold,
    fontSize: 96.sp
);

var h2 = TextStyle(
    fontFamily: FontConstants.sourceSansProBold,
    fontSize : 60.sp
);
var h3 = TextStyle(
    fontFamily: FontConstants.sourceSansProBold,
    fontSize: 48.sp
);
var h4 = TextStyle(
    fontFamily: FontConstants.sourceSansProBold,
    fontSize: 34.sp
);
var h5 = TextStyle(
    fontFamily: FontConstants.sourceSansProBold,
    fontSize: 24.sp
);
var h6 = TextStyle(
    fontFamily: FontConstants.sourceSansProBold, fontSize: 20.sp);
var subtitle1 =
    TextStyle(fontFamily: FontConstants.sourceSansProSemiBold, fontSize: 16.sp);
var subtitle2 =
    TextStyle(fontFamily: FontConstants.sourceSansProSemiBold, fontSize: 14.sp);
var body1 =
    TextStyle(fontFamily: FontConstants.sourceSansProRegular, fontSize: 16.sp);
var body2 =
    TextStyle(fontFamily: FontConstants.sourceSansProRegular, fontSize: 14.sp);
var button =
    TextStyle(fontFamily: FontConstants.sourceSansProRegular, fontSize: 14.sp);
var caption =
    TextStyle(fontFamily: FontConstants.sourceSansProRegular, fontSize: 8.sp);

var inputDecoration = const InputDecoration(
  fillColor: Colors.white,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(5.0),
    ),
    borderSide: BorderSide(color: ColorConstants.brownLevel1),
  ),
  filled: true,
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(5.0),
    ),
    borderSide: BorderSide(color: ColorConstants.brownLevel1),
  ),
);
