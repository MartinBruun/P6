import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:washee/core/widgets/day_card.dart';

class CalendarCard extends StatelessWidget {
  CalendarCard(
      {required this.date,
      required this.greenScoreData,
      required this.handleDateSelected})
      : super();

  final DateTime date;
  final List<int> greenScoreData;
  final VoidCallback handleDateSelected;

  //TODO:Lav en setting som bestemmer størrelsen på dette  grid
  final int fields = 6 * 7; //6uger med 7 dage

  DateTime? getFieldNumberDate(int fieldnumber) {
    var offset = _dayShiftOffset();
    var daysInMonth = _daysInMonth();

    if (fieldnumber - offset < 0) {
      return null;
    } else if (fieldnumber + 1 - offset > daysInMonth) {
      return null;
    } else {
      return DateTime(date.year, date.month, fieldnumber + 1 - offset);
    }
  }

  DateTime _firstDateInMonth() {
    return DateTime(date.year, date.month, 1);
  }

  int _dayShiftOffset() {
    int offset = 0;
    DateTime firstDate = _firstDateInMonth();
    switch (firstDate.weekday) {
      case DateTime.monday:
        offset = 0;
        break;
      case DateTime.tuesday:
        offset = 1;
        break;
      case DateTime.wednesday:
        offset = 2;
        break;
      case DateTime.thursday:
        offset = 3;
        break;
      case DateTime.friday:
        offset = 4;
        break;
      case DateTime.saturday:
        offset = 5;
        break;
      case DateTime.sunday:
        offset = 6;
        break;
      default:
    }
    return offset;
  }

  int _daysInMonth() {
    var lastDayOfMonth = DateTime(date.year, date.month + 1, 0);
    return lastDayOfMonth.day;
  }

  bool isToday(DateTime aDate) {
    DateTime now = new DateTime.now();
    int today = now.day;
    return today == aDate.day;
  }

  int getGreenScore(int field) {
    DateTime? tempFieldDate = getFieldNumberDate(field);
    return tempFieldDate == null ? -1 : greenScoreData[tempFieldDate.day - 1];
  }

  String monthName(int monthNumber) {
    String monthName = " ";
    switch (monthNumber) {
      case 1:
        monthName = "Januar"; 
        break;
      case 2:
        monthName = "Februar"; 
        break;
      case 3:
        monthName = "Marts"; 
        break;
      case 4:
        monthName = "April"; 
        break;
      case 5:
        monthName = "Maj"; 
        break;
      case 6:
        monthName = "Juni"; 
        break;
      case 7:
        monthName = "Juli"; 
        break;
      case 8:
        monthName = "August"; 
        break;
      case 9:
        monthName = "September"; 
        break;
      case 10:
        monthName = "Oktober"; 
        break;
      case 11:
        monthName = "November"; 
        break;
      case 12:
        monthName = "December"; 
        break;

      default:
      
    }
    return monthName;
  }

