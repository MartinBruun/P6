import 'package:flutter/material.dart';
import 'package:washee/core/presentation/themes/dimens.dart';

import '../../../../core/presentation/themes/colors.dart';
import '../../../../core/presentation/themes/themes.dart';
import '../widgets/calendar_view.dart';

class CalendarScreen extends StatelessWidget {
  static const routeName = "/calendar-screen";

  //if the 1.st is a monday dayShiftInset = 0,  weddensday dayShiftInset = 2
  final int dayShiftInset = 0;
  final int daysInMonth = 31;
  final DateTime date = DateTime.now();

  // first commit
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.middleGray,
        title: Text(
          "Booking Kalender",
          style: textStyle.copyWith(
            fontSize: textSize_40,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          CalendarView(
            date: new DateTime(2022, 04, 1),
          ),
          CalendarView(
            date: new DateTime(2022, 05, 1),
          ),
          CalendarView(
            date: new DateTime(2022, 06, 1),
          ),
        ],
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
    );
  }
}
