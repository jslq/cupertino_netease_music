import 'package:ne_music/models/basic_model.dart';

class Banners extends BasicModel {
  Banners({
    this.list
  });

  List<Banner> list;

  Banners.fromJson(
    Map<String, dynamic> data
  ) : super.fromJson(data) {
    List l = data['banners'];
    list = l.map((_) {
      return Banner.fromJson(_);
    });
  }
}


class Banner extends BasicModel {
  Banner({
    this.imageUrl,
    this.titleColor,
    this.typeTitle,
    this.targetId, 
    this.targetType
  });

  String imageUrl;
  String titleColor;
  String typeTitle;
  int targetId;
  int targetType;

  Banner.fromJson(
    Map<String, dynamic> data
  ) : super.fromJson(data) {
    imageUrl = data['imageUrl'];
    titleColor = data['titleColor'];
    typeTitle = data['typeTitle'];
    targetId = data['targetId'];
    targetType = data['targetId'];
  }
}