import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ne_music/utils/constant.dart';
import 'package:ne_music/widgets/iconfont.dart';
import 'package:ne_music/pages/discover/discover.dart';
import 'package:ne_music/pages/mine/mine.dart';


class MainBoard extends StatelessWidget {
  final navs = <dynamic>[
    {
      'icon': NeMusicIcon.discover,
      'title': '发现'
    },
    {
      'icon': NeMusicIcon.shipin,
      'title': '视频'
    },
    {
      'icon': NeMusicIcon.wode,
      'title': '我的'
    },
    {
      'icon': NeMusicIcon.yuncun,
      'title': '云村'
    },
    {
      'icon': NeMusicIcon.zhanghao,
      'title': '账号'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        key: GlobalKey(),
        backgroundColor: Colors.white.withOpacity(.6),
        items: _buildItems(navs),
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            switch (index) {
              case 0:
                return DiscoverPage();
              case 1: 
                return Container();
              case 2: 
                return MinePage();
            }
            return Container();
          },
        );
      }
    );
  }

  List<BottomNavigationBarItem> _buildItems(items) {
    final List<BottomNavigationBarItem> result = <BottomNavigationBarItem>[];

    for(int index = 0; index < items.length; index += 1) {
      result.add(
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(
              top: 5
            ),
            child: Icon(items[index]['icon'], 
              size: 19,
            ),
          ),
          activeIcon: Padding(
            padding: EdgeInsets.only(
              top: 5
            ),
            child: Container(
              width: 24,
              height: 24,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Constant.color['primaryColor'],
              ),
              child: Icon(items[index]['icon'],
                size: 13,
                color: Colors.white,
              ),
            ),
          ),
          title: _paddingLabel(items[index]['title'])
        )
      );
    }

    return result;
  }

  Widget _paddingLabel(label) {
    return Padding(
      padding: EdgeInsets.only(
        top: 3.0
      ),
      child: Text(label)
    );
  }
}