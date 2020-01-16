import 'package:flutter/cupertino.dart';

typedef ValueWidgetBuilder<T> = Widget Function(BuildContext context, T value);

class CustomFutureBuilder<T> extends StatefulWidget {
  CustomFutureBuilder({
    Key key,
    @required this.builder,
    @required this.future,
  }) : super(key: key);

  final Future future;
  final ValueWidgetBuilder<T> builder;

  @override
  _CustomFutureBuilderState<T> createState() => _CustomFutureBuilderState<T>();
}

class _CustomFutureBuilderState<T> extends State<CustomFutureBuilder<T>> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.future,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return Container();
          case ConnectionState.done: 
            return widget.builder(context, snapshot.data);
          default: 
            return Container();
        }
      },
    );
  }
}