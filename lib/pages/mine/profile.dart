import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import 'package:ne_music/providers/user_model.dart';
import 'package:ne_music/widgets/iconfont.dart';


class MineProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserModel>(
      builder: (BuildContext context, UserModel value, Widget child){
        return Container(
          width: double.infinity,
          height: 151,
          child: Padding(
            padding: EdgeInsets.only(
              // 这里应该设置为navbar的高度
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 10.0),
                  child: _MyProfileDisplay(
                    nickname: value.user.profile.nickname,
                    avatarUrl: value.user.profile.avatarUrl,
                    signature: value.user.profile.signature,
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15.0),
                  child: _NavItems(),
                )
              ],
            )
          ),
        );
      }
    );
  }
}

// 本地音乐等导航属性
class ItemAttr {
  const ItemAttr({
    this.label,
    this.icon,
    this.iconSize = 26.0,
    this.left = 0.0,
    this.top = 0.0,
  });

  final String label;
  final IconData icon;
  final double iconSize;
  final double top;
  final double left;
}

// 本地音乐等导航组件
class _NavItems extends StatelessWidget {
  final List<ItemAttr> items = [
    ItemAttr(label: '本地音乐', icon: NeMusicIcon.local_music),
    ItemAttr(label: '我的电台', icon: NeMusicIcon.mine_radio, iconSize: 34, left: -1, top: -4),
    ItemAttr(label: '我的收藏', icon: NeMusicIcon.mine_collection, iconSize: 25, left: -5),
    ItemAttr(label: '关注新歌', icon: NeMusicIcon.local_music),
  ];

  List<Widget> _buildItems() {
    final List<Widget> result = <Widget>[];
    for(int i = 0; i < items.length; i += 1) {
      result.add(
        SizedBox(
          height: 53,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Transform.translate(
                offset: Offset(
                  items[i].left,
                  items[i].top,
                ),
                child: Icon(items[i].icon,
                  color: Colors.white,
                  size: items[i].iconSize,
                ),
              ),
              Text(items[i].label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.0
                ),
              )
            ],
          ),
        )
      );
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 10.0,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _buildItems(),
        ),
      ),
    );
  }
}

// 我的个人信息展示
class _MyProfileDisplay extends StatelessWidget {

  _MyProfileDisplay({
    this.nickname = '',
    this.avatarUrl = '',
    this.signature = ''
  });

  String nickname;
  String avatarUrl;
  String signature;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        height: 44.0,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              right: -5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('进入会员中心',
                    style: TextStyle(
                      color: Colors.white.withOpacity(.5),
                      fontSize: 12,
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_right, color: Colors.white.withOpacity(.5), size: 19,)
              ])
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Image(
                      image: NetworkImage(avatarUrl),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(nickname,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    Text(signature, 
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withOpacity(.7),
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      )
    );
  }
}