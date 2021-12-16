import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  SharedPrefs._();

  static final SharedPrefs _instance = SharedPrefs._();
  factory SharedPrefs() => _instance;

  SharedPreferences? _prefs;

  initPrefs() async => _prefs = await SharedPreferences.getInstance();

  bool containsKey(String key) => _prefs!.containsKey(key);

  Future<bool> remove(String key) async => await _prefs!.remove(key);

  // PAG
  int get pag => _prefs!.getInt('pag') ?? 0;
  set pag(int value) => _prefs!.setInt('pag', value);

  // LOGGED
  bool get logged => _prefs!.getBool('logged') ?? false;
  set logged(bool value) => _prefs!.setBool('logged', value);

  // USER
  String get user => _prefs!.getString('user') ?? '';
  set user(String value) => _prefs!.setString('user', value);

  // ADMINVIEW
  bool get adminView => _prefs!.getBool('adminView') ?? false;
  set adminView(bool value) => _prefs!.setBool('adminView', value);
}
