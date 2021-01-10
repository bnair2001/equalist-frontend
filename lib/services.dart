import 'package:shared_preferences/shared_preferences.dart';
import 'package:just_audio/just_audio.dart';

final player = AudioPlayer();

class Services {
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
    SharedPreferences prefs = await sharedprefs();
    print(prefs.getString("ref_token"));
    if (prefs.getString("ref_token") == null) {
      return false;
    } else {
      return true;
    }
  }
}
