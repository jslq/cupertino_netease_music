import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 替代GridView布局的
class CustomGridList extends StatefulWidget {
  const CustomGridList({
    Key key,
    this.axisCount = 2,
    this.spacing = 0.0,
    @required this.rowHeight,
    this.rowSpacing = 0.0,
    @required this.children,
  }) : assert(axisCount > 1, 'axisCount 必须大于1，否则没必要用这个组件'),
      assert(rowHeight != null, 'rowHeight必填'),
      super(key: key);

  final int axisCount;
  final double spacing;
  final double rowHeight;
  final double rowSpacing;
  final List<Widget> children;

  @override
  _CustomGridListState createState() => _CustomGridListState();
}

class _CustomGridListState extends State<CustomGridList> {
  List<Widget> separatedList;

  @override
  void initState() {
    super.initState();
    List<Widget> children = widget.children;
    separatedList = _buildSubRow(children);
  }

  Widget _withExpanded(Widget child) {
    return Expanded(
      flex: 1,
      child: child,
    );
  }

  List<Widget> _buildSubRow(List<Widget> widgets) {
    final List<Widget> result = [];
    final int axisCount = widget.axisCount;
    if (widgets.isEmpty) {
      return result;
    } 
    List<Widget> _newRow;
    for(int i = 0; i < widgets.length; i += 1 ) {
      if (i % axisCount == 0) {
        _newRow = [];
        _newRow.add(_withPadding(widgets[i]));
      } else if (i % axisCount == (axisCount - 1)) {
        _newRow.add(_withExpanded(widgets[i]));
        result.add(_buildConstrainedRow(_newRow));
      } else {
        _newRow.add(_withPadding(widgets[i]));
      }

      if(i == widgets.length - 1) {
          // 如果当前行的元素小雨每行个数，那么填充进去空的
        if (_newRow.length < axisCount) {
          while(_newRow.length != 0 && _newRow.length < axisCount) {
            _newRow.add(Expanded(flex: 1, child: Container(),));
          }
          result.add(_buildConstrainedRow(_newRow));
        }
      }
    }
    return result;
  }

  Widget _withPadding(Widget single) {
    return _withExpanded(
      Padding(
        padding: EdgeInsets.only(right: widget.spacing),
        child: single,
      )
    );
  }

  Widget _buildConstrainedRow(List<Widget> children) {
    return Container(
      padding: EdgeInsets.only(bottom: widget.rowSpacing),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: widget.rowHeight,
        ),
        child: Row(
          children: children,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: separatedList,
    );
  }
}