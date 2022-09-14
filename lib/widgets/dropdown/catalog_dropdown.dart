import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_on_get_it/constants/color_constants.dart';
import 'package:go_on_get_it/constants/text_styles.dart';
import 'package:go_on_get_it/screens/location/controller/main_controller.dart';
import 'package:go_on_get_it/widgets/dropdown/catalog_dropdown_state.dart';
import 'package:sizer/sizer.dart';

class CatalogDropdown extends StatefulWidget {
  final String radiusText;
  final double customeWidth;
  final Function(String value) selectedvalue;
  final Function(OverlayEntry) callBack;

  const CatalogDropdown(
      {Key? key,
      required this.radiusText,
      required this.callBack,
      required this.selectedvalue,
      this.customeWidth = 22,
      this.iconData})
      : super(key: key);
  final IconData? iconData;
  @override
  _CatalogDropdownState createState() => _CatalogDropdownState();
}

class _CatalogDropdownState extends State<CatalogDropdown> {
  GlobalKey? actionKey;
  double? height, width, xPosition, yPosition;
  OverlayEntry? floatingDropdown;
  String? itemSelected = "";
  final MainController mainController = Get.find<MainController>();

  @override
  void initState() {
    actionKey = LabeledGlobalKey(widget.radiusText);
    super.initState();
  }

  void findDropdownData() {
    RenderBox? renderBox =
        actionKey!.currentContext!.findRenderObject() as RenderBox?;
    height = renderBox!.size.height;
    width = renderBox.size.width;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    xPosition = offset.dx - 80;
    yPosition = offset.dy;
  }

  OverlayEntry _createFloatingDropdown() {
    return OverlayEntry(builder: (context) {
      return Positioned(
        left: xPosition,
        width: width! + 80,
        top: yPosition! + height!,

        ///change height of listContainer...
        height: 5 * height!,
        child: CatalogDropdownState(
          itemHeight: height,
          callBack: (distanceValue) {
            itemSelected = distanceValue;
            setState(
              () {
                if (mainController.isCatalogDropDown) {
                  floatingDropdown?.remove();
                  mainController.isDropdownOpened.value = false;
                  mainController.catalogLay = null;
                } else {
                  findDropdownData();
                  floatingDropdown = _createFloatingDropdown();
                  Overlay.of(context)?.insert(floatingDropdown!);
                }
                mainController.isCatalogDropDown = !mainController.isCatalogDropDown;
                widget.selectedvalue(distanceValue.toString());
              },
            );
            // widget.callBack(distanceValue);
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool _isMobileLayout = shortestSide < 600;

    return GestureDetector(
      key: actionKey,
      onTap: () {
        setState(() {
          if (mainController.isCatalogDropDown) {
            floatingDropdown?.remove();
            mainController.isDropdownOpened.value = false;
            mainController.catalogLay = null;
          } else {
            findDropdownData();
            if (mainController.radiusLay != null) {
              mainController.radiusLay?.remove();
              mainController.isDropdownOpened.value = false;
              mainController.radiusLay = null;
            }
            floatingDropdown = _createFloatingDropdown();
            Overlay.of(context)?.insert(floatingDropdown!);
            widget.callBack(floatingDropdown!);
          }
          mainController.isCatalogDropDown = !mainController.isCatalogDropDown;
        });
      },
      child: Container(
        height: 6.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1.7.w),
          color: ColorConstants.parrotGreen.withOpacity(0.1),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 1.w,
        ),
        margin: EdgeInsets.only(right: 2.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: 1.5.w,
            ),
            Image.asset(
              "assets/images/ic_filters.png",
              height: _isMobileLayout ? 5.5.h : 3.7.h,
              width:  _isMobileLayout ? 5.5.w : 3.7.w,
            ),
            SizedBox(
              width: 2.w,
            ),
            Flexible(
              child: Text(
                widget.radiusText,
                style: captionTextStyle.copyWith(
                    overflow: TextOverflow.ellipsis,
                    color: ColorConstants.parrotGreen,
                    fontSize:  _isMobileLayout ? 11.sp : 6.5.sp),
                maxLines: 1,
              ),
            ),
            const Icon(
              Icons.arrow_drop_down_sharp,
              color: ColorConstants.parrotDark,
            ),
          ],
        ),
      ),
    );
  }
}
