import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ne_music/utils/constant.dart';
import 'package:ne_music/widgets/iconfont.dart';
import 'package:ne_music/widgets/ne_banner.dart';
import 'package:ne_music/widgets/ne_item.dart' show NeCircleItem;
import 'package:ne_music/pages/discover/recommend_list.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {

  final double _textFieldPadding = 100;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: _buildAppBar(),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Positioned(
                  child: Container(
                    width: double.infinity,
                    height: 54.0,
                    color: CupertinoTheme.of(context).primaryColor,
                  ),
                ),
                NeBanner(),
              ],
            ),
            ItemLinkBar(),
            // RecommendListView(),
          ],
        ),
      ),
    );
  }

  CupertinoNavigationBar _buildAppBar() {
    return CupertinoNavigationBar(
      backgroundColor: CupertinoTheme.of(context).primaryColor,
      border: Border(),
      leading: GestureDetector(
        onTap: () {
        },
        child: Icon(NeMusicIcon.shiqu,
          size: 23,
          color: Colors.white,
        ),
      ),
      trailing: GestureDetector(
        onTap: () {
        },
        child: Icon(NeMusicIcon.music,
          size: 20,
          color: Colors.white,
        ),
      ),
      middle: Container(
        padding: EdgeInsets.only(
          left: 10,
          right: 10
        ),
        height: 36.0,
        decoration: BoxDecoration(
          color: Constant.color['searchInputColor'],
          borderRadius: BorderRadius.circular(18)
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: _textFieldPadding
          ),
          child: CupertinoTheme(
            data: CupertinoThemeData(
              primaryColor: Colors.white,
            ),
            child: CupertinoTextField(
              decoration: BoxDecoration(
                color: Colors.transparent
              ),
              prefix: Icon(Icons.search, 
                color: Colors.white60,
              ),
              placeholder: '王力宏',
              placeholderStyle: TextStyle(
                color: Colors.white60
              ),
            ),
          ),
        ),
      ),
    );
  }
}


// 轮播图下的5个导航按钮
class ItemLinkBar extends StatelessWidget {
  final items = <Map>[
    {
      'image': 'assets/images/icon_daily.png',
      'labelText': '每日推荐'
    },
    {
      'image': 'assets/images/icon_playlist.png',
      'labelText': '歌单'
    },
    {
      'image': 'assets/images/icon_rank.png',
      'labelText': '排行榜'
    },
    {
      'image': 'assets/images/icon_radio.png',
      'labelText': '电台'
    },
    {
      'image': 'assets/images/icon_look.png',
      'labelText': '直播'
    }
  ];


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            top: 5,
            left: 15,
            right: 15
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.map((item) {
              return NeCircleItem(
                image: item['image'],
                labelText: item['labelText'],
              );
            }).toList(),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 10
          ),
          child: Divider(),
        )
      ],
    );
  }
}