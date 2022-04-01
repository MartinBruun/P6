import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CalendarCard extends StatelessWidget {
  CalendarCard({
    required this.dayShiftInset,
    required this.daysInMonth,
    required this.monthName
  }) : super();

  final int dayShiftInset;
  final int daysInMonth;
  final String monthName;

  final int dayModolus = 7;
  final List daysNames = [
    "mandag",
    "tirsdag",
    "onsdag",
    "torsdag",
    "fredag",
    "lørdag",
    "søndag"
  ];

  final int fields = 6 * 7; //6uger med 7 dage
  List getCalendarDay(int calendarFieldNumber) {
    if (calendarFieldNumber - dayShiftInset - 1 < 0) {
      return ["", ""];
    }

    int date = calendarFieldNumber - dayShiftInset;
    var dayname = daysNames[(calendarFieldNumber % 7)];

    return [date, dayname];
  }

  void handleDateSelected() {
    print("a date was clicked");
  }

  @override
  Widget build(BuildContext context) {
    return
        // var mediaHeight = MediaQuery.of(context).size.height;
        Padding(
      padding: EdgeInsets.only(left: 33.w, right: 33.w, bottom: 24.h),
      child:
          // ListView(padding: EdgeInsets.all(1), children: [
            Column(
              children: [
          //       Text("Booking Calendar"),
          Text(monthName),
            Row(
              children: [
                ElevatedButton(
                  child: Text("mandag dato "),
                  onPressed: handleDateSelected,
                ),
                ElevatedButton(
                  child: Text("tirsdag dato "),
                  onPressed: handleDateSelected,
                ),
                ElevatedButton(
                  child: Text("onsdag dato "),
                  onPressed: handleDateSelected,
                ),
                ElevatedButton(
                  child: Text("torsdag dato "),
                  onPressed: handleDateSelected,
                ),
                ElevatedButton(
                  child: Text("fredag dato "),
                  onPressed: handleDateSelected,
                ),
                ElevatedButton(
                  child: Text("lørdag dato "),
                  onPressed: handleDateSelected,
                ),
                ElevatedButton(
                  child: Text("søndag dato "),
                  onPressed: handleDateSelected,
                ),
              ],),
          // ],),
      ]),
    );
  }
}
