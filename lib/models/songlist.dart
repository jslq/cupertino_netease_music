import 'package:ne_music/models/basic_model.dart';

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


class Song extends BasicModel {
  Song({
    this.initialData,
    this.coverImgUrl,
    this.name, 
    this.trackCount,
    this.ordered,
  });
  
  Map<String, dynamic> initialData;
  String coverImgUrl;
  String name;
  int trackCount;
  bool ordered;

  Song.fromJson(
    Map<String, dynamic> data
  ) : super.fromJson(data) {
    coverImgUrl = data['coverImgUrl'];
    name = data['name'];
    trackCount = data['trackCount'];
    ordered = data['ordered'];
  }
}