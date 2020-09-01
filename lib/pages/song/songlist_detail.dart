import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:ne_music/utils/net_utils.dart';
import 'package:ne_music/utils/navigator_util.dart';
import 'package:provider/provider.dart';
import 'package:ne_music/providers/song_list.dart';
import 'package:ne_music/widgets/custom_future_builder.dart';
import 'package:ne_music/widgets/transparent_cupertino_navigation_bar.dart';
import 'package:ne_music/models/songlist.dart';
import 'package:ne_music/utils/util.dart';
import 'package:ne_music/widgets/iconfont.dart';
import 'package:ne_music/widgets/stick_content.dart';

const double navbarHeight = 88.0;

class HeightController with ChangeNotifier {
  static double initHeight = 210.0;
  
  HeightController(): _height = initHeight;
  
  double _height;
  get height => _height;
  set height(value) {
    _height = value;
    notifyListeners();
  }
}

// 歌单详情页面
class SongListDetail extends StatefulWidget {
  const SongListDetail({
    this.id,
  });

  final int id;
  @override
  _SongListDetailState createState() => _SongListDetailState();
}

class _SongListDetailState extends State<SongListDetail> {
  final ScrollController _srollController = ScrollController();
  final HeightController _heightController = HeightController();

  @override
  void initState() {
    super.initState();
    _srollController.addListener(() {
      if (_srollController.offset < 0) {
        _heightController.height = HeightController.initHeight - _srollController.offset;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    double bottomBarHeight = MediaQuery.of(context).padding.bottom;
    double navHeight = MediaQueryData.fromWindow(window).padding.top;
    double screenHeight = MediaQuery.of(context).size.height;
    double maxHeight = screenHeight - navHeight - bottomBarHeight;
    
    return CustomFutureBuilder<SongDetail>(
      future: Provider.of<SongListModel>(context).getSongDetail(context, widget.id),
      builder: (BuildContext context, SongDetail value) {
        return CupertinoPageScaffold(
          navigationBar: _InnerNavbar(),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: _Bg(
                  controller: _heightController,
                  imageUrl: value.coverImgUrl,
                ),
              ),
              Positioned(
                top: navbarHeight,
                bottom: bottomBarHeight,
                left: 0,
                right: 0,
                child: CustomScrollView(
                  controller: _srollController,
                  physics: AlwaysScrollableScrollPhysics(),
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: _DetailInfo(
                        creator: value.creator,
                        name: value.name,
                        description: value.description,
                        coverImgUrl: value.coverImgUrl,
                        playCount: value.playCount,
                        shareCount: value.shareCount,
                        commentCount: value.commentCount,
                      ),
                    ),
                    BuildStickyContent(
                      minHeight: 44,
                      maxHeight: 44,
                      child: _PlayListHeader()
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return _BuildSongListItem(
                          index: index, 
                          data: value.tracks[index]
                        );
                      },
                      childCount: value.tracks.length,
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _srollController.dispose();
    _heightController.dispose();
  }
}


class _InnerNavbar extends StatefulWidget implements ObstructingPreferredSizeWidget {
  @override
  bool shouldFullyObstruct(BuildContext context) {
    return false;
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(44.0);
  }
  
  @override
  __InnerNavbarState createState() => __InnerNavbarState();
}

class __InnerNavbarState extends State<_InnerNavbar> {
  @override
  void initState() {
    super.initState();
   
  }
  @override
  Widget build(BuildContext context) {
    return TransparentCupertinoNavigationBar(
      backgroundColor: Colors.transparent,
      middle: Text('歌单', style: TextStyle(color: Colors.white),),
      border: Border(bottom: BorderSide(color: Colors.transparent, width: 0.0)),
    );
  }
}

class _Bg extends StatefulWidget {
  _Bg({
    this.controller,
    this.imageUrl
  });

  HeightController controller;
  String imageUrl;

  @override
  __BgState createState() => __BgState();
}

class __BgState extends State<_Bg> {
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
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        height: height + navbarHeight + 20,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SizedBox(
              height: height + navbarHeight + 20,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.imageUrl),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(.2), BlendMode.multiply)
                  )
                ),
              ),
            ),
            ClipRRect(
              child:  BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: Colors.white.withAlpha(0),
                )
              ),
            )
          ],
        )
      ),
    );

  }
}


