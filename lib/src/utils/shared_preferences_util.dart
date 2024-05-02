import 'package:chat_app_white_label/src/utils/logger_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  SharedPreferences? _sharedPreferences;

  Future<SharedPreferences> getInstance() async {
    return _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  Future<void> setString(String? key, String? value) async {
    LoggerUtil.logs('setString $key : $value');
    _sharedPreferences = await getInstance();
    await _sharedPreferences!.setString(key ?? '', value ?? '');
  }

  ///get string value in prefs
  Future<String?> getString(String? key) async {
    LoggerUtil.logs('getString $key');
    _sharedPreferences = await getInstance();
    final stringValue = _sharedPreferences!.getString(key!);
    return stringValue;
  }


  ///set int value in prefs
  Future setInt(String? key, int? value) async {
    LoggerUtil.logs('setInt $key');
    _sharedPreferences = await getInstance();
    await _sharedPreferences!.setInt(key!, value!);
  }

  ///get int value in prefs
  Future<int?> getInt(String? key) async {
    LoggerUtil.logs('getInt $key');
    _sharedPreferences = await getInstance();
    final intValue = _sharedPreferences!.getInt(key!);
    return intValue;
  }

  ///set double value in prefs
  Future setDouble(String? key, double value) async {
    LoggerUtil.logs('setDouble $key');
    _sharedPreferences = await getInstance();
    await _sharedPreferences!.setDouble(key!, value);
  }

  ///get double value in prefs
  Future<double?> getDouble(String? key) async {
    LoggerUtil.logs('getDouble $key');
    _sharedPreferences = await getInstance();
    final doubleValue = _sharedPreferences!.getDouble(key!);
    return doubleValue;
  }

  ///set bool value in prefs
  Future setBool(String? key, {bool? value}) async {
    LoggerUtil.logs('setBool $key');
    _sharedPreferences = await getInstance();
    await _sharedPreferences!.setBool(key!, value!);
  }

  ///get bool value from prefs
  Future<bool?> getBool(String? key) async {
    LoggerUtil.logs('getBool $key');
    _sharedPreferences = await getInstance();
    return _sharedPreferences!.getBool(key!);
  }

  ///remove value from prefs
  Future<bool> removeValue(String? key) async {
    LoggerUtil.logs('removeValue $key');
    _sharedPreferences = await getInstance();
    final isRemoved = await _sharedPreferences!.remove(key!);
    return isRemoved;
  }

  ///check existing value in prefs
  Future<bool> isExist(String? key) async {
    LoggerUtil.logs('checkValue $key');
    _sharedPreferences = await getInstance();
    return _sharedPreferences!.containsKey(key!);
  }

  ///set ListPrefs in prefs
  Future setStringListPrefs(String? key, List<String>? value) async {
    LoggerUtil.logs('setStringListPrefs $key');
    _sharedPreferences = await getInstance();
    await _sharedPreferences!.setStringList(key!, value!);
  }

  ///get ListPrefs from prefs
  Future<List<String?>?> getStringListPrefs(String? key) async {
    LoggerUtil.logs('getStringListPrefs $key');
    final prefs = await getInstance();
    return prefs.getStringList(key!);
  }
}
