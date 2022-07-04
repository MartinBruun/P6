import 'package:flutter/material.dart';
import 'package:washee/core/ui/base_widgets/dialog_box_Ok.dart';

class SomethingWrong extends StatelessWidget {
  const SomethingWrong({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(child: DialogBoxOk(boxMessage: "Noget gik galt")),
    );
  }
}
