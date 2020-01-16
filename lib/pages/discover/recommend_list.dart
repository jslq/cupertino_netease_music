import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ne_music/widgets/custom_future_builder.dart';
import 'package:ne_music/utils/net_utils.dart';
import 'package:ne_music/models/recommend.dart';
import 'package:ne_music/utils/constant.dart';

class RecommendListView extends StatefulWidget {
  @override
  _RecommendListViewState createState() => _RecommendListViewState();
}

class _RecommendListViewState extends State<RecommendListView> {
  Future _recommendListFuture;

  @override
  void initState() {
    super.initState();
    _recommendListFuture = NetUtils.getRecommondList(context);
  }

  List<Widget> _buildGridViewItems(data) {
    final List<Widget> list = <Widget>[];
    int l = data.length;
    // data长度超过6个，这里我们只要显示6个即可
    for(int i = 0; i < l; i += 1) {
      list.add(Container(
        child: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.0,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                child: Image(
                  image: NetworkImage(data[i].picUrl)
                ),
              )
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Text(
                data[i].name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12, 
                ),
                strutStyle: StrutStyle(
                  forceStrutHeight: true
                ),
              ),
            )
          ],
        ),
      ));
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: CustomFutureBuilder<RecommendList>(
        future: _recommendListFuture,
        builder: (BuildContext context, RecommendList value) {
          return Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(value.title, 
                        style: TextStyle(
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      Container(
                        width: 60.0,
                        height: 26.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: Constant.color['borderColor']),
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                        ),
                        child: Text('歌单广场', 
                          style: TextStyle(
                            fontSize: 12.0                            
                          ),
                        )
                      )
                    ],
                  )
                ),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 20 / 28,
                  children: _buildGridViewItems(value.list),
                )
              ]
            )
          );
        }
      )
    );
  }
}