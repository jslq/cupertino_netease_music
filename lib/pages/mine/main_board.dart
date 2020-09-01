import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ne_music/utils/navigator_util.dart';
import 'package:ne_music/widgets/custom_future_builder.dart';
import 'package:provider/provider.dart';
import 'package:ne_music/widgets/simple_tab.dart';

import 'package:ne_music/providers/song_list.dart';
import 'package:ne_music/models/songlist.dart' as sl;
import 'package:ne_music/widgets/custom_grid_list.dart';

// 我的音乐主体面板组件
class MainBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0)
      ),
      child: Column(
        children: <Widget>[
          // MyMusic(),
          SongList(),
        ],
      ),
    );
  }
}

class MyMusic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('我的音乐'),
              Icon(Icons.keyboard_arrow_right),
            ],
          ),
          Container(
            height: 160.0,
            color: Colors.red,
            child: ListView(
              scrollDirection: Axis.horizontal,
              controller: ScrollController(),
              children: <Widget>[
                Container(
                  width: 120,
                  height: 160,
                  child: Text('33'),
                ),
                Container(
                  width: 120,
                  height: 160,
                  child: Text('33'),
                ),
                Container(
                  width: 120,
                  height: 160,
                  child: Text('33'),
                ),
                Container(
                  width: 120,
                  height: 160,
                  child: Text('33'),
                ) 
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SongList extends StatefulWidget {
  @override
  _SongListState createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  final _contentController = ContentController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 15,
            right: 15,
            bottom: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CustomFutureBuilder(
                future: Provider.of<SongListModel>(context).getSonglist(context),
                builder: (context, value) {
                  return SimpleTabBar(
                    contentController: _contentController,
                    items: _buildTabItem(),
                    tabContentBuilder: (BuildContext context, int index) {
                      switch (index) {
                        case 0: 
                          return Consumer<SongListModel>(
                            builder: (BuildContext context, SongListModel value, Widget child) {
                              return SongGridList(
                                key: GlobalKey(),
                                data: value.songList.list.where((_) => _.ordered == false).toList(),
                              );
                            },
                          );
                        case 1:
                          return Consumer<SongListModel>(
                            builder: (BuildContext context, SongListModel value, Widget child) {
                              return SongGridList(
                                key: GlobalKey(),
                                data: value.songList.list.where((_) => _.ordered == true).toList(),
                              );
                            },
                          );
                        case 2:
                          return Text('3');
                      }
                      return Container();
                    }
                  );
                },
              ),
              Icon(Icons.more_vert, color: Colors.black.withOpacity(.5)),
            ],
          )
        ),
        SimpleTabContentSlot(
          contentController: _contentController,
        )
      ],
    );
  }

  _buildTabItem() {
    final List<SimpleTabItem> items = <SimpleTabItem>[];
    items..add(SimpleTabItem(
      child: Consumer<SongListModel>(
        builder: (BuildContext context, SongListModel value, Widget child) {
          return Padding(
            padding: EdgeInsets.only(right: 15),
            child: Row(
              children: [
                Text('创建歌单', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                Text(value.songList.list.where((_) => _.ordered == false).toList().length.toString(), style: TextStyle(fontSize: 10))
              ]
            ),
          );
        },
      )
    ))..add(SimpleTabItem(
      child: Consumer<SongListModel>(
        builder: (BuildContext context, SongListModel value, Widget child) {
          return Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: Row(
              children: [
                Text('收藏歌单', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                Text(value.songList.list.where((_) => _.ordered == true).toList().length.toString(), style: TextStyle(fontSize: 10))
              ]
            ),
          );
        },
      )
    ))..add(SimpleTabItem(
      child: Row(
        children: [
          Text('歌单助手', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
          Text('beta', style: TextStyle(fontSize: 10))
        ]
      )
    ));
    return items;
  }
}

class SongGridList extends StatelessWidget {
  const SongGridList({
    Key key,
    @required this.data,
  }) : super(key: key);

  final List<sl.Song> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: CustomGridList(
        spacing: 10,
        rowHeight: 60,
        rowSpacing: 14,
        children: _buildList(context),
      ),
    );
  }

  List<Widget> _buildList(BuildContext context) {
    final List<Widget> res = [];
    for(int i = 0; i < data.length; i++) {
      res.add(
        GestureDetector(
          onTap: () {
            NavigatorUtil.goSongListDetailPage(context, data[i].id);
          },
          child: Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  border: Border.all(color: Colors.grey.withOpacity(.2)),
                ),
                margin: EdgeInsets.only(right: 8.0),
                width: 60,
                height: 60,
                child:  ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Image(
                    image: NetworkImage(data[i].coverImgUrl),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data[i].name,
                      style: TextStyle(
                        fontSize: 13.0,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Text('${data[i].trackCount}首', 
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.withOpacity(.8),
                      )
                    )
                  ]
                ),
              )
            ],
          ),
        )
      );
    }
    return res;
  }
}