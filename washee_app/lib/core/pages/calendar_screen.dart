import 'package:flutter/material.dart';
import 'package:washee/core/widgets/calendarCard.dart';

class CalendarScreen extends StatelessWidget {
  static const routeName = "/calendar-screen";

  //if the 1.st is a monday dayShiftInset = 0,  weddensday dayShiftInset = 2
  int dayShiftInset = 0;
  int daysInMonth = 31;
  int dayModolus = 7;
  List daysNames = [
    "mandag",
    "tirsdag",
    "onsdag",
    "torsdag",
    "fredag",
    "lørdag",
    "søndag"
  ];

  int fields = 6 * 7;//6uger med 7 dage
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
    // var mediaHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.orange,
      body: ListView(padding: EdgeInsets.all(16), children: [
        Column(
          children: [
            Text("Booking kalender",style:TextStyle(fontSize:28,), textAlign: TextAlign.center,),
Container(child:
            CalendarCard(dayShiftInset: 0, daysInMonth: 31, monthName: 'Januar',),),
          ],
        ),
      ]),
    );
  }
}
