import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimeSelectorCard extends StatefulWidget {
  const TimeSelectorCard({Key? key}) : super(key: key);

  @override
  State<TimeSelectorCard> createState() => _TimeSelectorCardViewState();
}

class _TimeSelectorCardViewState extends State<TimeSelectorCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color:Colors.white24,
      decoration: BoxDecoration(border:Border.all(width:4,color:Colors.white12)),
        child: Column(
      children: [
        Center(child: Text(
              "Vask ",
              style: timeTitleStyle,
            )),
        Center(
          child: Row(children: [
            Spacer(),
            Text(
              "fra ",
              style: timeLabelStyle,
            ),
            Spacer(),
            Text("til",style: timeLabelStyle),
            Spacer()
          ]),
        ),
        Container(
          decoration: BoxDecoration(border:Border.all(width:4,color:Colors.white12)),
          child: Row(children: [
            Spacer(),
            Text("12:35", style:timeNumberStyle),
            Spacer(),
            Text("14:35", style:timeNumberStyle),
            Spacer()
          ]),
        )
      ],
    ));
  }
}

TextStyle timeTitleStyle = TextStyle(
  color: Colors.white,
  fontSize: 30,
  fontWeight: FontWeight.bold
  
);

TextStyle timeLabelStyle = TextStyle(
  color: Colors.white,
  fontSize: 24,
);

TextStyle timeNumberStyle = TextStyle(
  color: Colors.yellow,
  backgroundColor: Colors.white30,
  fontWeight: FontWeight.bold,
  fontSize: 24,
);
