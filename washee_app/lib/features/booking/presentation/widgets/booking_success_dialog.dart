import 'package:flutter/material.dart';
import 'package:washee/core/widgets/dialog_box_Ok.dart';

class BookingSuccessDialog extends StatelessWidget {
  const BookingSuccessDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(child: DialogBoxOk("Du har nu booket en maskine")),
    );
  }
}
