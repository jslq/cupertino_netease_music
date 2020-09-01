import 'package:flutter/cupertino.dart';

class VEmptyView extends StatelessWidget {
  VEmptyView(
    this.height
  );

  double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
    );
  }
}