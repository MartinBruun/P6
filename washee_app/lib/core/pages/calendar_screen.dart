import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CalendarScreen extends StatelessWidget {
  static const routeName = "/calendar-screen";
  @override
  Widget build(BuildContext context) {
    // var mediaHeight = MediaQuery.of(context).size.height;

    return Scaffold(

      backgroundColor: Colors.orange,
      body: Center( child:  SizedBox(height: 100.h, child: Column(
        children: [
          Row(children: [
            Text("Day"),
            Text("Day"),
            Text("Day"),
          ],),
          Row(children: [
            Text("Day"),
            Text("Day"),
            Text("Day"),
          ],),

        ]
      ),),),     
      );
  }
}
