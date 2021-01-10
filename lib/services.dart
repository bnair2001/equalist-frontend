import 'package:shared_preferences/shared_preferences.dart';

class Services {
  static Future<SharedPreferences> sharedprefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  static void makeSound() async {}

  static Future<bool> checkLogin() async {
    SharedPreferences prefs = await sharedprefs();
    print(prefs.getString("ref_token"));
    if (prefs.getString("ref_token") == null) {
      return false;
    } else {
      return true;
    }
  }
}
