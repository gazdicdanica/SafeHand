import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {

  SharedPreferencesService._privateConstructor();

  static final SharedPreferencesService _instance =
      SharedPreferencesService._privateConstructor();

  static SharedPreferencesService get instance => _instance;

  SharedPreferences? _preferences;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<SharedPreferences> get _prefs async {
    if (_preferences == null) await init();
    return _preferences!;
  }

  Future<void> setString(String key, String value) async {
    final prefs = await _prefs;
    await prefs.setString(key, value);
  }

  Future<String?> getString(String key) async {
    final prefs = await _prefs;
    return prefs.getString(key);
  }

}
