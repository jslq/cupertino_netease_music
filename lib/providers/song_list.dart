import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:ne_music/models/songlist.dart';
import 'package:ne_music/utils/net_utils.dart';

enum MusicStatus {
  playing,
  pause,
}


/// 名字不够语意化，暂时不改了
class SongListModel with ChangeNotifier {
  /// 播放空间
  AudioPlayer _audioPlayer = AudioPlayer();

  StreamController<String> _currentPositionController = StreamController<String>.broadcast();

  Stream<String> get currentPositionStream => _currentPositionController.stream;

  MusicStatus status = MusicStatus.pause;

  // 当前歌曲的时长
  Duration _currentSingleSongDuration;

  void init() {
    _audioPlayer.setReleaseMode(ReleaseMode.STOP);

    // 监听地址变化
    _audioPlayer.onAudioPositionChanged.listen((Duration  p) {
      sinkProgress(p.inMilliseconds > _currentSingleSongDuration.inMilliseconds ? _currentSingleSongDuration.inMilliseconds : p.inMilliseconds);
    });

    _audioPlayer.onDurationChanged.listen((Duration d) {
      _currentSingleSongDuration = d;
    });
  }

  // 歌曲进度
  void sinkProgress(int m){
    _currentPositionController.sink.add('$m-${_currentSingleSongDuration.inMilliseconds}');
  }

  void play() async {

    await _audioPlayer.play("https://music.163.com/song/media/outer/url?id=${_currentSingleSongId}.mp3");
    status = MusicStatus.playing;
    notifyListeners();
  }

  void togglePlay() async {
    if (_audioPlayer.state == AudioPlayerState.PLAYING) {
      await _audioPlayer.pause();
      status = MusicStatus.pause;
    } else {
      await _audioPlayer.resume();
      status = MusicStatus.playing;
    }

    notifyListeners();
  }

  /// 跳转到固定时间
  void seekPlay(int milliseconds){
    _audioPlayer.seek(Duration(milliseconds: milliseconds));
    play();
  }

  void pause() async {
    await _audioPlayer.pause();
    status = MusicStatus.pause;
    notifyListeners();
  }

  /// 歌单列表
  SongList _songList;

  SongList get songList => _songList;

  /// 歌单详情
  SongDetail _songDetail;

  /// 歌单中的歌曲详情
  List<SingleSongDetail> _singleSongDetails = [];

  /// 获取当前歌单所有歌曲id集合 
  String get songIds {
    return _songDetail.tracks.map((track) {
      return track.id;
    }).join(',');
  }

  SingleSongDetail get currentSingleSongDetail {
    return _singleSongDetails.firstWhere((_) {
      return _.id == _currentSingleSongId;
    });
  }

  /// 当前歌单的id,不是歌曲
  int _currentSongId;

  /// 当前播放歌曲的id
  int _currentSingleSongId;

  Future<SongList> getSonglist(BuildContext context) async {
    SongList list = await NetUtils.getSongList(context);
    _songList = list;
    return list;
  }

  Future<SongDetail> getSongDetail(BuildContext context, int id) async {
    if (id == _currentSongId) {
      print('shti');
      return _songDetail;
    }
    SongDetail result = await NetUtils.getSongDetail(context, id);
    _songDetail = result;
    setCurrentSondId(context, id);
    return result;
  }

  setCurrentSondId(BuildContext context, id) async {
    /// 获取歌单中
    SingleSongDetails result = await NetUtils.getSingleSongDetails(context, songIds);
    _singleSongDetails = result.songs;
    _currentSongId = id;
  }

  setCurrentSingleSongId(id) {
    _currentSingleSongId = id;
    play();
  }
}