import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_on_get_it/constants/font_constants.dart';
import 'package:go_on_get_it/constants/routes.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  Widget buildListTile(String title, String url, String route, BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool _isMobileLayout = shortestSide < 600;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: _isMobileLayout ? 1.w : 2.w),
      child: ListTile(
          horizontalTitleGap: -1.w,
          leading: SvgPicture.asset(url),
          title: Padding(
            padding: EdgeInsets.only(left:  _isMobileLayout ? 0 : 2.w),
            child: Text(
              title,
              style: TextStyle(
                fontFamily: FontConstants.sourceSansProRegular,
                fontSize: _isMobileLayout ? 12.sp : 8.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          onTap: () {
            if (route.isNotEmpty) {
              Get.toNamed(route);
            }else{
                _launchURL();
            }
          }),
    );
  }

  _launchURL() async {
    const url = 'https://goongetit.codesorbit.net/registration';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool _isMobileLayout = shortestSide < 600;

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.80,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(4.h),
          bottomRight: Radius.circular(4.h),
        ),
        child: Drawer(
          backgroundColor: const Color.fromRGBO(64, 201, 121, 1),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: SvgPicture.asset(
                  'assets/svgs/drawer_upper_leaves.svg',
                ),
              ),
              Positioned(
                bottom: 0,
                child: SvgPicture.asset(
                  'assets/svgs/drawer_lower_leaves.svg',
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(4.w, 1.5.h, 0, 0),
                child: Image.asset(
                  'assets/images/logohd.png',
                  height:  _isMobileLayout ? 35.h : 30.h,
                  width: _isMobileLayout ? 55.w : 40.w,
                  //fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 28.h),
                child: Column(
                  children: <Widget>[
                    buildListTile(
                      'aboutUs'.tr,
                      'assets/svgs/information.svg',
                      Routes.aboutUsScreen,
                      context
                    ),
                    buildListTile(
                      'notification'.tr,
                      'assets/svgs/ringing.svg',
                      Routes.notificationScreen,
                      context
                    ),
                    buildListTile(
                      'favouriteList'.tr,
                      'assets/svgs/heart.svg',
                      Routes.favoriteScreen,
                      context
                    ),
                    buildListTile(
                      'changeLanguage'.tr,
                      'assets/svgs/earth.svg',
                      Routes.languageScreen,
                      context
                    ),
                    buildListTile(
                      'contactUs'.tr,
                      'assets/svgs/ic_contact_us.svg',
                      Routes.contactus,
                      context
                    ),
                    buildListTile(
                      'becomeaVendor'.tr,
                      'assets/svgs/hand.svg',
                      '',
                      context
                    ),
                  ],
                ),
              ),
              Positioned(
                child: Container(
                  margin: EdgeInsets.fromLTRB(4.5.w, 6.h, 0, 0),
                  child: Row(
                    children: [
                      GestureDetector(
                        child: SvgPicture.asset(
                          'assets/svgs/back_arrow.svg',
                          color: Colors.white,
                        ),
                        onTap: () => Get.back(),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: 5.w,
                        ),
                        child: Text(
                          'catalog'.tr,
                          style: TextStyle(
                            fontFamily: FontConstants.sourceSansProSemiBold,
                            fontSize: _isMobileLayout ? 13.sp : 12.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
