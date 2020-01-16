import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'package:ne_music/pages/bootstrap.dart';
import 'package:ne_music/pages/login.dart';
import 'package:ne_music/pages/main_board.dart';


var bootstrapHandler = Handler(
  handlerFunc: ( BuildContext context, Map<String, List<String>> parameters) {
    return BootstrapPage();
  }
);

var loginTypeHandler = Handler(
  handlerFunc: ( BuildContext context, Map<String, List<String>> parameters) {
    return LoginPage();
  }
);

var phoneHander = Handler(
  handlerFunc: ( BuildContext context, Map<String, List<String>> parameters) {
    return PhonePage();
  }
);

var passwordHander = Handler(
  handlerFunc: ( BuildContext context, Map<String, List<String>> parameters) {
    String phone = parameters['phone'][0];
    return PasswordPage(previewPhone: phone);
  }
);

var mainBoardHander = Handler(
  handlerFunc: ( BuildContext context, Map<String, List<String>> parameters) {
    return MainBoard();
  }
);