import 'package:flutter/material.dart';

typedef VoidCallback = void Function();

class NeCustomButton extends StatelessWidget {
  const NeCustomButton({
    Key key,
    @required this.onPressed, 
    this.height,
    this.text = '',
    this.color = Colors.white,
    this.textColor = Colors.white,
    this.fontSize = 12,
  }): assert(height > 0.0),
      assert(
        text != null,
        'A non-null String must be provided to a Text widget.',
      ),
      opacity = null,
      super(key: key);

  const NeCustomButton.opacity({
    Key key, 
    @required this.onPressed, 
    this.opacity,
    this.height,
    this.text = '',
    this.color = Colors.white,
    this.textColor = Colors.white,
    this.fontSize = 12,
  }) ;

  final VoidCallback onPressed;
  final double height;
  final String text;
  final Color color;
  final Color textColor;
  final double fontSize;
  final double opacity;

  _buildMain() {
    return Container(
      alignment: AlignmentDirectional.center,
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(height / 2))
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontWeight: FontWeight.w500
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: opacity != null ? Opacity(
        opacity: opacity,
        child: _buildMain(),
      ) : _buildMain()
    );
  }
}