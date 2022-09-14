import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_on_get_it/constants/color_constants.dart';
import 'package:go_on_get_it/constants/font_constants.dart';
import 'package:go_on_get_it/constants/text_styles.dart';
import 'package:go_on_get_it/screens/location/controller/main_controller.dart';
import 'package:go_on_get_it/widgets/dropdown/dropdown_state.dart';
import 'package:sizer/sizer.dart';

class CustomDropdown extends StatelessWidget {
  final String radiusText;
  Function(OverlayEntry) dropDownCallBack;
  final void Function(String?)? selectValue;

  CustomDropdown(
      {Key? key,
      required this.radiusText,
      required this.dropDownCallBack,
      this.selectValue})
      : super(key: key);

  ///varibles
  final MainController mainController = Get.find<MainController>();
  late GlobalKey? actionKey;
  late double? height, width, xPosition, yPosition;
  late OverlayEntry? floatingDropdown;

  void findDropdownData() {
    RenderBox? renderBox =
        actionKey!.currentContext!.findRenderObject() as RenderBox?;
    height = renderBox!.size.height;
    width = renderBox.size.width;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    xPosition = offset.dx;
    yPosition = offset.dy;
  }

  OverlayEntry _createFloatingDropdown() {
    return OverlayEntry(builder: (context) {
      return Positioned(
        left: xPosition,
        width: width,
        top: yPosition! + height!,

        ///change height of listContainer...multiply witn list item it will be increase the size of container....
        height: 5 * height!,
        child: GetBuilder<MainController>(builder: (controller) {
          return DropDownState(
            itemHeight: height,
            callBack: (distanceValue) {
              mainController.itemSelected.value = distanceValue;
              if (selectValue != null) {
                selectValue!(distanceValue);
              }
              if (controller.isDropdownOpened.value) {
                floatingDropdown?.remove();
                mainController.isCatalogDropDown = false;
                mainController.radiusLay = null;
              } else {
                findDropdownData();
                floatingDropdown = _createFloatingDropdown();
                Overlay.of(context)?.insert(floatingDropdown!);
              }
              controller.isDropdownOpened.value =
                  !controller.isDropdownOpened.value;
            },
          );
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool _isMobileLayout = shortestSide < 600;

    actionKey = LabeledGlobalKey(radiusText);
    return GestureDetector(
      key: actionKey,
      onTap: () {
        if (mainController.isDropdownOpened.value) {
          floatingDropdown?.remove();
          mainController.isCatalogDropDown = false;
          mainController.radiusLay = null;
        } else {
          findDropdownData();
          if (mainController.catalogLay != null) {
            mainController.catalogLay?.remove();
            mainController.catalogLay = null;
            mainController.isCatalogDropDown = false;
          }
          floatingDropdown = _createFloatingDropdown();
          Overlay.of(context)?.insert(floatingDropdown!);
          dropDownCallBack(floatingDropdown!);
        }
        mainController.isDropdownOpened.value =
            !mainController.isDropdownOpened.value;
      },

      /// removed center widget
      child: Container(
        margin: EdgeInsets.only(right: 3.w),
        padding: EdgeInsets.only(left: 2.w),
        width: 19.w,
        height: 6.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1.7.w),
          color: ColorConstants.parrotDark.withOpacity(0.1),
        ),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                radiusText.tr,
                style: captionTextStyle.copyWith(
                    overflow: TextOverflow.ellipsis,
                    color: ColorConstants.primaryColorVariant,
                    fontFamily: FontConstants.sourceSansProRegular,
                    fontSize: _isMobileLayout ? 11.sp : 6.sp),
                maxLines: 1,
              ),
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      mainController.itemSelected.value,
                      style: captionTextStyle.copyWith(
                          overflow: TextOverflow.ellipsis,
                          color: ColorConstants.parrotDark.withOpacity(0.6),
                          fontFamily: FontConstants.sourceSansProRegular,
                          fontSize: _isMobileLayout ? 11.sp : 6.5.sp),
                      maxLines: 1,
                    ),
                    const Icon(
                      Icons.arrow_drop_down_sharp,
                      color: ColorConstants.parrotDark,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
