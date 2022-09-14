import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:go_on_get_it/constants/font_constants.dart';
import 'package:go_on_get_it/constants/text_styles.dart';
import 'package:go_on_get_it/screens/location/controller/main_controller.dart';
import 'package:go_on_get_it/utils/space.dart';
import 'package:go_on_get_it/widgets/back_arrow.dart';
import 'package:sizer/sizer.dart';

class ContactUs extends StatelessWidget {
  ContactUs({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();
  final MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool _isMobileLayout = shortestSide < 600;

    TextStyle hintStyle() {
      return TextStyle(
          fontFamily: FontConstants.sourceSansProRegular,
          fontSize: _isMobileLayout ? 12.sp : 8.sp);
    }

    return Scaffold(
      appBar: _isMobileLayout
          ? AppBar(
              leading: BackArrow(),
              title: Align(
                alignment: Alignment.centerLeft,
                child: Transform(
                  transform: Matrix4.translationValues(-10, 6.0, 0.0),
                  child: Text(
                    'contactUs'.tr,
                    style: TextStyle(
                      fontFamily: FontConstants.sourceSansProSemiBold,
                      color: Colors.black,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              ),
              titleSpacing: 0.7.w,
              backgroundColor: Colors.transparent,
              elevation: 0,
            )
          : AppBar(
              toolbarHeight: 7.h,
              leading: BackArrow(),
              title: Align(
                alignment: Alignment.centerLeft,
                child: Transform(
                  transform: Matrix4.translationValues(-10, 6.0, 0.0),
                  child: Padding(
                    padding: EdgeInsets.only(left: 1.w),
                    child: Text(
                      'contactUs'.tr,
                      style: TextStyle(
                        fontFamily: FontConstants.sourceSansProSemiBold,
                        color: Colors.black,
                        fontSize: 11.sp,
                      ),
                    ),
                  ),
                ),
              ),
              titleSpacing: 0.7.w,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            child: Column(
              children: [
                Spaces.y6,
                FormBuilderTextField(
                  name: 'name',
                  decoration: inputDecoration.copyWith(
                    hintText: "enterYourName".tr,
                    hintStyle: hintStyle(),
                  ),
                ),
                Spaces.y4,
                FormBuilderTextField(
                  decoration: inputDecoration.copyWith(
                      hintText: "enterYourPhone".tr, hintStyle: hintStyle()),
                  name: 'phone',
                ),
                Spaces.y4,
                FormBuilderTextField(
                  decoration: inputDecoration.copyWith(
                      hintText: "enterYourEmail".tr, hintStyle: hintStyle()),
                  name: 'email',
                ),
                Spaces.y4,
                FormBuilderTextField(
                  maxLines: 13,
                  decoration: inputDecoration.copyWith(
                    hintText: "typeMessage".tr,
                    hintStyle: hintStyle(),
                  ),
                  name: 'message',
                ),
                Spaces.y4,
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                      width: Get.width, height: _isMobileLayout ? 7.0.h : 6.h),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.saveAndValidate()) {
                        mainController.contact(_formKey.currentState!.value);
                        _formKey.currentState?.reset();
                      }
                    },
                    child: Text(
                      "submit".tr,
                      style: caption.copyWith(
                          color: Colors.white,
                          fontSize: _isMobileLayout ? 13.sp : 8.sp),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
