import 'package:shared_preferences/shared_preferences.dart';
import 'package:just_audio/just_audio.dart';

final player = AudioPlayer();

class Services {
//
  static String apiUrl = "https://gentle-tundra-54707.herokuapp.com/";
//
  static Future<SharedPreferences> sharedprefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  static void makeSound(bool big) async {
    if (big) {
      await player.setUrl('https://equalist.tech/clickcut.mp3');
    } else {
      await player.setUrl('https://equalist.tech/clickcut.mp3');
    }
    //print(duration);
    player.play();
  }

  static Future<bool> checkLogin() async {
    SharedPreferences prefs = await sharedprefs(); //sessionid and keyURL
    print(prefs.getString("session_id"));
    print(prefs.getString("url_key"));
    if (prefs.getString("session_id") == null ||
        prefs.getString("url_key") == null) {
      return false;
    } else {
      return true;
    }
  }
}
