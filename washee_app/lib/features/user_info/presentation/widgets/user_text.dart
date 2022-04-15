import 'package:flutter/material.dart';

class UserText extends StatelessWidget {
  String text;
  TextStyle style;
  double padding;
  
  UserText(this.text, this.style, this.padding);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: padding),
      child: Align(alignment: Alignment.topLeft,
        child: Text(
            text,
            style: style
        )
     )
    );
  }  
}