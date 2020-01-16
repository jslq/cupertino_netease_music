import 'package:ne_music/models/basic_model.dart';

class RecommendList extends BasicModel {
  RecommendList({
    final title = '推荐歌单',
    this.initialData,
    this.list,
  }) : super(initialData: initialData);

  Map<String, dynamic> initialData;
  String title;
  List<Recommend> list;

  RecommendList.fromJson(
    Map<String, dynamic> data
  ) : super.fromJson(data) {
    title = '推荐歌单';
    List<dynamic> l = data['recommend'] ?? [];
    list = l.map((_) {
      return Recommend.fromJson(_);
    }).toList();
  }

}

class Recommend extends BasicModel {
  Recommend({
    this.picUrl,
    this.name,
    this.playcount,
  });

  Recommend.fromJson(
    Map<String, dynamic> data
  ) : super.fromJson(data) {
    picUrl = data['picUrl'];
    name = data['name'];
    playcount = data['playcount'];
  }

  String picUrl;
  String name;
  int playcount;
}