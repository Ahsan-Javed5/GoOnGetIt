import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_on_get_it/constants/font_constants.dart';
import 'package:go_on_get_it/models/enums/locale_type.dart';
import 'package:go_on_get_it/screens/language/language_controller.dart';
import 'package:go_on_get_it/widgets/back_arrow.dart';
import 'package:sizer/sizer.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: BackArrow(),
        title:Transform(
          transform: Matrix4.translationValues(-8, 6.0, 0.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Transform(
              transform: Matrix4.translationValues(-16, 0.0, 0.0),
              child: Text(
                'language'.tr,
                style: TextStyle(
                  fontFamily: FontConstants.sourceSansProSemiBold,
                  color: Colors.black,
                  fontSize: 15.sp,
                ),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/notification_background.png'),
            alignment: Alignment.bottomCenter,
          ),
        ),
        height: MediaQuery.of(context).size.height * 0.90,
        child: const MyStatefulWidget(),
      ),
    );
  }
}

enum LanguageOption { english, norvegian }

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  LanguageOption? lang = LanguageOption.english;
  LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: EdgeInsets.only(left: 4.w, top: 4.h),
        child: Column(
          children: [
            RadioListTile(
              value: "English",
              groupValue: languageController.language.value,
              title: Text("english".tr),
              activeColor: Colors.green,
              onChanged: (value) {
                languageController.updateLocale(LocaleType.en);
                languageController.setLanguage(value as String);
              },
            ),
            RadioListTile(
              value: "Norwegian",
              groupValue: languageController.language.value,
              title: Text("Norwegian".tr),
              activeColor: Colors.green,
              onChanged: (value) {
                languageController.updateLocale(LocaleType.nor);
                languageController.setLanguage(value as String);
              },
            ),
          ],
        ),
      ),
    );
  }
}
