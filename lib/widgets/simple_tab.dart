import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef IndexedWidgetBuilder = Widget Function(BuildContext context, int index);
typedef ItemOnTap = void Function(int index);

class ContentController extends ChangeNotifier {
  ContentController(): _content = Container();
  Widget _content;
  Widget get content => _content;
  set content(newContent) {
    _content = newContent;
    notifyListeners();
  }
}

class SimpleTabBar extends StatefulWidget {
  const SimpleTabBar({
    Key key,
    this.defaultActiveTabIndex = 0,
    this.spacing = 15,
    this.direction = Axis.horizontal,
    @required this.tabContentBuilder,
    this.onTap,
    this.contentController,
    this.activeColor = Colors.black,
    @required this.items,
  }): assert(items != null && items.length > 1 , 'items必须是长度大于等于的集合'),
      assert(tabContentBuilder != null, 'tabBuilder必须传'),
      super(key: key);

  /// 默认激活状态的tab的index的值
  final int defaultActiveTabIndex;

  /// 每个tabItem间距
  final double spacing;

  /// tabbar方向
  final Axis direction;

  /// tabItem点击事件
  final ItemOnTap onTap;

  final IndexedWidgetBuilder tabContentBuilder;

  /// eventBus控制器
  final ContentController contentController;

  /// 激活颜色
  final Color activeColor;

  /// [SimpleTabItem]集合
  final List<SimpleTabItem> items;

  @override
  _SimpleTabBarState createState() => _SimpleTabBarState();
}

class _SimpleTabBarState extends State<SimpleTabBar> {
  int currentIndex;

  @override
  void initState() {
    currentIndex =  widget.defaultActiveTabIndex ?? 0;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((call) {
      widget.contentController.content = _buildCurrentContent(currentIndex);
    });
  }

  Widget _buildCurrentContent(index) {
    Widget content = widget.tabContentBuilder(context, index);
    return content;
  }

  void onTap(index) {
    setState(() {
      currentIndex = index;
    });
    widget.contentController.content = _buildCurrentContent(index);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
        color: Colors.black.withOpacity(.5),
      ),
      child: Container(
        child: Flex(
          direction: widget.direction,
          children: _withDecorated(widget.items),
        ),
      ),
    );
  }

  List<Widget> _withDecorated(items) {
    List<Widget> itemsAfter = [];
    for(int index = 0; index < items.length; index += 1) {
      bool active = currentIndex == index;
      if (active) {
        itemsAfter.add(_withActivedItem(items[index], index));
      } else {
        itemsAfter.add(_withNormalItem(items[index], index));
      }
    }
    return itemsAfter;
  }

  Widget _withNormalItem(item, index) {
    return GestureDetector(
      onTap: () {
        widget.onTap == null ? () {}: widget.onTap(index);
        onTap(index);
      },
      child: item,
    );
  }

  Widget _withActivedItem(item, index) {
    return DefaultTextStyle(
      style: TextStyle(color: widget.activeColor),
      child: _withNormalItem(item, index),
    );
  }
}

class SimpleTabItem extends StatelessWidget {
  SimpleTabItem({
    this.child,
  });

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
    );
  }
}



class SimpleTabContentSlot extends StatefulWidget {
  SimpleTabContentSlot({
    this.contentController,
  });
  
  final ContentController contentController; 

  _SimpleTabContentSlotState createState() => _SimpleTabContentSlotState();
}

class _SimpleTabContentSlotState extends State<SimpleTabContentSlot> {
  Widget _content = Container();
  @override
  void initState() {
    super.initState();
    widget.contentController.addListener(() {
      setState(() {
        _content = widget.contentController.content;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _content;
  }
}