  @override
  Widget build(BuildContext context) {
    return
        // var mediaHeight = MediaQuery.of(context).size.height;
        Padding(
      padding: EdgeInsets.only(left: 0.w, right: 0.w, bottom: 0.h),
      child: Container(
        width: double.infinity,
        // margin: EdgeInsets.all(5.w),
        // padding: EdgeInsets.all(15),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(monthName(date.month),
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white60)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DayCard(
                  date: getFieldNumberDate(0),
                  selectHandler: handleDateSelected,
                  greenScore: getGreenScore(0),
                  isSelected: false),
              DayCard(
                date: getFieldNumberDate(1),
                selectHandler: handleDateSelected,
                greenScore: getGreenScore(1),
                isSelected: false,
              ),
              DayCard(
                date: getFieldNumberDate(2),
                selectHandler: handleDateSelected,
                greenScore: getGreenScore(2),
                isSelected: false,
              ),
              DayCard(
                date: getFieldNumberDate(3),
                selectHandler: handleDateSelected,
                greenScore: getGreenScore(3),
                isSelected: false,
              ),
              DayCard(
                date: getFieldNumberDate(4),
                selectHandler: handleDateSelected,
                greenScore: getGreenScore(4),
                isSelected: false,
              ),
              DayCard(
                date: getFieldNumberDate(5),
                selectHandler: handleDateSelected,
                greenScore: getGreenScore(5),
                isSelected: false,
              ),
              DayCard(
                date: getFieldNumberDate(6),
                selectHandler: handleDateSelected,
                greenScore: getGreenScore(6),
                isSelected: false,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DayCard(
                date: getFieldNumberDate(7),
                selectHandler: handleDateSelected,
                greenScore: getGreenScore(7),
                isSelected: false,
              ),
              DayCard(
                date: getFieldNumberDate(8),
                selectHandler: handleDateSelected,
                greenScore: getGreenScore(8),
                isSelected: false,
              ),
              DayCard(
                date: getFieldNumberDate(9),
                selectHandler: handleDateSelected,
                greenScore: getGreenScore(9),
                isSelected: false,
              ),
              DayCard(
                date: getFieldNumberDate(10),
                selectHandler: handleDateSelected,
                greenScore: getGreenScore(10),
                isSelected: false,
              ),
              DayCard(
                date: getFieldNumberDate(11),
                selectHandler: handleDateSelected,
                greenScore: getGreenScore(11),
                isSelected: false,
              ),
              DayCard(
                date: getFieldNumberDate(12),
                selectHandler: handleDateSelected,
                greenScore: getGreenScore(12),
                isSelected: false,
              ),
              DayCard(
                date: getFieldNumberDate(13),
                selectHandler: handleDateSelected,
                greenScore: getGreenScore(13),
                isSelected: false,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DayCard(
                date: getFieldNumberDate(14),
                selectHandler: handleDateSelected,
                greenScore: getGreenScore(14),
                isSelected: false,
              ),
              DayCard(
                date: getFieldNumberDate(15),
                selectHandler: handleDateSelected,
                greenScore: getGreenScore(15),
                isSelected: false,
              ),
              DayCard(
                date: getFieldNumberDate(16),
                selectHandler: handleDateSelected,
                greenScore: getGreenScore(16),
                isSelected: false,
              ),
              DayCard(
                date: getFieldNumberDate(17),
                selectHandler: handleDateSelected,
                greenScore: getGreenScore(17),
                isSelected: false,
              ),
              DayCard(
                date: getFieldNumberDate(18),
                selectHandler: handleDateSelected,
                greenScore: getGreenScore(18),
                isSelected: false,
              ),
              DayCard(
                date: getFieldNumberDate(19),
                selectHandler: handleDateSelected,
                greenScore: getGreenScore(19),
                isSelected: false,
              ),
              DayCard(
                date: getFieldNumberDate(20),
                selectHandler: handleDateSelected,
                greenScore: getGreenScore(20),
                isSelected: false,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DayCard(
                date: getFieldNumberDate(21),
                selectHandler: handleDateSelected,
                greenScore: getGreenScore(21),
                isSelected: false,
              ),
              DayCard(
                date: getFieldNumberDate(22),
                selectHandler: handleDateSelected,
                greenScore: getGreenScore(22),
                isSelected: false,
              ),
              DayCard(
                date: getFieldNumberDate(23),
                selectHandler: handleDateSelected,
                greenScore: getGreenScore(23),
                isSelected: false,
              ),
              DayCard(
                date: getFieldNumberDate(24),
                selectHandler: handleDateSelected,
                greenScore: getGreenScore(24),
                isSelected: false,
              ),
              DayCard(
                date: getFieldNumberDate(25),
                selectHandler: handleDateSelected,
                greenScore: getGreenScore(25),
                isSelected: false,
              ),
              DayCard(
                date: getFieldNumberDate(26),
                selectHandler: handleDateSelected,
                greenScore: getGreenScore(26),
                isSelected: false,
              ),
              DayCard(
                date: getFieldNumberDate(27),
                selectHandler: handleDateSelected,
                greenScore: getGreenScore(27),
                isSelected: false,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DayCard(
                date: getFieldNumberDate(28),
                selectHandler: handleDateSelected,
                greenScore: getGreenScore(28),
                isSelected: false,
              ),
              DayCard(
                date: getFieldNumberDate(29),
                selectHandler: handleDateSelected,
                greenScore: getGreenScore(29),
                isSelected: false,
              ),
              DayCard(
                date: getFieldNumberDate(30),
                selectHandler: handleDateSelected,
                greenScore: getGreenScore(30),
                isSelected: false,
              ),
              DayCard(
                date: getFieldNumberDate(31),
                selectHandler: handleDateSelected,
                greenScore: getGreenScore(31),
                isSelected: false,
              ),
              DayCard(
                date: getFieldNumberDate(32),
                selectHandler: handleDateSelected,
                greenScore: getGreenScore(32),
                isSelected: false,
              ),
              DayCard(
                date: getFieldNumberDate(33),
                selectHandler: handleDateSelected,
                greenScore: getGreenScore(33),
                isSelected: false,
              ),
              DayCard(
                date: getFieldNumberDate(34),
                selectHandler: handleDateSelected,
                greenScore: getGreenScore(34),
                isSelected: false,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DayCard(
                date: getFieldNumberDate(35),
                selectHandler: handleDateSelected,
                greenScore: getGreenScore(35),
                isSelected: false,
              ),
              DayCard(
                date: getFieldNumberDate(36),
                selectHandler: handleDateSelected,
                greenScore: getGreenScore(36),
                isSelected: false,
              ),
              DayCard(
                date: getFieldNumberDate(37),
                selectHandler: handleDateSelected,
                greenScore: getGreenScore(37),
                isSelected: false,
              ),
              DayCard(
                date: getFieldNumberDate(38),
                selectHandler: handleDateSelected,
                greenScore: getGreenScore(38),
                isSelected: false,
              ),
              DayCard(
                date: getFieldNumberDate(39),
                selectHandler: handleDateSelected,
                greenScore: getGreenScore(39),
                isSelected: false,
              ),
              DayCard(
                date: getFieldNumberDate(40),
                selectHandler: handleDateSelected,
                greenScore: getGreenScore(40),
                isSelected: false,
              ),
              DayCard(
                date: getFieldNumberDate(41),
                selectHandler: handleDateSelected,
                greenScore: getGreenScore(41),
                isSelected: false,
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
