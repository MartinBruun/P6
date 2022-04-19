import 'package:flutter/material.dart';
import 'package:washee/core/widgets/dialog_box_Ok.dart';

class IncorrectInput extends StatelessWidget {
  const IncorrectInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
          child:
              DialogBoxOk(boxMessage: "Ugyldig email eller kodeord indtastet")),
    );
  }
}
