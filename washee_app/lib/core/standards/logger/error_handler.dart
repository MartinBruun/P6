import 'package:flutter/material.dart';

class ErrorHandler {
  static Future errorHandlerView(
      {required BuildContext context, required Widget prompt}) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return prompt;
      },
    );
  }
}
