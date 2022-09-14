import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_form_builder/localization/form_builder_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_on_get_it/constants/routes.dart';
import 'package:go_on_get_it/http_overrides.dart';
import 'package:go_on_get_it/network/remote_services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sizer/sizer.dart';

import 'constants/theme_data.dart';
import 'data/local/my_hive.dart';
import 'lang/translation_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  HttpOverrides.global = MyHttpOverrides();
  await Hive.initFlutter();
  await MyHive.init();
  await setup();
  await GetStorage.init();

  ///it is not possible to change the duration of the splash screen.
  ///The native splash screen is displayed while the native app loads the Flutter framework.
  ///Because the resources in your app cannot load while the native splash screen is displayed,
  ///the native splash screen must be as fast as possible. Note that delaying the user experience is a poor design decision.
  ///for native splash screen you cant add delay as so for that to increase time for splash screen added delay for 3 seconds manually
  ///in debug it was working fine but in release it was not! so for that i have added  this delay
  await Future.delayed(const Duration(seconds: kReleaseMode ? 3 : 0));
  runApp(const MyApp());
}

setup() async {
  //Singleton registration
  GetIt.I.registerSingleton<RemoteServices>(RemoteServices());
  //GetIt.I.registerSingleton<RemoteRepository>(RemoteRepository());

  //Initialization
  GetIt.I<RemoteServices>().init();
  //GetIt.I<RemoteRepository>().init();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Status bar background and data color
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ));

    /// Using Sizer for asset scaling based on screen size and density
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          /// Material app builder to keep the scaling of the font consistent
          /// Font will not be affected by the device font settings
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child!,
            );
          },

          /// Locale Management
          locale: TranslationService.locale,
          fallbackLocale: TranslationService.fallbackLocale,
          translations: TranslationService(),
          localizationsDelegates: const [
            FormBuilderLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('fr', 'FR'),
          ],
          unknownRoute: Routes.getUnknownRoute(),
          initialRoute: Routes.getInitialRoute(),
          getPages: Routes.getPages(),

          /// Material App Management
          title: 'app_name'.tr,
          debugShowCheckedModeBanner: false,
          theme: getAppThemeData(),
        );
      },
    );
  }
}
