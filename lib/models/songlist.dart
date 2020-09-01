import 'package:ne_music/models/basic_model.dart';

// 歌单集合
class SongList extends BasicModel {
  SongList({
    this.initialData,
    this.list
  });

  Map<String, dynamic> initialData;
  List<Song> list;

  SongList.fromJson(
    Map<String, dynamic> data
  ) : super.fromJson(data) {
    List l = data['playlist'];
    list = l.map((_) { 
      return Song.fromJson(_);
    }).toList();
  }
}

// Song代表歌单中的一个，名字一开始取错，改改麻烦，歌就取SingleSong了
class Song extends BasicModel {
  Song({
    this.initialData,
    this.id,
    this.coverImgUrl,
    this.name, 
    this.trackCount,
    this.ordered,
  });
  
  Map<String, dynamic> initialData;
  int id;
  String coverImgUrl;
  String name;
  int trackCount;
  bool ordered;

  Song.fromJson(
    Map<String, dynamic> data
  ) : super.fromJson(data) {
    id = data['id'];
    coverImgUrl = data['coverImgUrl'];
    name = data['name'];
    trackCount = data['trackCount'];
    ordered = data['ordered'];
  }
}

/// 歌单详情，不是歌曲详情
class SongDetail extends BasicModel {
  SongDetail({
    this.creator,
    this.name,
    this.description,
    this.playCount,
    this.shareCount,
    this.commentCount,
    this.tracks,
  });

  SongCrator creator;
  String name;
  String description;
  String coverImgUrl;
  int playCount;
  int shareCount;
  int commentCount;
  List<Track> tracks;

  SongDetail.fromJson(
    Map<String, dynamic> data
  ) : super.fromJson(data) {
    Map playlist = data['playlist'];
    creator = SongCrator.fromJson(playlist['creator']);
    name = playlist['name'];
    description = playlist['description'];
    coverImgUrl = playlist['coverImgUrl'];
    playCount = playlist['playCount'];
    shareCount = playlist['shareCount'];
    commentCount = playlist['commentCount'];
    List t = playlist['tracks'];
    tracks = t.map((_) {
      return Track.fromJson((_));
    }).toList();
  }
}

class SongCrator extends BasicModel {
  SongCrator({
    this.nickname,
    this.avatarUrl
  });

  String nickname;
  String avatarUrl;

  SongCrator.fromJson(
    Map<String, dynamic> data
  ) : super.fromJson(data) {
    nickname = data['nickname'];
    avatarUrl = data['avatarUrl'];
  }
}

// 歌单中的单首歌曲
class Track extends BasicModel {
  Track({
    this.id,
    this.name,
    this.arName,
    this.alName,
    this.alia,
  });
  
  int id;
  String name;
  String arName;
  String alName;
  List<dynamic> alia;

  Track.fromJson(
    Map<String, dynamic> data
  ) : super.fromJson(data) {
    id = data['id'];
    name = data['name'];
    arName = data['ar'][0] != null ? data['ar'][0 ]['name'] : '';
    alName = data['al']['name'];
    alia = data['alia'];
  }
}

// 歌单中所有歌曲详情
class SingleSongDetails extends BasicModel {
  SingleSongDetails({
    this.songs
  });

  List<SingleSongDetail> songs;

  SingleSongDetails.fromJson(
     Map<String, dynamic> data
  ) : super.fromJson(data) {
    List t = data['songs'];
    songs = t.map((_) {
      return SingleSongDetail.fromJson((_));
    }).toList();
  }
}

class SingleSongDetail extends BasicModel {
  SingleSongDetail({
    this.name,
    this.id,
    this.arName,
    this.alPicUrl,
  });

  String name;
  int id;
  String arName;
  String alPicUrl;

  SingleSongDetail.fromJson(
    Map<String, dynamic> data
  ) : super.fromJson(data) {
    id = data['id'];
    name = data['name'];
    arName = data['ar'][0]['name'];
    alPicUrl = data['al']['picUrl'];
  }
}
