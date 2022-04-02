import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:washee/core/widgets/day_card.dart';

class CalendarCard extends StatelessWidget {
  CalendarCard(
      {required this.dayShiftInset,
      required this.daysInMonth,
      required this.monthName,
      required this.greennessdata,
      required this.handleDateSelected})
      : super();

  final int dayShiftInset;
  final int daysInMonth;
  final String monthName;
  final List<int> greennessdata;
  final VoidCallback handleDateSelected;

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

  // List getCalendarDay(int calendarFieldNumber) {
  //   if (calendarFieldNumber - dayShiftInset < 0) {
  //     return ["", ""];
  //   }

  //   int date = calendarFieldNumber - dayShiftInset;
  //   var dayname = daysNames[(calendarFieldNumber % 7)];

  //   return [date, dayname];
  // }

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
          Text(monthName),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DayCard(
                date: getFieldNumberDate(0),
                dayName: daysNames[0],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(0)],
              ),
              DayCard(
                date: getFieldNumberDate(1),
                dayName: daysNames[1],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(1)],
              ),
              DayCard(
                date: getFieldNumberDate(2),
                dayName: daysNames[2],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(2)],
              ),
              DayCard(
                date: getFieldNumberDate(3),
                dayName: daysNames[3],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(3)],
              ),
              DayCard(
                date: getFieldNumberDate(4),
                dayName: daysNames[4],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(4)],
              ),
              DayCard(
                date: getFieldNumberDate(5),
                dayName: daysNames[5],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(5)],
              ),
              DayCard(
                date: getFieldNumberDate(6),
                dayName: daysNames[6],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(6)],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DayCard(
                date: getFieldNumberDate(7),
                dayName: daysNames[0],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(7)],
              ),
              DayCard(
                date: getFieldNumberDate(8),
                dayName: daysNames[1],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(8)],
              ),
              DayCard(
                date: getFieldNumberDate(9),
                dayName: daysNames[2],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(9)],
              ),
              DayCard(
                date: getFieldNumberDate(10),
                dayName: daysNames[3],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(10)],
              ),
              DayCard(
                date: getFieldNumberDate(11),
                dayName: daysNames[4],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(11)],
              ),
              DayCard(
                date: getFieldNumberDate(12),
                dayName: daysNames[5],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(12)],
              ),
              DayCard(
                date: getFieldNumberDate(13),
                dayName: daysNames[6],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(13)],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DayCard(
                date: getFieldNumberDate(14),
                dayName: daysNames[0],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(14)],
              ),
              DayCard(
                date: getFieldNumberDate(15),
                dayName: daysNames[1],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(15)],
              ),
              DayCard(
                date: getFieldNumberDate(16),
                dayName: daysNames[2],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(16)],
              ),
              DayCard(
                date: getFieldNumberDate(17),
                dayName: daysNames[3],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(17)],
              ),
              DayCard(
                date: getFieldNumberDate(18),
                dayName: daysNames[4],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(18)],
              ),
              DayCard(
                date: getFieldNumberDate(19),
                dayName: daysNames[5],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(19)],
              ),
              DayCard(
                date: getFieldNumberDate(20),
                dayName: daysNames[6],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(20)],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DayCard(
                date: getFieldNumberDate(21),
                dayName: daysNames[0],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(21)],
              ),
              DayCard(
                date: getFieldNumberDate(22),
                dayName: daysNames[1],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(22)],
              ),
              DayCard(
                date: getFieldNumberDate(23),
                dayName: daysNames[2],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(23)],
              ),
              DayCard(
                date: getFieldNumberDate(24),
                dayName: daysNames[3],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(24)],
              ),
              DayCard(
                date: getFieldNumberDate(25),
                dayName: daysNames[4],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(25)],
              ),
              DayCard(
                date: getFieldNumberDate(26),
                dayName: daysNames[5],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(26)],
              ),
              DayCard(
                date: getFieldNumberDate(27),
                dayName: daysNames[6],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(27)],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DayCard(
                date: getFieldNumberDate(28),
                dayName: daysNames[0],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(28)],
              ),
              DayCard(
                date: getFieldNumberDate(29),
                dayName: daysNames[1],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(29)],
              ),
              DayCard(
                date: getFieldNumberDate(30),
                dayName: daysNames[2],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(30)],
              ),
              DayCard(
                date: getFieldNumberDate(31),
                dayName: daysNames[3],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(31)],
              ),
              DayCard(
                date: getFieldNumberDate(32),
                dayName: daysNames[4],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(32)],
              ),
              DayCard(
                date: getFieldNumberDate(33),
                dayName: daysNames[5],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(33)],
              ),
              DayCard(
                date: getFieldNumberDate(34),
                dayName: daysNames[6],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(34)],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DayCard(
                date: getFieldNumberDate(35),
                dayName: daysNames[0],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(35)],
              ),
              DayCard(
                date: getFieldNumberDate(36),
                dayName: daysNames[1],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(36)],
              ),
              DayCard(
                date: getFieldNumberDate(37),
                dayName: daysNames[2],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(37)],
              ),
              DayCard(
                date: getFieldNumberDate(38),
                dayName: daysNames[3],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(38)],
              ),
              DayCard(
                date: getFieldNumberDate(39),
                dayName: daysNames[4],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(39)],
              ),
              DayCard(
                date: getFieldNumberDate(40),
                dayName: daysNames[5],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(40)],
              ),
              DayCard(
                date: getFieldNumberDate(41),
                dayName: daysNames[6],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(41)],
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
