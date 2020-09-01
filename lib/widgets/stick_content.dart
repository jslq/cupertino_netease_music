import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 吸顶主体部分（我的音乐，我的歌单）
class BuildStickyContent extends StatelessWidget {
  BuildStickyContent({
    this.minHeight,
    this.maxHeight,
    this.child
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true, //是否固定在顶部
      delegate: _SliverContentDelegate(
        minHeight: minHeight,
        maxHeight: maxHeight, 
        child: child,
      )
    );
  }
}


class _SliverContentDelegate extends SliverPersistentHeaderDelegate {
  _SliverContentDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(_SliverContentDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
