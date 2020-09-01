import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ne_music/providers/user_model.dart';
import 'package:ne_music/widgets/iconfont.dart';

import 'package:ne_music/widgets/transparent_cupertino_navigation_bar.dart';
import 'package:ne_music/widgets/stick_content.dart';
import 'profile.dart';
import 'main_board.dart' show MainBoard;

const double navbarHeight = 88.0;

// 定义一个高度的控制器
class HeightController extends ChangeNotifier{
  HeightController(): _height = 151.0;

  static double initHeight = 151.0;

  double _height;

  get height => _height;

  set height(value) {
    _height = value;
    notifyListeners();
  }
}

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  // 定义一个滚动控制器
  final _controller = ScrollController();
  //实例化高度控制器
  final _heightController = HeightController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.offset < 0) {
        _heightController.height = HeightController.initHeight - _controller.offset;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: _buildApprBar(),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: BuildBg(controller: _heightController)
          ),
          Positioned(
            top: navbarHeight,
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomScrollView(
              controller: _controller,
              physics: AlwaysScrollableScrollPhysics(),
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: MineProfile(),
                ),
                BuildStickyContent(
                  minHeight: 250,
                  maxHeight: 1000,
                  child: MainBoard(),
                )
              ],
            ),
          )
        ],
      )
    );
  }

  TransparentCupertinoNavigationBar _buildApprBar() {
    final bar = TransparentCupertinoNavigationBar(
      backgroundColor: Colors.transparent,
      leading: Icon(
        NeMusicIcon.cloud,
        color: Colors.white,
        size: 25,
      ),
      border: Border(bottom: BorderSide(color: Colors.transparent, width: 0.0)),
    );
    return bar;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
}

//头部导航 + MineProfile背景组合
class BuildBg extends StatefulWidget {
  BuildBg({
    this.controller,
  });

  final HeightController controller;
  @override
  _BuildBgState createState() => _BuildBgState();
}

class _BuildBgState extends State<BuildBg> {
  double height;

  @override
  void initState() {
    super.initState();
    height = widget.controller.height;
    widget.controller.addListener(() {
      setState(() {
        height = widget.controller.height;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<UserModel>(
      builder: (BuildContext context, UserModel value, Widget child) {
        return Container(
          height: height + navbarHeight + 20,
          width: double.infinity,
          child: SizedBox(
            height: height + navbarHeight + 20,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(value.user.profile.backgroundUrl),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(.74), BlendMode.multiply)
                )
              )
            ),
          ),
        );
      }
    );
  }
}
