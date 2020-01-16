import 'package:fluro/fluro.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ne_music/utils/constant.dart';

class Application {
  static Router router;
  static SharedPreferences sp;
  static final themeColor = Constant.color['primaryColor'];

  static Future initSp() async {
    sp = await SharedPreferences.getInstance();
    return Future.value();
  }
}