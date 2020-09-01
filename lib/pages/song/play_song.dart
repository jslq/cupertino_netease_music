import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';
import 'package:common_utils/common_utils.dart';
import 'package:ne_music/providers/song_list.dart';
import 'package:provider/provider.dart';
import 'package:ne_music/widgets/transparent_cupertino_navigation_bar.dart';
import 'package:ne_music/widgets/v_empty_view.dart';
import 'package:ne_music/widgets/size_thumb_slider.dart';

class PlaySong extends StatefulWidget {
  @override
  _PlaySongState createState() => _PlaySongState();
}

class _PlaySongState extends State<PlaySong> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: _buildApprBar(context),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: _Bg()
          ),
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaY: 100,
              sigmaX: 100,
            ),
            child: Container(
              color: Colors.black38,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 88),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      setState(() {
                        currentIndex = currentIndex == 0 ? 1 : 0;
                      });
                    },
                    child: IndexedStack(
                      index: currentIndex,
                      children: [
                        Container(
                          width: double.infinity,
                          child: _JukeBox()
                        ),
                        Container(
                          width: double.infinity,
                          child: Text('2')
                        )
                      ]
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: _Progress(),
                ),
                _Control(),
                VEmptyView(30)
              ],
            ),
          )
        ],
      )
    );
  }

  TransparentCupertinoNavigationBar _buildApprBar(BuildContext context) {
    return TransparentCupertinoNavigationBar(
      backgroundColor: Colors.transparent,
      middle: Consumer<SongListModel>(
        builder: (BuildContext context, SongListModel value, Widget child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(value.currentSingleSongDetail.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(value.currentSingleSongDetail.arName,
                      style: TextStyle(
                        fontSize: 12
                      ),
                    ),
                  ),
                  Icon(Icons.chevron_right,
                    size: 18,
                    color: Colors.white,
                  )
                ],
              )
            ],
          );
        },
      ),
      border: Border(bottom: BorderSide(color: Colors.transparent, width: 0.0)),
    );
  }
}

/// 背景高斯模糊
class _Bg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SongListModel>(
      builder: (BuildContext context, SongListModel value, Widget child) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(value.currentSingleSongDetail.alPicUrl),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(.2), BlendMode.multiply)
            )
          )
        );
      },
    );
  }
}


/// 唱片机
class _JukeBox extends StatefulWidget {
  @override
  __JukeBoxState createState() => __JukeBoxState();
}

class __JukeBoxState extends State<_JukeBox> with TickerProviderStateMixin {
  AnimationController _ganController; //唱针控制器
  AnimationController _yuanController; //唱片控制器
  Animation<double> _ganAnimation;

  @override
  void initState() {
    super.initState();
    _yuanController =
        AnimationController(vsync: this, duration: Duration(seconds: 20));
    _ganController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _ganAnimation =
        Tween<double>(begin: -0.0, end: -0.09).animate(_ganController);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SongListModel>(
      builder: (BuildContext context, SongListModel value, Widget child) {
        if (value.status == MusicStatus.playing) {
          _yuanController.forward();
          _ganController.reverse();
        } else {
          _yuanController.stop();
          _ganController.forward();
        }
        return Stack(
          children: <Widget>[
            Positioned(
              top: ScreenUtil().setHeight(200),
              child: Container(
                padding: EdgeInsets.all(9),
                margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(75)),
                width: ScreenUtil().setWidth(600),
                height: ScreenUtil().setWidth(600),
                decoration: BoxDecoration(
                  color: Colors.white12,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white30, width: .4)
                ),
                child: RotationTransition(
                  turns: _yuanController,
                  child: Stack(
                    children: <Widget>[
                      Image(
                        image: AssetImage(
                          'assets/images/juke.png'
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(184))),
                            child: Image(
                              fit: BoxFit.cover,
                              image: NetworkImage(value.currentSingleSongDetail.alPicUrl),
                              width: ScreenUtil().setWidth(368),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ),
            ),
            Positioned(
              top: 10,
              left: ScreenUtil().setWidth(350),
              child: RotationTransition(
                turns: _ganAnimation,
                alignment: Alignment(
                  -1 +
                      (ScreenUtil().setWidth(45 * 2) /
                          (ScreenUtil().setWidth(293))),
                  -1 +
                      (ScreenUtil().setWidth(45 * 2) /
                          (ScreenUtil().setWidth(504)))),
                child: Image(
                  height: ScreenUtil().setHeight(300),
                  image: AssetImage('assets/images/gan.png')
                ),
              ),
            )
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _ganController.dispose();
    _yuanController.dispose();
    super.dispose();
  }
}


/// 兴趣爱好,评论
class _Hobby extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SongListModel>(
      builder: (BuildContext context, SongListModel value, Widget child) {
        return Container(
          child: Text(value.currentSingleSongDetail.arName),
        );
      },
    );
  }
}

/// 进度条
class _Progress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, SongListModel value, Widget child) {
        return StreamBuilder(
          stream: value.currentPositionStream,
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              var totalTime =
              snapshot.data.substring(snapshot.data.indexOf('-') + 1);
              var curTime = double.parse(snapshot.data.substring(0, snapshot.data.indexOf('-')));
              var curTimeStr = DateUtil.formatDateMs(curTime.toInt(), format: "mm:ss");
              return buildProgress(curTime, totalTime, curTimeStr, value);
            } else {
              return buildProgress(0.0, "1", "00:00", value);
            }
          },
        ); 
      },
    );
  }

  Widget buildProgress(double curTime, String totalTime, String curTimeStr, SongListModel model){
    return Container(
      height: ScreenUtil().setWidth(50),
      child: Row(
        children: <Widget>[
          Text(
            curTimeStr,
            style: TextStyle(fontSize: 11, color: Colors.white30)
          ),
          Expanded(
            child: CupertinoSizeThumbSlider(
              value: curTime,
              onChanged: (data) {
                model.sinkProgress(data.toInt());
              },
              onChangeStart: (data) {
                model.pause();
              },
              onChangeEnd: (data) {
                print(data);
                model.seekPlay(data.toInt());
              },
              activeColor: Colors.white,
              min: 0,
              max: double.parse(totalTime),
            ),
          ),
          Text(
            DateUtil.formatDateMs(int.parse(totalTime), format: "mm:ss"),
            style: TextStyle(fontSize: 11, color: Colors.white30)
          ),
        ],
      ),
    );
  }
}

/// 歌曲播放控制面板
class _Control extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      child: Consumer(
        builder: (BuildContext context, SongListModel value, Widget child) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.repeat_one, color: Colors.white,),
                Icon(Icons.skip_previous, color: Colors.white,),
                PlayingButtom(status: value.status,
                  controller: (status) {
                    value.togglePlay();
                  },
                ),
                Icon(Icons.skip_next, color: Colors.white,),
                Icon(Icons.menu, color: Colors.white,)
              ]
            ),
          );
        },
      )
    );
  }
}


typedef MusicStatusController = void Function(MusicStatus);

/// 播放暂停按钮
class PlayingButtom extends StatelessWidget {
  PlayingButtom({
    @required this.status,
    this.controller
  });

  final MusicStatus status;
  final MusicStatusController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        controller(status);
      },
      child: Container(
        width: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: .5)
        ),
        child: Center(
          child: status == MusicStatus.playing 
            ? Icon(Icons.pause, color: Colors.white, size: 40,) 
            : Icon(Icons.play_arrow, color: Colors.white, size: 40,),
        ),
      ),
    );
  }
}