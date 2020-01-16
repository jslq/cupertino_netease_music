import 'package:ne_music/models/basic_model.dart';

class User extends BasicModel {
  User({
    this.initialData,
    this.account,
    this.userId,
    this.profile,
  }) : super(initialData: initialData);

  Map<String, dynamic> initialData;
  Account account;
  Profile profile;
  int userId;

  User.fromJson(
    Map<String, dynamic> data
  ) : super.fromJson(data) {
    account = data['account'] != null ? Account.fromJson(data['account']) : null;
    profile = data['profile'] != null ? Profile.fromJson(data['profile']) : null;
    userId = account.id;
  }
}


class Account extends BasicModel {
  Account({
    this.initialData,
    this.id
  }) : super(initialData: initialData);

  Map<String, dynamic> initialData;
  int id;

  Account.fromJson(
    Map<String, dynamic> data
  ) : super.fromJson(data){
    id = data['id'];
  }
}

class Profile extends BasicModel {
  Profile({
    this.initialData,
    this.nickname,
    this.backgroundUrl,
    this.avatarUrl,
    this.signature,
  }) : super(initialData: initialData);

  Map<String, dynamic> initialData;
  String nickname;
  String backgroundUrl;
  String avatarUrl;
  String signature;

  Profile.fromJson(
    Map<String, dynamic> data
  ) : super.fromJson(data){
    nickname = data['nickname'];
    backgroundUrl = data['backgroundUrl'];
    avatarUrl = data['avatarUrl'];
    signature = data['signature'];
  }
}