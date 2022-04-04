import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DayCard extends StatelessWidget {
  final int monthNumber;
  final String dayName;
  final int dayNumber;
  final VoidCallback selectHandler;
  final int greenScore;
  final bool isToday;
  final bool isSelected; //-1 is neutral , 0 is red 10 is green
  
 
  const DayCard.specific({
    required this.selectHandler,
    required this.monthNumber,
    required this.dayNumber,
    required this.dayName,
    required this.greenScore,
    required this.isToday,
    required this.isSelected, 
  }) : super();

  factory DayCard(
      {required DateTime? date,
      required VoidCallback selectHandler,
      required int greenScore,
      required bool isSelected}) {
    int tmpMonthNumber = date != null ? date.month : 0;
    int tmpDayNumber = date != null ? date.day : 0;

    List daysNames = [
    " ",
    "mandag",
    "tirsdag",
    "onsdag",
    "torsdag",
    "fredag",
    "lørdag",
    "søndag"
  ];
    String tmpDayName = date != null ? daysNames[date.weekday] : daysNames[0];

    var now = new DateTime.now();
    var tempIsToday = date != null ? DateTime(now.year, now.month, now.day).isAtSameMomentAs(DateTime(date.year, date.month, date.day)) : false;

    return DayCard.specific(
        monthNumber:tmpMonthNumber,
        dayName: tmpDayName,
        dayNumber: tmpDayNumber,
        isToday: tempIsToday,
        selectHandler: selectHandler,
        greenScore: greenScore,
        isSelected: isSelected);
  }

  
  Color greenScoreColor({bool lighten = false}) {
    if (dayNumber == 0) {
      return lighten ? Colors.transparent : Colors.transparent;
    } else if (greenScore == -1) {
      return lighten ? Colors.white38 : Colors.blueGrey;
    } else if (greenScore > -1 && greenScore < 3) {
      return lighten ? Colors.lightBlue : Colors.red;
    } else if (greenScore >= 3 && greenScore < 5) {
      return lighten ? Colors.lightBlue : Color.fromARGB(255, 200, 218, 40);
    } else if (greenScore >= 5) {
      return lighten ? Colors.lightBlue : Colors.green;
    }
    return lighten ? Colors.white24 : Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: greenScoreColor(lighten: true),
      width: 0.13.sw,
      margin: EdgeInsets.all(0.0005.sw),
      padding: EdgeInsets.all(1),
      child: dayNumber == 0
          ? Text(" ")
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: greenScoreColor(),
              ),
              child: Padding(
                padding: const EdgeInsets.all(0.1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: isToday ? Colors.blue : Colors.transparent,
                            width: 2,
                          )),
                      child: Text(
                        isSelected ? '$dayNumber X ' : '$dayNumber',
                        style: TextStyle(fontSize: 10),
                        textAlign: TextAlign.justify,
                        softWrap: false,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                    Text(
                      dayName,
                      style: TextStyle(fontSize: 8),
                      textAlign: TextAlign.justify,
                      softWrap: false,
                      overflow: TextOverflow.visible,
                    ),
                  ],
                ),
              ),
              onPressed: selectHandler,
            ),
    );
  }
}
