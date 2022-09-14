import 'package:flutter/material.dart';
import 'package:go_on_get_it/constants/color_constants.dart';
import 'package:sizer/sizer.dart';

class CustomOvalButton extends StatelessWidget {
  final String? text;
  final VoidCallback onPressed;
  final String? routeName;

  const CustomOvalButton(
      {Key? key, this.text, required this.onPressed, this.routeName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool _isMobileLayout = shortestSide < 600;

    return TextButton(
        child: Text(text ?? '',
            style: TextStyle(
                fontSize: _isMobileLayout ? 12.sp : 5.5.sp,
                color: ColorConstants.parrotDark)),
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor:
                MaterialStateProperty.all<Color>(ColorConstants.parrotLight),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide.none))),
        onPressed: () {
          onPressed();
        });
  }
}
