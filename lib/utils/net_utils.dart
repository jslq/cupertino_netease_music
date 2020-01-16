import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

import 'package:ne_music/utils/util.dart';
import 'package:ne_music/models/user.dart';
import 'package:ne_music/models/recommend.dart';
import 'package:ne_music/models/songlist.dart';

Map<String, String> apis = <String, String> {
  // 登录
  'login': '/login/cellphone',
  'recommendList': '/recommend/resource',
  'songlist': '/user/playlist'
};

class NetUtils {
  static int _uid;
  static get uid => _uid;
  static set uid(value) {
    _uid = value;
  }
  static Dio dio = Dio();
  static const String baseUrl = 'http://192.168.1.103:3000';

  static Future init() async {
    dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = 5000;

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    var cookieJar=PersistCookieJar(dir:appDocPath+"/.cookies/");
    dio.interceptors.add(CookieManager(cookieJar));
    return Future.value();
  }

  static Future<Map<String, dynamic>> _get<T>(
    BuildContext context,
    String url, {
      Map<String, dynamic> parmas,
    }
  ) async {
    try {
      Response response = await dio.get(url, queryParameters: parmas);
      return Future.value(response.data);
    } on DioError catch(e) {
      // 请求出错,一般就是网络原因出错
      print(e?.message);
      Util.showToast( e?.message ?? '网路错误!');
      return Future.error(e.response);
    }
  }

  // 登录
  static Future<User> login(
    BuildContext context, String phone, String password
  ) async {
    Map<String, dynamic> result = await _get(context, apis['login'], parmas: {
      'phone': phone,
      'password': password
    });

    var user = User.fromJson(result);
    return user;
  }

  // 推荐歌单
  static Future<RecommendList> getRecommondList(
    BuildContext context
  ) async {
    Map<String, dynamic> result = await _get(context, apis['recommendList']);
    return RecommendList.fromJson(result);
  }

  // 我的歌单
  static Future<SongList> getSongList(
    BuildContext context
  ) async {
    Map<String, dynamic> result = await _get(context, apis['songlist'], parmas: {
      'uid': NetUtils.uid
    });
    return SongList.fromJson(result);
  }
}
