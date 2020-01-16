import 'package:fluttertoast/fluttertoast.dart';

class Util {
  static void showToast(String msg) {
    Fluttertoast.showToast(msg: msg, gravity: ToastGravity.CENTER);
  }
}