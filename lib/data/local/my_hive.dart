import 'package:go_on_get_it/data/local/user_location.dart';
import 'package:go_on_get_it/models/classes/user_data.dart';
import 'package:go_on_get_it/models/enums/locale_type.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class MyHive {
  static const String _localeType = 'localeType';
  static const String _location = 'UserLocation';
  static const String _user = 'UserData';
  static const String _token = 'userToken';
  static const String _expiredDiscounts = 'ExpiredDiscounts';
  static const String _radius = 'Radius';

  static late Box _ins;

  Box get ins => _ins;

  static init() async {
    Hive.registerAdapter(LocaleTypeAdapter());
    Hive.registerAdapter(UserLocationAdapter());
    Hive.registerAdapter(UserDataAdapter());
    _ins = await Hive.openBox('APP');
  }

  static getLocaleType() {
    return _ins.get(_localeType) ?? LocaleType.en;
  }

  static setLocaleType(LocaleType type) {
    _ins.put(_localeType, type);
  }

  static getLocation() {
    return _ins.get(_location, defaultValue: null);
  }

  static setLocation(UserLocation type) {
    _ins.put(_location, type);
  }

  static getUser() {
    return _ins.get(_user, defaultValue: null);
  }

  static setUser(UserData type) {
    _ins.put(_user, type);
  }

  static getToken() {
    return _ins.get(_token, defaultValue: null);
  }

  static setToken(String? type) {
    _ins.put(_token, type);
  }

  static setRadius(int radius){
    _ins.put(_radius, radius);
  }

  static getRadius(){
    return _ins.get(_radius, defaultValue: 10);
  }

  static setExpiredDiscount({bool? isExpiredDiscount}){
    _ins.put(_expiredDiscounts, isExpiredDiscount);
  }

  static getExpiredDiscount(){
    return _ins.get(_expiredDiscounts, defaultValue: false);
  }
}
