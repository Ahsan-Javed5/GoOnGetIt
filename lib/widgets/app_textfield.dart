import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_on_get_it/constants/color_constants.dart';
import 'package:go_on_get_it/constants/font_constants.dart';
import 'package:sizer/sizer.dart';

class AppTextField extends StatelessWidget {
  final String hint;
  final String sufficIconURL;
  const AppTextField({
    Key? key,
    required this.hint,
    required this.sufficIconURL,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlignVertical: TextAlignVertical.center,
      style: TextStyle(
        fontSize: 11.sp,
      ),
      cursorColor: Colors.grey,
      decoration: InputDecoration(
        fillColor: const Color.fromRGBO(0, 0, 0, 0.06),
        filled: true,
        border: InputBorder.none,
        hintText: hint,
        contentPadding: EdgeInsets.only(
          left: 3.w,
        ),
        hintStyle: const TextStyle(
          fontFamily: FontConstants.sourceSansProRegular,
          color: ColorConstants.appBlack,
        ),
        suffixIcon: SvgPicture.asset(
          sufficIconURL,
          height: 1.h,
          width: 2.w,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
