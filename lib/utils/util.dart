import 'package:fluttertoast/fluttertoast.dart';

class Util {
  static void showToast(String msg) {
    Fluttertoast.showToast(msg: msg, gravity: ToastGravity.CENTER);
  }

  static String countNum(int num) {
    if (num > 100000) {
      double whole = num / 10000;
      return whole.toStringAsFixed(0) + '万';
    }
    return num.toString();
  }
}