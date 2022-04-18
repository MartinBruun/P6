import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextInput extends StatelessWidget {
  final String text;
  final String? Function(String?) validator;
  final TextEditingController controller;
  final bool obscure;

  TextInput({
    required this.text,
    required this.controller,
    required this.obscure,
    required this.validator,
  });

  final OutlineInputBorder _borderStyle = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
        child: TextFormField(
          validator: this.validator,
          onSaved: (value) {},
          controller: this.controller,
          obscureText: obscure,
          style: TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          decoration: InputDecoration(
              enabledBorder: _borderStyle,
              focusedBorder: _borderStyle,
              labelText: this.text,
              labelStyle: TextStyle(color: Colors.white)),
        ));
  }
}
