import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:ne_music/application.dart';
import 'package:ne_music/routes/routes.dart';

class NavigatorUtil {
  static _navigateTo(
    BuildContext context, 
    String path,
    {
      bool replace = false,
      bool clearStack = false,
      Duration transitionDuration = const Duration(milliseconds: 300),
      RouteTransitionsBuilder transitionsBuilder,
      TransitionType transitionType = TransitionType.cupertino
    }
  ) {
    Application.router.navigateTo(context, path, 
      replace: replace,
      clearStack: clearStack,
      transitionDuration: transitionDuration,
      transitionBuilder: transitionsBuilder,
      transition: transitionType
    );
  }

  /// 选择登录方式页面
  static void goLoginTypePage(BuildContext context) {
    _navigateTo(context, Routes.loginType, 
      clearStack: true, 
      transitionDuration: Duration(milliseconds: 100),
      transitionType: TransitionType.fadeIn
    );
  }

  /// 输入手机号页面
  static void goPhonePage(BuildContext context) {
    _navigateTo(context, Routes.phone);
  }

  /// 去输入密码
  static void goPasswordPage(BuildContext context, phone) {
    _navigateTo(context, Routes.withParams(Routes.password, {'phone': phone}));
  }

  static void goMainBoardPage(BuildContext context) {
    _navigateTo(context, Routes.mainBoard,
      clearStack: true, 
      transitionDuration: Duration(milliseconds: 100),
      transitionType: TransitionType.fadeIn
    );
  }
}