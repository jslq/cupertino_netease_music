import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:ne_music/routes/route_handle.dart';

class Routes {
  static String bootstrap = '/bootstrap';
  static String loginType = '/loginType';
  static String phone = '/phone';
  static String password = '/password';
  static String mainBoard = '/main';

  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });
    router.define(bootstrap, handler: bootstrapHandler);
    router.define(loginType, handler: loginTypeHandler);
    router.define(phone, handler: phoneHander);
    router.define(password, handler: passwordHander);
    router.define(mainBoard, handler: mainBoardHander);
  }

  static String withParams(String path, Map<String, String> params) {
    String str = '?';
    List<MapEntry<String, String>> paramsList = params.entries.toList();
    for(int index = 0;index < paramsList.length; index +=1) {
      MapEntry current = paramsList[index];
      str += (index == 0 ? '' : '\$') + '${current.key}=${current.value}';
    }
    return path + str;
  }
}