import 'package:flutter/material.dart';
import 'package:washee/core/widgets/calendarCard.dart';

class CalendarScreen extends StatelessWidget {
  static const routeName = "/calendar-screen";

  //if the 1.st is a monday dayShiftInset = 0,  weddensday dayShiftInset = 2
  final int dayShiftInset = 0;
  final int daysInMonth = 31;
  final List<int> greennessdata = [
    -1,
    -1,
    -1,
    -1,
    -1,
    0,
    -1,
    10,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1
  ];

  void handleDateSelected() {
    print("a date was clicked");
  }

  @override
  Widget build(BuildContext context) {
    // var mediaHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      // backgroundColor: Colors.orange,
      body: ListView(padding: EdgeInsets.all(16), children: [
        Column(
          children: [
            Text(""),
            Text(
              "Booking kalender",
              style: TextStyle(
                fontSize: 28,
              ),
              textAlign: TextAlign.center,
            ),
            Container(
              child: CalendarCard(
                dayShiftInset: dayShiftInset,
                daysInMonth: daysInMonth,
                monthName: 'Januar',
                greennessdata: greennessdata,
                handleDateSelected: handleDateSelected,
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
