import 'package:flutter/cupertino.dart';
import 'package:ne_music/models/songlist.dart';
import 'package:ne_music/utils/net_utils.dart';

class SongListModel with ChangeNotifier {
  SongList _songList;

  SongList get songList => _songList;

  Future<SongList> getSonglist(BuildContext context) async {
    SongList list = await NetUtils.getSongList(context);
    _songList = list;
    return list;
  }
}