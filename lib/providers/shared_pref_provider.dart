import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefProvider {
  static setString(String key, dynamic value) async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString(key, value).then((value) {
      print("The value is  ${value}");
    });
  }

  static getString(String key) async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getString(key);
  }

  static clearKey(String key) async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.remove(key);
  }
}
