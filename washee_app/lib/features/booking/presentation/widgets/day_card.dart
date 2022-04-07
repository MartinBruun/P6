import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:washee/core/helpers/date_helper.dart';

class DayCard extends StatefulWidget {
  final int greenScore;
  final DateTime date;
  final String dayName;

  DayCard({
    required this.greenScore,
    required this.date,
    required this.dayName,
  });

  @override
  State<DayCard> createState() => _DayCardState();
}

class _DayCardState extends State<DayCard> {
  Color greenScoreColor({bool lighten = false}) {
    if (widget.date.day == 0) {
      return lighten ? Colors.transparent : Colors.transparent;
    } else if (widget.greenScore == -1) {
      return lighten ? Colors.white38 : Colors.blueGrey;
    } else if (widget.greenScore > -1 && widget.greenScore < 3) {
      return lighten ? Colors.lightBlue : Colors.red;
    } else if (widget.greenScore >= 3 && widget.greenScore < 5) {
      return lighten ? Colors.lightBlue : Color.fromARGB(255, 200, 218, 40);
    } else if (widget.greenScore >= 5) {
      return lighten ? Colors.lightBlue : Colors.green;
    }
    return lighten ? Colors.white24 : Colors.black;
  }

  bool _isToday = false;
  DateHelper helper = DateHelper();

  @override
  void initState() {
    super.initState();
    _isToday = helper.isToday(widget.date);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      width: 0.13.sw,
      margin: EdgeInsets.all(0.0005.sw),
      padding: EdgeInsets.all(1),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.green,
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
                      color: _isToday ? Colors.blue : Colors.transparent,
                      width: 2,
                    )),
                child: Text(
                  '${widget.date.day}',
                  // isSelected ? '${widget.date.day} X ' : '${widget.date.day}',
                  style: TextStyle(fontSize: 10),
                  textAlign: TextAlign.justify,
                  softWrap: false,
                  overflow: TextOverflow.visible,
                ),
              ),
              Text(
                widget.dayName,
                style: TextStyle(fontSize: 8),
                textAlign: TextAlign.justify,
                softWrap: false,
                overflow: TextOverflow.visible,
              ),
            ],
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}
