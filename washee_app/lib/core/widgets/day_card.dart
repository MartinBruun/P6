import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DayCard extends StatelessWidget {
  final String dayName;
  final int date;
  final VoidCallback selectHandler;
  final int greenness; //-1 is neutral , 0 is red 10 is green

  const DayCard(
      {required this.selectHandler,
      required this.date,
      required this.dayName,
      required this.greenness})
      : super();

  Color greennessColor({bool lighten = false}) {
     if (date == 0) {
      return lighten ? Colors.transparent : Colors.transparent;
    } else if (greenness == -1) {
      return lighten ? Colors.white38 : Colors.blueGrey;
    } else if (greenness > -1 && greenness < 3) {
      return lighten ? Colors.lightBlue : Colors.red;
    } else if (greenness >= 3 && greenness < 5) {
      return lighten ? Colors.lightBlue :  Color.fromARGB(255, 200, 218, 40);
    } else if (greenness >= 5) {
      return lighten ? Colors.lightBlue :  Colors.green;
    }
    return  lighten ? Colors.white24 :  Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: greennessColor(lighten:true),
      width: 0.13.sw,
      margin: EdgeInsets.all(0.0005.sw),
      padding: EdgeInsets.all(1),
      child: date == 0 ? Text(" ") : ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: greennessColor(),
        ),
        child: Padding(
          padding: const EdgeInsets.all(0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              Text(
                '$date',
                style: TextStyle(fontSize: 10),
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
