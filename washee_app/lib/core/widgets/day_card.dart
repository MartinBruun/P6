import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class DayCard extends StatelessWidget {
  final String dayName;
  final int date;
  final Function selectHandler;

  const DayCard({required this.selectHandler, required this.date, required this.dayName}) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.pink),
        child: Column(
          children: [Text(dayName), Text('$date')],
        ),
        onPressed: null,
      ),
    );
  }
}
