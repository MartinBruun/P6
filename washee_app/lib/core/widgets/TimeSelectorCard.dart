import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimeSelectorCard extends StatefulWidget {
  const TimeSelectorCard({
    Key? key,
  }) : super(key: key);

  @override
  State<TimeSelectorCard> createState() => _TimeSelectorCardViewState();
}

class _TimeSelectorCardViewState extends State<TimeSelectorCard> {
  List<int> greenScore = [
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
    4
  ]; //TODO: denne skal med som parameter i initializeren
  List<bool> _selections = [true, false];
  DateTime fromTime = DateTime.now();
  int bookingIntervalInMinutes = 150;
  late DateTime toTime =
      fromTime.add(Duration(minutes: bookingIntervalInMinutes));

  double _currentSliderValue = DateTime.now().hour.toDouble();
  //Todo: make a better gradient calculation
  late List<Color> greenScoreDayArray = List.generate(
      12,
      (index) => Color.fromARGB(
          255, greenScore[index] * 10, greenScore[index] * 10, 2));

  @override
  Widget build(BuildContext context) {
    return Container(
        // color:Colors.white24,
        decoration:
            BoxDecoration(border: Border.all(width: 4, color: Colors.white12)),
        child: Column(
          children: [
            Center(
                child: ToggleButtons(
                    children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.water_drop,
                          semanticLabel: "Vask",
                          size: 40,
                        ),
                        Text(
                          'Vask',
                          style: timeLabelStyle,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.air,
                            semanticLabel: "Tør",
                            size: 40,
                          ),
                          Text(
                            'Tør',
                            style: timeLabelStyle,
                          ),
                        ],
                      )),
                ],
                    color: Colors.white30,
                    selectedColor: Colors.green,
                    disabledColor: Colors.red,
                    disabledBorderColor: Colors.red,
                    isSelected: _selections,
                    onPressed: (int index) {
                      setState(() {
                        _selections[0] = !_selections[0];
                        _selections[1] = !_selections[1];
                      });
                    })),
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black38,
                            Colors.black45,
                            Colors.white38,
                            Colors.black54,
                          ]),
                      border: Border.all(width: 4, color: Colors.white12)),
                  child: Column(
                    children: [
                      Center(
                        child: Row(children: [
                          Spacer(),
                          Text(
                            "fra ",
                            style: timeLabelStyle,
                          ),
                          Spacer(),
                          Text("til", style: timeLabelStyle),
                          Spacer()
                        ]),
                      ),
                      Row(children: [
                        Spacer(),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                            child: Text(
                                " ${fromTime.hour} : ${fromTime.minute}  ",
                                style: timeNumberStyle)),
                        Spacer(),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                            child: Text(" ${toTime.hour} : ${toTime.minute}  ",
                                style: timeNumberStyle)),
                        Spacer()
                      ]),
                      Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [...greenScoreDayArray]),
                            border:
                                Border.all(width: 4, color: Colors.white12)),
                        child: Slider(
                            min: 1,
                            max: 25,
                            divisions: 360, //minute on 24 hours
                            label: _currentSliderValue.ceil().toString(),
                            value: _currentSliderValue,
                            onChanged: (double value) {
                              int hour = _currentSliderValue.ceil();
                              int minute =
                                  (60 / _currentSliderValue - hour).ceil();
                              var from = DateTime(fromTime.year, fromTime.month,
                                  fromTime.day, hour, minute);
                              var to = DateTime(
                                  fromTime.year,
                                  fromTime.month,
                                  fromTime.day,
                                  hour,
                                  minute + bookingIntervalInMinutes);

                              setState(() {
                                _currentSliderValue = value;
                                fromTime = from;
                                toTime = to;
                              });
                            }),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ));
  }
}

TextStyle timeTitleStyle =
    TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold);

TextStyle timeLabelStyle = TextStyle(
  color: Colors.white,
  fontSize: 24,
);

TextStyle timeNumberStyle = TextStyle(
    color: Color.fromARGB(255, 209, 255, 59),
    backgroundColor: Colors.white30,
    fontWeight: FontWeight.bold,
    fontSize: 40,
    shadows: [Shadow(offset: Offset(1.0, 1.0), color: Colors.black)]);
