import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:ne_music/routes/route_handle.dart';

class Routes {
  static String bootstrap = '/bootstrap';
  static String loginType = '/loginType';
  static String phone = '/phone';
  static String password = '/password';
  static String mainBoard = '/main';
  static String songListDetail = '/song/detail';
  static String playSong = '/song/play';

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
    router.define(songListDetail, handler: songListDetailHander);
    router.define(playSong, handler: playSongHandler);
  }

  /// 为请求地址之后添加参数
  static String withParams(String path, Map<String, dynamic> params) {
    String str = '?';
    List<MapEntry<String, dynamic>> paramsList = params.entries.toList();
    for(int index = 0;index < paramsList.length; index +=1) {
      MapEntry current = paramsList[index];
      str += (index == 0 ? '' : '\$') + '${current.key}=${current.value}';
    }
    return path + str;
  }
}