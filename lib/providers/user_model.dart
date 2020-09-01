import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:ne_music/application.dart';
import 'package:ne_music/models/user.dart';
import 'package:ne_music/utils/net_utils.dart';

class UserModel with ChangeNotifier {
  User _user;

  User get user => _user;

  /// 初始化 User
  void initUser() {
    if (Application.sp.containsKey('user')) {
      String s = Application.sp.getString('user');
      _user = User.fromJson(json.decode(s));
      // 在请求工具中存储uid。
      NetUtils.uid = _user.account.id;
    }
  }
  
  Future<User> login(BuildContext context, String phone, String pwd) async {
    User user = await NetUtils.login(context, phone, pwd);

    _saveUserInfo(user);
    return user;
  }

  void _saveUserInfo(User user) {
    _user = user;
    Application.sp.setString('user', json.encode(user));
  }
}