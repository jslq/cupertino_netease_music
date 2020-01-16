import 'package:flutter/material.dart';

import 'package:ne_music/utils/constant.dart' show Constant;

class NeBanner extends StatefulWidget {

  final bannberPics = <String>[
    'https://cdn.cnbj1.fds.api.mi-img.com/mi-mall/7c5524bbd8d8e2d8b4fec3774915d2fb.jpg?w=632&h=340',
    'https://cdn.cnbj1.fds.api.mi-img.com/mi-mall/daae21ecb17e628f5255412f103c626f.jpg?w=632&h=340',
    'https://cdn.cnbj1.fds.api.mi-img.com/mi-mall/816a66edef10673b4768128b41804cae.jpg?w=632&h=340'
  ]; 

  @override
  _NeBannerState createState() => _NeBannerState();
}

class _NeBannerState extends State<NeBanner> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        _buildPageView(),
        _buildIndicator(),
      ]
    );
  }

  final _pageController = PageController(
    initialPage: 1
  );

  final int _activedIndex = 0;

  _buildPageView() {
    return AspectRatio(
      aspectRatio: Constant.size['bannerAspectRadtio'],
      child: PageView(
        controller: _pageController,
        children: widget.bannberPics.map((pic){
          return Padding(
            padding: EdgeInsets.all(15.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(6.0)),
              child: Image(
                fit: BoxFit.fill,
                image: NetworkImage(pic),
              ),
            ),
          );
        }).toList()    
      ),
    );
  }

  _buildIndicator() {
    return Positioned(
      bottom: 20.0,
      child: Row(
        children: widget.bannberPics.asMap().keys.map((index) {
          return Padding(
            key: Key(index.toString()),
            padding: EdgeInsets.only(
              left: 2.0,
              right: 2.0
            ),
            child: Container(
              width: 7.0, 
              height: 7.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: index == _activedIndex ? Theme.of(context).primaryColor : Constant.color['indicatorColor'],
              ),
            ),
          );
        }).toList(),
      ),
    ); 
  }
}