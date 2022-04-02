import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DayCard extends StatelessWidget {
  final String dayName;
  final int dayNumber;
  final VoidCallback selectHandler;
  final int greenness;
  final bool isToday;
  final bool isSelected; //-1 is neutral , 0 is red 10 is green

  const DayCard({
    required this.selectHandler,
    required this.dayNumber,
    required this.dayName,
    required this.greenness,
    required this.isToday,
    required this.isSelected,
  }) : super();

  Color greennessColor({bool lighten = false}) {
    if (dayNumber == 0) {
      return lighten ? Colors.transparent : Colors.transparent;
    } else if (greenness == -1) {
      return lighten ? Colors.white38 : Colors.blueGrey;
    } else if (greenness > -1 && greenness < 3) {
      return lighten ? Colors.lightBlue : Colors.red;
    } else if (greenness >= 3 && greenness < 5) {
      return lighten ? Colors.lightBlue : Color.fromARGB(255, 200, 218, 40);
    } else if (greenness >= 5) {
      return lighten ? Colors.lightBlue : Colors.green;
    }
    return lighten ? Colors.white24 : Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: greennessColor(lighten: true),
      width: 0.13.sw,
      margin: EdgeInsets.all(0.0005.sw),
      padding: EdgeInsets.all(1),
      child: dayNumber == 0
          ? Text(" ")
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: greennessColor(),
              ),
              child: Padding(
                padding: const EdgeInsets.all(0.1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [ 
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border:Border.all(color:isToday ? Colors.red : Colors.transparent,width:2,)
                      ),
                      child: 
                      Text(
                        isSelected ? '$dayNumber X ': '$dayNumber',
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
