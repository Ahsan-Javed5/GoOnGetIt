import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_on_get_it/data/local/my_hive.dart';
import 'package:go_on_get_it/utils/utils.dart';

import 'nor.dart';
import 'en_us.dart';

class TranslationService extends Translations {
  static Locale? get locale => Utils.getLocaleFromLocaleType(MyHive.getLocaleType());
  static const fallbackLocale = Locale('en', 'US');

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en_US,
        'fr': nor,
      };
}
