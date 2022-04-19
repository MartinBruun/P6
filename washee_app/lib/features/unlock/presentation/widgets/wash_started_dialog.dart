import 'package:flutter/material.dart';
import 'package:washee/core/widgets/dialog_box_Ok.dart';

class WashStartedDialog extends StatelessWidget {
  const WashStartedDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(child: DialogBoxOk(boxMessage: "Din maskine er nu låst op")),
    );
  }
}
