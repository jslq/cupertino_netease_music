import 'package:flutter/cupertino.dart';

class NeCircleItem extends StatelessWidget {
  /// 显示图片
  final String image;

  /// 显示图片下方文字
  final String labelText;
  NeCircleItem({this.image, this.labelText});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: CupertinoTheme.of(context).primaryColor,
            shape: BoxShape.circle,
          ),
          child: Image(
            image: AssetImage(image),

          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Text(labelText, 
            style: TextStyle(
              fontSize: 12.0
            ),
          ),
        )
      ],
    );
  }
}