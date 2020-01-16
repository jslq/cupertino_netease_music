import 'dart:io';

main() {
  var result = """import 'package:flutter/widgets.dart';

class NeMusicIcon {

  NeMusicIcon._();
""";
  var file = File.fromUri(Uri.parse("${Uri.base}assets/fonts/ne_music/iconfont.css"));
  var read = file.readAsStringSync();

  var split = read.split(".icon-");
  split.forEach((str) {
    if (str.contains("before")) {
      var split = str.split(":");
      result += "  static const IconData " +
          split[0].replaceAll("-", "_") +
          " = const IconData(" +
          split[2].replaceAll("\"\\", "0x").split("\"")[0] +
          ", fontFamily: \"NeMusicIcon\");\n";
    }
  });
  result+="}";
  var fileOut = File.fromUri(Uri.parse("${Uri.base}lib/widgets/iconfont.dart"));
  fileOut.writeAsStringSync(result);
}