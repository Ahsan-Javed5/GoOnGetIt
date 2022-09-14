import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_on_get_it/constants/color_constants.dart';
import 'package:go_on_get_it/constants/font_constants.dart';
import 'package:go_on_get_it/screens/location/controller/main_controller.dart';
import 'package:go_on_get_it/utils/space.dart';
import 'package:sizer/sizer.dart';

class DropDownState extends StatelessWidget {
  final double? itemHeight;
  final Function(String distanceValue) callBack;

  DropDownState({Key? key, this.itemHeight = 0.0, required this.callBack})
      : super(key: key);
  final List<String> item = ["10 km", "20 Km", "30 Km", "40 Km", "50 Km"];

  // physics: NeverScrollableScrollPhysics(),
  // final List<String> item = ["10km",];
  final MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool _isMobileLayout = shortestSide < 600;

    return Column(
      children: <Widget>[
        Spaces.y1,
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF9F9F9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListView.builder(
              itemCount: item.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    callBack(item[index]);
                    mainController.tappedIndex.value = index;
                  },
                  child: GetBuilder<MainController>(builder: (c) {
                    return Card(
                      elevation: 0.0,
                      color: index == c.tappedIndex.value
                          ? ColorConstants.parrotDark
                          : const Color(0xFFF9F9F9),
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 2.w, horizontal: 1.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  item[index],
                                  style: TextStyle(
                                      color: index == c.tappedIndex.value
                                          ? ColorConstants.whiteColor
                                          : ColorConstants.gray,
                                      fontSize: _isMobileLayout ? 11.sp : 6.5.sp,
                                      fontWeight: FontWeight.w500,
                                      fontFamily:
                                          FontConstants.sourceSansProRegular),
                                ),
                              ),
                              Visibility(child: Container(height: 1.h, width: 1.h,decoration: const BoxDecoration(
                              color: ColorConstants.whiteColor,
                              borderRadius:  BorderRadius.all(Radius.elliptical(50, 50)),
                            ),),
                            visible: index == c.tappedIndex.value,)
                          ],
                        )
                      ),
                    );
                  }),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
