import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_on_get_it/constants/app_images.dart';
import 'package:go_on_get_it/screens/location/controller/main_controller.dart';
import 'package:sizer/sizer.dart';

class BackArrow extends StatelessWidget {
  final bool sendDataBack;
  BackArrow({
    Key? key,
    this.sendDataBack = false,
  }) : super(key: key);
  MainController mainController = Get.find<MainController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 1.3.h,
      ),
      child: GestureDetector(
        onTap: () {
          if (mainController.catalogLay != null) {
            mainController.catalogLay?.remove();
            mainController.catalogLay = null;
            mainController.isCatalogDropDown = false;
          }
          if(sendDataBack){
            Navigator.pop(context, 1);
          }else {
              Get.back();
          }
        },
        child: SvgPicture.asset(
          AppImages.backArrow,
          color: Colors.black,
          fit: BoxFit.scaleDown,
          height: 5,
          width: 5,
        ),
      ),
    );
  }
}