// 页面上部分内容
class _DetailInfo extends StatelessWidget {
  _DetailInfo({
    this.creator,
    this.name,
    this.description,
    this.coverImgUrl,
    this.playCount,
    this.shareCount,
    this.commentCount
  });
  final SongCrator creator;
  final String name; 
  final String description;
  final String coverImgUrl;
  final int playCount;
  final int shareCount;
  final int commentCount;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      padding: EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 120,
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  child: Container(
                    width: 120.0,
                    height: 120.0,
                    child: Stack(
                      children: <Widget>[
                        Image(
                          image: NetworkImage(coverImgUrl)
                        ),
                        Positioned(
                          right: 5,
                          top: 5,
                          child: _playCount(playCount),
                        )
                      ],
                    )
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text(name, 
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white
                                ),
                              ),
                            ),
                            // 头像，名字
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: NetworkImage(creator.avatarUrl),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Text(creator.nickname, style: TextStyle(
                                    color: Colors.white.withOpacity(.6),
                                    fontSize: 13
                                  ))
                                ),
                                Icon(Icons.arrow_forward_ios, size: 12, color: Colors.white.withOpacity(.6),)
                              ],
                            )
                          ],
                        ),
                        // 作者简介
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: 30.0
                          ),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(description ?? '暂无简介',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    height: 1.6,
                                    color: Colors.white.withOpacity(.6),
                                    fontSize: 11,
                                  )
                                )
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 6),
                                child: Icon(Icons.arrow_forward_ios, color: Colors.white.withOpacity(.6), size: 12,),
                              )
                            ]
                          )
                        )
                      ],
                    )
                  ),
                )
              ],
            ),
          ),
          _buildCountRow()
        ],
      ),
    );
  }

  Widget _buildCountRow() {
    final _textStyle = TextStyle(
      fontSize: 12,
      color: Colors.white,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Column(
          children: <Widget>[
            Icon(NeMusicIcon.comment, size: 20, color: Colors.white,),
            Padding(
              padding: EdgeInsets.only(top: 4),
              child: Text(Util.countNum(commentCount), style: _textStyle),
            )
          ],
        ),
        Column(
          children: <Widget>[
            Icon(NeMusicIcon.share, size: 20, color: Colors.white,),
            Padding(
              padding: EdgeInsets.only(top: 4),
              child: Text(Util.countNum(shareCount), style: _textStyle),
            )
          ],
        ),
        Column(
          children: <Widget>[
            Icon(NeMusicIcon.local_music, size: 20, color: Colors.white,),
            Padding(
              padding: EdgeInsets.only(top: 4),
              child: Text('下载', style: _textStyle),
            )
          ],
        ),
          Column(
          children: <Widget>[
            Icon(NeMusicIcon.multiple, size: 20, color: Colors.white,),
            Padding(
              padding: EdgeInsets.only(top: 4),
              child: Text('多选', style: _textStyle),
            )
          ],
        )
      ],
    );
  }

  _playCount(int num) {
    String txt = Util.countNum(num);
    return Row(
      children: <Widget>[
        Icon(Icons.play_arrow, color: Colors.white, size: 18,),
        Text(
          txt,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        )
      ],
    );
  }
}

class _PlayListHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))
      ),
      padding: EdgeInsets.only(
        top: 14.0,
        left: 15.0,
        right: 15.0,
        bottom: 10.0
      ),
      child: Row(
        children: <Widget>[
          Icon(Icons.play_circle_outline, color: Colors.black),
          Padding(
            padding: EdgeInsets.only(left: 4),
            child: Text('播放全部',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _BuildSongListItem extends StatelessWidget {
  _BuildSongListItem({
    this.data,
    this.index,
  }); 

  final int index;
  final Track data;

  @override
  Widget build(BuildContext context) {
    double _fontSize = index.toString().length > 2 ? 12 : 15;
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      height: 60.0,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          /// 设置当前歌曲的id，
          /// 并且设置当前播放歌曲id
          Provider.of<SongListModel>(context, listen: false).setCurrentSingleSongId(data.id);
          NavigatorUtil.goPlaySong(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 20,
              child: Text((index + 1).toString(), textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: _fontSize,
                  color: Colors.black.withOpacity(.4)
                ),
              ),
              margin: EdgeInsets.only(right: 10.0),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 3),
                          child: RichText(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              text: data.name,
                              style: TextStyle(color: Colors.black,  fontSize: 17,
                                  fontWeight: FontWeight.w400),
                              children: <TextSpan>[
                                TextSpan(
                                  text: data.alia.isEmpty ? '' : '(${data.alia.join()})',
                                  style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black.withOpacity(.6))
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          '${data.arName} - ${data.alName}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black.withOpacity(.4),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(Icons.more_vert, 
                      color: Colors.black.withOpacity(.4),
                    ),
                  )
                ],
              ),
            )
          ],
        )
      )
    );
  }
}

