import 'package:flutter/material.dart';
import 'package:ne_music/application.dart';
import 'package:provider/provider.dart';
import 'package:ne_music/providers/user_model.dart';
import 'package:ne_music/utils/constant.dart';
import 'package:ne_music/widgets/iconfont.dart';
import 'package:ne_music/utils/navigator_util.dart';
import 'package:ne_music/utils/net_utils.dart';

class BootstrapPage extends StatefulWidget {
  @override
  _BootstrapPageState createState() => _BootstrapPageState();
}

class _BootstrapPageState extends State<BootstrapPage> {
  @override
  void initState() {
    super.initState();
    // 初始化网络请求
    Future net = NetUtils.init();
    // 初始化sp，都是异步的
    Future sp = Application.initSp();
    // 模拟延迟0.5毫秒，之后要在这里请求数据完成之后页面跳转
    Future delay = Future.delayed(Duration(milliseconds: 500));

    Future.wait([sp, net, delay]).then((_) {
      UserModel userModel = Provider.of<UserModel>(context, listen: false);
      userModel.initUser();
      if (userModel.user != null) {
        NavigatorUtil.goMainBoardPage(context);
      } else {
        NavigatorUtil.goLoginTypePage(context);
      }
      // NavigatorUtil.goLoginTypePage(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Constant.color['primaryColor'],
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Positioned(
            top: 270,
            child: Image(
              height: 40.0,
              image: AssetImage('assets/images/slogan.png'),
            ),
          ),
          Positioned(
            bottom: 30.0,
            child: Row(
              children: <Widget>[
                Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  alignment: Alignment.center,
                  child: Icon(NeMusicIcon.netease_music,
                    size: 12,
                    color: Constant.color['primaryColor'],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 8.0
                  ),
                  child: Image(
                    height: 16.0,
                    image: AssetImage('assets/images/logo_text.png'),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}