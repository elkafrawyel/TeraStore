import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class LocalStorage {
  static final String languageKey = 'lang';
  static final String loginKey = 'login';
  static final String isLanguageChecked = 'languageChecked';
  static final String notifications = 'notifications';
  static final String selectedColorValue = 'selectedColorValue';

  setLanguage(String languageCode) async {
    await GetStorage().write(languageKey, languageCode);
  }

  String getLanguage() {
    return GetStorage().read(languageKey);
  }

  bool isArabicLanguage() {
    return GetStorage().read(languageKey) == 'ar';
  }

  setString(String key, String value) async {
    await GetStorage().write(key, value);
  }

  String getString(String key) {
    return GetStorage().read(key);
  }

  setBool(String key, bool value) async {
    await GetStorage().write(key, value);
  }

  bool getBool(String key) {
    bool value = GetStorage().read(key);
    if (value == null) {
      if (key == notifications)
        return true;
      else
        return false;
    }
    return value;
  }

  setInt(String key, int value) async {
    await GetStorage().write(key, value);
  }

  int getInt(String key) {
    return GetStorage().read(key) == null ? 0 : GetStorage().read(key);
  }

  Color primaryColor() {
    if (getInt(selectedColorValue) == 0) {
      return Color(Colors.blue.value);
    } else {
      return Color(getInt(selectedColorValue));
    }
  }
}
