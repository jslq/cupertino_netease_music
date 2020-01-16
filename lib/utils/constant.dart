import 'package:flutter/material.dart';

class ContantColor {
  static final _colors = <String, Color>{
    'primaryColor': Color.fromRGBO(213, 60, 52, 1),
    'brightenColor': Color.fromRGBO(236, 68, 59, 1),
    'bottomNavigatorBarColor': Color.fromRGBO(218 , 218, 218, 1),
    'indicatorColor': Colors.grey[400],
    'searchInputColor': Color.fromRGBO(220, 77, 70, 1),
    'borderColor': Color.fromRGBO(239, 239, 239, 1)
  };
  Color operator [](String color) => _colors[color];
}

class ConstantSize {
  static final _size = <String, dynamic>{
    'bannerAspectRadtio': 570 / 222,
  };

  dynamic operator [](String key) => _size[key];
}

class Constant {
  static final color = ContantColor();
  static final size = ConstantSize();
}