import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtils {
  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences _prefsInstance;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }



  static Future<String> getString(String key) async {
    if (_prefsInstance == null) {
      _prefsInstance = await _instance;
    }
    return _prefsInstance.getString(key) ?? null;
  }

  static Future<int> getInt(String key) async {
    if (_prefsInstance == null) {
      _prefsInstance = await _instance;
    }
    return _prefsInstance.getInt(key) ?? null;
  }

  static Future<bool> getBool(String key) async {
    if (_prefsInstance == null) {
      _prefsInstance = await _instance;
    }

    bool value = _prefsInstance?.getBool(key);
    if (value == null)
      return false;
    else
      return value;
  }

  static setBool(String key, bool value) async {
    if (_prefsInstance == null) {
      _prefsInstance = await _instance;
    }
    _prefsInstance.setBool(key, value) ?? Future.value(false);
  }

  static logOut() async {
    if (_prefsInstance == null) {
      _prefsInstance = await _instance;
    }
    _prefsInstance.clear();
  }
}
