import 'package:flutter/material.dart';
import 'package:go_on_get_it/constants/font_constants.dart';
import 'package:go_on_get_it/widgets/back_arrow.dart';
import 'package:sizer/sizer.dart';

class CustomeAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  Function()? onPressed;
  CustomeAppBar({
    Key? key,
    required this.title,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool _isMobileLayout = shortestSide < 600;

    return GestureDetector(
      onTap: onPressed,
      child: AppBar(
        leading: BackArrow(),
        titleSpacing: 1.w,
        title: Align(alignment: Alignment.centerLeft, child: Transform(
          transform: Matrix4.translationValues(-10, 6.0, 0.0),
          child: Text(
            title,
            style: TextStyle(
              fontFamily: FontConstants.sourceSansProSemiBold,
              color: Colors.black,
              fontSize: _isMobileLayout ? 14.sp : 11.sp,
            ),
          ),
        ),),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
