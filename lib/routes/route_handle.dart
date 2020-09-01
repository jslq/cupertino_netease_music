import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'package:ne_music/pages/bootstrap.dart';
import 'package:ne_music/pages/login.dart';
import 'package:ne_music/pages/main_board.dart';
import 'package:ne_music/pages/song/songlist_detail.dart';
import 'package:ne_music/pages/song/play_song.dart';


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

// 主页
var mainBoardHander = Handler(
  handlerFunc: ( BuildContext context, Map<String, List<String>> parameters) {
    return MainBoard();
  }
);

//歌单详情页
var songListDetailHander = Handler(
  handlerFunc: ( BuildContext context, Map<String, List<String>> parameters) {
    String id = parameters['id'][0];
    return SongListDetail(id: int.parse(id));
  }
);

// 播放歌曲
var playSongHandler = Handler(
  handlerFunc: ( BuildContext context, Map<String, List<String>> parameters) {
    return PlaySong();
  }
);