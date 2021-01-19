import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final AlignmentDirectional alignment;
  final int maxLines;
  final FontWeight fontWeight;

  CustomText(
      {this.text = '',
      this.color = Colors.black,
      this.fontSize = 14,
      this.alignment = AlignmentDirectional.topStart,
      this.maxLines,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: Text(
        text,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style:
            TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight),
      ),
    );
  }
}
