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

  bool isToday(int dayNumber) {
    DateTime now = new DateTime.now();
    int today = now.day;
    return today == dayNumber;
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
          Text(monthName,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white60)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DayCard(
                dayNumber: getFieldNumberDate(0),
                dayName: daysNames[0],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(0)],
                isSelected: isToday(getFieldNumberDate(0)),
                isToday: isToday(getFieldNumberDate(0)),
              ),
              DayCard(
                dayNumber: getFieldNumberDate(1),
                dayName: daysNames[1],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(1)],
                isSelected: isToday(getFieldNumberDate(1)),
                isToday: isToday(getFieldNumberDate(1)),
              ),
              DayCard(
                dayNumber: getFieldNumberDate(2),
                dayName: daysNames[2],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(2)],
                isSelected: isToday(getFieldNumberDate(2)),
                isToday: isToday(getFieldNumberDate(2)),
              ),
              DayCard(
                dayNumber: getFieldNumberDate(3),
                dayName: daysNames[3],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(3)],
                isSelected: isToday(getFieldNumberDate(3)),
                isToday: isToday(getFieldNumberDate(3)),
              ),
              DayCard(
                dayNumber: getFieldNumberDate(4),
                dayName: daysNames[4],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(4)],
                isSelected: isToday(getFieldNumberDate(4)),
                isToday: isToday(getFieldNumberDate(4)),
              ),
              DayCard(
                dayNumber: getFieldNumberDate(5),
                dayName: daysNames[5],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(5)],
                isSelected: isToday(getFieldNumberDate(5)),
                isToday: isToday(getFieldNumberDate(5)),
              ),
              DayCard(
                dayNumber: getFieldNumberDate(6),
                dayName: daysNames[6],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(6)],
                isSelected: isToday(getFieldNumberDate(6)),
                isToday: isToday(getFieldNumberDate(6)),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DayCard(
                dayNumber: getFieldNumberDate(7),
                dayName: daysNames[0],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(7)],
                isSelected: isToday(getFieldNumberDate(7)),
                isToday: isToday(getFieldNumberDate(7)),
              ),
              DayCard(
                dayNumber: getFieldNumberDate(8),
                dayName: daysNames[1],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(8)],
                isSelected: isToday(getFieldNumberDate(8)),
                isToday: isToday(getFieldNumberDate(8)),
              ),
              DayCard(
                dayNumber: getFieldNumberDate(9),
                dayName: daysNames[2],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(9)],
                isSelected: isToday(getFieldNumberDate(9)),
                isToday: isToday(getFieldNumberDate(9)),
              ),
              DayCard(
                dayNumber: getFieldNumberDate(10),
                dayName: daysNames[3],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(10)],
                isSelected: isToday(getFieldNumberDate(10)),
                isToday: isToday(getFieldNumberDate(10)),
              ),
              DayCard(
                dayNumber: getFieldNumberDate(11),
                dayName: daysNames[4],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(11)],
                isSelected: isToday(getFieldNumberDate(11)),
                isToday: isToday(getFieldNumberDate(11)),
              ),
              DayCard(
                dayNumber: getFieldNumberDate(12),
                dayName: daysNames[5],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(12)],
                isSelected: isToday(getFieldNumberDate(12)),
                isToday: isToday(getFieldNumberDate(12)),
              ),
              DayCard(
                dayNumber: getFieldNumberDate(13),
                dayName: daysNames[6],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(13)],
                isSelected: isToday(getFieldNumberDate(13)),
                isToday: isToday(getFieldNumberDate(13)),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DayCard(
                dayNumber: getFieldNumberDate(14),
                dayName: daysNames[0],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(14)],
                isSelected: isToday(getFieldNumberDate(14)),
                isToday: isToday(getFieldNumberDate(14)),
              ),
              DayCard(
                dayNumber: getFieldNumberDate(15),
                dayName: daysNames[1],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(15)],
                isSelected: isToday(getFieldNumberDate(15)),
                isToday: isToday(getFieldNumberDate(15)),
              ),
              DayCard(
                dayNumber: getFieldNumberDate(16),
                dayName: daysNames[2],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(16)],
                isSelected: isToday(getFieldNumberDate(16)),
                isToday: isToday(getFieldNumberDate(16)),
              ),
              DayCard(
                dayNumber: getFieldNumberDate(17),
                dayName: daysNames[3],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(17)],
                isSelected: isToday(getFieldNumberDate(17)),
                isToday: isToday(getFieldNumberDate(17)),
              ),
              DayCard(
                dayNumber: getFieldNumberDate(18),
                dayName: daysNames[4],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(18)],
                isSelected: isToday(getFieldNumberDate(18)),
                isToday: isToday(getFieldNumberDate(18)),
              ),
              DayCard(
                dayNumber: getFieldNumberDate(19),
                dayName: daysNames[5],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(19)],
                isSelected: isToday(getFieldNumberDate(19)),
                isToday: isToday(getFieldNumberDate(19)),
              ),
              DayCard(
                dayNumber: getFieldNumberDate(20),
                dayName: daysNames[6],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(20)],
                isSelected: isToday(getFieldNumberDate(20)),
                isToday: isToday(getFieldNumberDate(20)),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DayCard(
                dayNumber: getFieldNumberDate(21),
                dayName: daysNames[0],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(21)],
                isSelected: isToday(getFieldNumberDate(21)),
                isToday: isToday(getFieldNumberDate(21)),
              ),
              DayCard(
                dayNumber: getFieldNumberDate(22),
                dayName: daysNames[1],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(22)],
                isSelected: isToday(getFieldNumberDate(22)),
                isToday: isToday(getFieldNumberDate(22)),
              ),
              DayCard(
                dayNumber: getFieldNumberDate(23),
                dayName: daysNames[2],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(23)],
                isSelected: isToday(getFieldNumberDate(23)),
                isToday: isToday(getFieldNumberDate(23)),
              ),
              DayCard(
                dayNumber: getFieldNumberDate(24),
                dayName: daysNames[3],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(24)],
                isSelected: isToday(getFieldNumberDate(24)),
                isToday: isToday(getFieldNumberDate(24)),
              ),
              DayCard(
                dayNumber: getFieldNumberDate(25),
                dayName: daysNames[4],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(25)],
                isSelected: isToday(getFieldNumberDate(25)),
                isToday: isToday(getFieldNumberDate(25)),
              ),
              DayCard(
                dayNumber: getFieldNumberDate(26),
                dayName: daysNames[5],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(26)],
                isSelected: isToday(getFieldNumberDate(26)),
                isToday: isToday(getFieldNumberDate(26)),
              ),
              DayCard(
                dayNumber: getFieldNumberDate(27),
                dayName: daysNames[6],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(27)],
                isSelected: isToday(getFieldNumberDate(27)),
                isToday: isToday(getFieldNumberDate(27)),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DayCard(
                dayNumber: getFieldNumberDate(28),
                dayName: daysNames[0],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(28)],
                isSelected: isToday(getFieldNumberDate(28)),
                isToday: isToday(getFieldNumberDate(28)),
              ),
              DayCard(
                dayNumber: getFieldNumberDate(29),
                dayName: daysNames[1],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(29)],
                isSelected: isToday(getFieldNumberDate(29)),
                isToday: isToday(getFieldNumberDate(29)),
              ),
              DayCard(
                dayNumber: getFieldNumberDate(30),
                dayName: daysNames[2],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(30)],
                isSelected: isToday(getFieldNumberDate(30)),
                isToday: isToday(getFieldNumberDate(30)),
              ),
              DayCard(
                dayNumber: getFieldNumberDate(31),
                dayName: daysNames[3],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(31)],
                isSelected: isToday(getFieldNumberDate(31)),
                isToday: isToday(getFieldNumberDate(31)),
              ),
              DayCard(
                dayNumber: getFieldNumberDate(32),
                dayName: daysNames[4],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(32)],
                isSelected: isToday(getFieldNumberDate(32)),
                isToday: isToday(getFieldNumberDate(32)),
              ),
              DayCard(
                dayNumber: getFieldNumberDate(33),
                dayName: daysNames[5],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(33)],
                isSelected: isToday(getFieldNumberDate(33)),
                isToday: isToday(getFieldNumberDate(33)),
              ),
              DayCard(
                dayNumber: getFieldNumberDate(34),
                dayName: daysNames[6],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(34)],
                isSelected: isToday(getFieldNumberDate(34)),
                isToday: isToday(getFieldNumberDate(34)),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DayCard(
                dayNumber: getFieldNumberDate(35),
                dayName: daysNames[0],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(35)],
                isSelected: isToday(getFieldNumberDate(35)),
                isToday: isToday(getFieldNumberDate(35)),
              ),
              DayCard(
                dayNumber: getFieldNumberDate(36),
                dayName: daysNames[1],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(36)],
                isSelected: isToday(getFieldNumberDate(36)),
                isToday: isToday(getFieldNumberDate(36)),
              ),
              DayCard(
                dayNumber: getFieldNumberDate(37),
                dayName: daysNames[2],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(37)],
                isSelected: isToday(getFieldNumberDate(37)),
                isToday: isToday(getFieldNumberDate(37)),
              ),
              DayCard(
                dayNumber: getFieldNumberDate(38),
                dayName: daysNames[3],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(38)],
                isSelected: isToday(getFieldNumberDate(38)),
                isToday: isToday(getFieldNumberDate(38)),
              ),
              DayCard(
                dayNumber: getFieldNumberDate(39),
                dayName: daysNames[4],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(39)],
                isSelected: isToday(getFieldNumberDate(39)),
                isToday: isToday(getFieldNumberDate(39)),
              ),
              DayCard(
                dayNumber: getFieldNumberDate(40),
                dayName: daysNames[5],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(40)],
                isSelected: isToday(getFieldNumberDate(40)),
                isToday: isToday(getFieldNumberDate(40)),
              ),
              DayCard(
                dayNumber: getFieldNumberDate(41),
                dayName: daysNames[6],
                selectHandler: handleDateSelected,
                greenness: greennessdata[getFieldNumberDate(41)],
                isSelected: isToday(getFieldNumberDate(41)),
                isToday: isToday(getFieldNumberDate(41)),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
