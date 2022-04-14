import 'package:flutter/material.dart';
import 'package:washee/features/sign_in/presentation/widgets/dialog_box_Ok.dart';

class IncorrectInput extends StatelessWidget {
  const IncorrectInput({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: DialogBoxOk("Ugyldig email eller kodeord indtastet")
      ),
    );
  }
}