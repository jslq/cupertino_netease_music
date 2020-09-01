import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  int i = 10;
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if(_controller.position.pixels == _controller.position.maxScrollExtent){
        setState(() {
          i = i + 10;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Colors.red,
        middle: Text('测试页面'),
      ),
      child: SingleChildScrollView(
        controller: _controller,
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 400,
                color: Colors.blue,
                child: Center(
                  child: Text('这是板块一')
                ),
              ),
              Container(
                height: 400,
                color: Colors.green,
                child: Center(
                  child: Text('这是板块二')
                ),
              ),
              MediaQuery.removePadding(
                removeTop: true,
                removeBottom: true,
                context: context,
                child: Container(
                  // height: 1000,
                  child: ListView.builder(
                    key: GlobalKey(),
                    // controller: _controller,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemExtent: 60,
                    itemCount: i,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Center(
                          child: Text('这是${index.toString()}行'),
                        ),
                      );
                    },
                  ),
                )
              )
            ],
          ),
        ),
      )
    );
  }
}

class SliverPage extends StatefulWidget {
  @override
  _SliverPageState createState() => _SliverPageState();
}

class _SliverPageState extends State<SliverPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Colors.blue,
        middle: Text('测试'),
      ),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              height: 300,
              color: Colors.pink,
              child: Wrap(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(right: 20),child: Text('333333') ),
                  Padding(padding: EdgeInsets.only(right: 20),child: Text('333') ),
                  Padding(padding: EdgeInsets.only(right: 20),child: Text('333333333') ),
                  Padding(padding: EdgeInsets.only(right: 20),child: Text('333') ),
                  Padding(padding: EdgeInsets.only(right: 20),child: Text('333333333333') ),
                  Padding(padding: EdgeInsets.only(right: 20),child: Text('333') ),
                  Padding(padding: EdgeInsets.only(right: 20),child: Text('333333333333') ),
                ],
              )
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _D(),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Container(
                height: 100,
                child: Text(index.toString()),
              );
            }, childCount: 10)
          )
        ],
      ),
    );
  }
}

class _D extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 50;

  @override
  double get maxExtent => 50;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 50,
      color: Colors.black,
      child: Text('我固定的头部', style: TextStyle(color: Colors.white)),
    );
  }

  @override
  bool shouldRebuild(_D oldDelegate) {
    return false;
  }
}