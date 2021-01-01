import 'package:get_storage/get_storage.dart';

class LocalStorage {
  static final String languageKey = 'lang';
  static final String loginKey = 'login';
  static final String isLanguageChecked = 'languageChecked';

  setLanguage(String languageCode) async {
    await GetStorage().write(languageKey, languageCode);
  }

  Future<String> getLanguage() async {
    return await GetStorage().read(languageKey);
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
    return GetStorage().read(key) == null ? false : GetStorage().read(key);
  }

  setInt(String key, int value) async {
    await GetStorage().write(key, value);
  }

  int getInt(String key) {
    return GetStorage().read(key) == null ? 0 : GetStorage().read(key);
  }
}
