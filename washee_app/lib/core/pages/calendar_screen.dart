import 'package:flutter/material.dart';
import 'package:washee/core/environments/environment.dart';
import 'package:washee/core/widgets/calendarCard.dart';

class CalendarScreen extends StatelessWidget {
  static const routeName = "/calendar-screen";

  //if the 1.st is a monday dayShiftInset = 0,  weddensday dayShiftInset = 2
  final int dayShiftInset = 0;
  final int daysInMonth = 31;
  final List<int> GreenScoreData = [
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
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
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
    -1
  ];

  void handleDateSelected() {
    print(Environment().config.webApiHost);
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
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
             CalendarCard(
                date:new DateTime(2022,03,1),
                greenScoreData: GreenScoreData,
                handleDateSelected: handleDateSelected,
              ),
              CalendarCard(
                date:new DateTime(2022,04,1),
                greenScoreData: GreenScoreData,
                handleDateSelected: handleDateSelected,
              ),
              CalendarCard(
                date:new DateTime(2022,05,1),
                greenScoreData: GreenScoreData,
                handleDateSelected: handleDateSelected,
              ),
              CalendarCard(
                date:new DateTime(2022,06,10),
                greenScoreData: GreenScoreData,
                handleDateSelected: handleDateSelected,
              ),
              // CalendarCard(
              //   _dayShiftOffset: 3,
              //   _daysInMonth: 28,
              //   monthName: 'Februar',
              //   greennessdata: greennessdata,
              //   handleDateSelected: handleDateSelected,
              // ),
              // CalendarCard(
              //   _dayShiftOffset: 3,
              //   _daysInMonth: 30,
              //   monthName: 'Marts',
              //   greennessdata: greennessdata,
              //   handleDateSelected: handleDateSelected,
              // ),
            
          ],
        ),
      ]),
    );
  }
}
