import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_on_get_it/data/local/my_hive.dart';
import 'package:go_on_get_it/models/enums/locale_type.dart';
import 'package:go_on_get_it/screens/language/language.dart';
import 'package:go_on_get_it/utils/utils.dart';

class LanguageController extends GetxController {
  List<Language> languageList = <Language>[].obs;
  var selectedLanguage = Get.locale?.languageCode.obs;
  RxString language = 'English'.obs;
  final box = GetStorage();
  LocaleType selectedLocale = MyHive.getLocaleType();

  updateLocale(LocaleType type) {
    MyHive.setLocaleType(type);
    selectedLocale = MyHive.getLocaleType();
    Get.updateLocale(Utils.getLocaleFromLocaleType(type));
    update();
  }

  void setLang() {
    languageList.clear();
    languageList.add(Language(true, 'english'.tr));
    languageList.add(Language(false, 'Norwegian'));
  }

  void reset() {
    languageList.clear();
    languageList.add(Language(false, 'english'.tr));
    languageList.add(Language(false, 'Norwegian'));
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getLanguage();
    setLang();
  }

  void getLanguage() {
    language.value = box.read("lang") ?? "English";
  }

  void setLanguage(String lang) {
    language.value = lang;
    box.write("lang", language.value);
  }
}