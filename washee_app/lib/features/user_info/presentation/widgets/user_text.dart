import 'package:flutter/material.dart';

class UserText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final double padding;

  UserText(this.text, this.style, this.padding);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: padding),
        child: Align(
            alignment: Alignment.topLeft, child: Text(text, style: style)));
  }
}
