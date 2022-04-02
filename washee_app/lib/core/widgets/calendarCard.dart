import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:washee/core/widgets/day_card.dart';

class CalendarCard extends StatelessWidget {
  CalendarCard(
      {required this.dayShiftInset,
      required this.daysInMonth,
      required this.monthName})
      : super();

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
  int getFieldNumberDate(int fieldnumber) {
    if (fieldnumber - dayShiftInset < 0) {
      return 0;
    } else if (fieldnumber + 1 - dayShiftInset > daysInMonth) {
      return 0;
    } else {
      return fieldnumber + 1 - dayShiftInset;
    }
  }

  List getCalendarDay(int calendarFieldNumber) {
    if (calendarFieldNumber - dayShiftInset < 0) {
      return ["", ""];
    }

    int date = calendarFieldNumber - dayShiftInset;
    var dayname = daysNames[(calendarFieldNumber % 7)];

    return [date, dayname];
  }

  void _handleDateSelected() {
    print("a date was clicked");
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
          Text(monthName),
          Row(          
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              DayCard(
                date: getFieldNumberDate(0),
                dayName: daysNames[0],
                selectHandler: _handleDateSelected, greenness: 0,
              ),
              DayCard(
                date: getFieldNumberDate(1),
                dayName: daysNames[1],
                selectHandler: _handleDateSelected, greenness: -1,
              ),
              DayCard(
                date: getFieldNumberDate(2),
                dayName: daysNames[2],
                selectHandler: _handleDateSelected, greenness: 3,
              ),
              DayCard(
                date: getFieldNumberDate(3),
                dayName: daysNames[3],
                selectHandler: _handleDateSelected, greenness: 4,
              ),
              DayCard(
                date: getFieldNumberDate(4),
                dayName: daysNames[4],
                selectHandler: _handleDateSelected, greenness: 5,
              ),
              DayCard(
                date: getFieldNumberDate(5),
                dayName: daysNames[5],
                selectHandler: _handleDateSelected, greenness: 9,
              ),
              DayCard(
                date: getFieldNumberDate(6),
                dayName: daysNames[6],
                selectHandler: _handleDateSelected, greenness: 0,
              ),
              
            ],
          ),
          Row(          
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              DayCard(
                date: getFieldNumberDate(7),
                dayName: daysNames[0],
                selectHandler: _handleDateSelected, greenness: 4,
              ),
              DayCard(
                date: getFieldNumberDate(8),
                dayName: daysNames[1],
                selectHandler: _handleDateSelected, greenness: 4,
              ),
              DayCard(
                date: getFieldNumberDate(9),
                dayName: daysNames[2],
                selectHandler: _handleDateSelected, greenness: 4,
              ),
              DayCard(
                date: getFieldNumberDate(10),
                dayName: daysNames[3],
                selectHandler: _handleDateSelected, greenness: 4,
              ),
              DayCard(
                date: getFieldNumberDate(11),
                dayName: daysNames[4],
                selectHandler: _handleDateSelected, greenness: 4,
              ),
              DayCard(
                date: getFieldNumberDate(12),
                dayName: daysNames[5],
                selectHandler: _handleDateSelected, greenness: 4,
              ),
              DayCard(
                date: getFieldNumberDate(13),
                dayName: daysNames[6],
                selectHandler: _handleDateSelected, greenness: 4,
              ),
              
            ],
          ),
          Row(          
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              DayCard(
                date: getFieldNumberDate(14),
                dayName: daysNames[0],
                selectHandler: _handleDateSelected, greenness: 4,
              ),
              DayCard(
                date: getFieldNumberDate(15),
                dayName: daysNames[1],
                selectHandler: _handleDateSelected, greenness: 4,
              ),
              DayCard(
                date: getFieldNumberDate(16),
                dayName: daysNames[2],
                selectHandler: _handleDateSelected, greenness: 4,
              ),
              DayCard(
                date: getFieldNumberDate(17),
                dayName: daysNames[3],
                selectHandler: _handleDateSelected, greenness: 4,
              ),
              DayCard(
                date: getFieldNumberDate(18),
                dayName: daysNames[4],
                selectHandler: _handleDateSelected, greenness: 4,
              ),
              DayCard(
                date: getFieldNumberDate(19),
                dayName: daysNames[5],
                selectHandler: _handleDateSelected, greenness: -1,
              ),
              DayCard(
                date: getFieldNumberDate(20),
                dayName: daysNames[6],
                selectHandler: _handleDateSelected, greenness: -1,
              ),
              
            ],
          ),
          Row(          
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              DayCard(
                date: getFieldNumberDate(21),
                dayName: daysNames[0],
                selectHandler: _handleDateSelected, greenness: -1,
              ),
              DayCard(
                date: getFieldNumberDate(22),
                dayName: daysNames[1],
                selectHandler: _handleDateSelected, greenness: -1,
              ),
              DayCard(
                date: getFieldNumberDate(23),
                dayName: daysNames[2],
                selectHandler: _handleDateSelected, greenness: -1,
              ),
              DayCard(
                date: getFieldNumberDate(24),
                dayName: daysNames[3],
                selectHandler: _handleDateSelected, greenness: -1,
              ),
              DayCard(
                date: getFieldNumberDate(25),
                dayName: daysNames[4],
                selectHandler: _handleDateSelected, greenness: -1,
              ),
              DayCard(
                date: getFieldNumberDate(26),
                dayName: daysNames[5],
                selectHandler: _handleDateSelected, greenness: -1,
              ),
              DayCard(
                date: getFieldNumberDate(27),
                dayName: daysNames[6],
                selectHandler: _handleDateSelected, greenness: -1,
              ),
              
            ],
          ),
          Row(          
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              DayCard(
                date: getFieldNumberDate(28),
                dayName: daysNames[0],
                selectHandler: _handleDateSelected, greenness: -1,
              ),
              DayCard(
                date: getFieldNumberDate(29),
                dayName: daysNames[1],
                selectHandler: _handleDateSelected, greenness: -1,
              ),
              DayCard(
                date: getFieldNumberDate(30),
                dayName: daysNames[2],
                selectHandler: _handleDateSelected, greenness: -1,
              ),
              DayCard(
                date: getFieldNumberDate(31),
                dayName: daysNames[3],
                selectHandler: _handleDateSelected, greenness: -1,
              ),
              DayCard(
                date: getFieldNumberDate(32),
                dayName: daysNames[4],
                selectHandler: _handleDateSelected, greenness: -1,
              ),
              DayCard(
                date: getFieldNumberDate(33),
                dayName: daysNames[5],
                selectHandler: _handleDateSelected, greenness: -1,
              ),
              DayCard(
                date: getFieldNumberDate(34),
                dayName: daysNames[6],
                selectHandler: _handleDateSelected, greenness: -1,
              ),
              
            ],
          ),
          Row(          
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              DayCard(
                date: getFieldNumberDate(35),
                dayName: daysNames[0],
                selectHandler: _handleDateSelected, greenness: -1,
              ),
              DayCard(
                date: getFieldNumberDate(36),
                dayName: daysNames[1],
                selectHandler: _handleDateSelected, greenness: -1,
              ),
              DayCard(
                date: getFieldNumberDate(37),
                dayName: daysNames[2],
                selectHandler: _handleDateSelected, greenness: -1,
              ),
              DayCard(
                date: getFieldNumberDate(38),
                dayName: daysNames[3],
                selectHandler: _handleDateSelected, greenness: -1,
              ),
              DayCard(
                date: getFieldNumberDate(39),
                dayName: daysNames[4],
                selectHandler: _handleDateSelected, greenness: -1,
              ),
              DayCard(
                date: getFieldNumberDate(40),
                dayName: daysNames[5],
                selectHandler: _handleDateSelected, greenness: -1,
              ),
              DayCard(
                date: getFieldNumberDate(41),
                dayName: daysNames[6],
                selectHandler: _handleDateSelected, greenness: -1,
              ),
              
            ],
          ),
        
        ]),
      ),
    );
  }
}
