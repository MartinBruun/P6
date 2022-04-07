import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:washee/core/helpers/date_helper.dart';
import 'package:washee/core/presentation/themes/colors.dart';
import 'package:washee/core/presentation/themes/dimens.dart';
import 'package:washee/core/presentation/themes/themes.dart';

class DayCard extends StatefulWidget {
  final int greenScore;
  final int dayNumber;
  final String dayName;
  final DateTime currentDate;

  DayCard({
    required this.greenScore,
    required this.dayNumber,
    required this.dayName,
    required this.currentDate,
  });

  @override
  State<DayCard> createState() => _DayCardState();
}

class _DayCardState extends State<DayCard> {
  Color greenScoreColor({bool lighten = false}) {
    if (widget.greenScore == 0) {
      return lighten ? Colors.transparent : Colors.transparent;
    } else if (widget.greenScore == -1) {
      return lighten ? Colors.white38 : AppColors.borderMiddleGray;
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
    _isToday = helper.isToday(widget.currentDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      width: 0.13.sw,
      margin: EdgeInsets.all(0.0005.sw),
      padding: EdgeInsets.all(1),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          // primary: AppColors.borderMiddleGray,
          primary: greenScoreColor(),
        ),
        child: Padding(
          padding: const EdgeInsets.all(0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50.h,
                height: 50.h,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _isToday ? Colors.blue : Colors.transparent),
                child: Center(
                  child: Text(
                    '${widget.dayNumber.toString()}',
                    // isSelected ? '${widget.date.day} X ' : '${widget.date.day}',
                    style: textStyle.copyWith(
                        fontSize: textSize_20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.justify,
                    softWrap: false,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ),
              Text(
                helper.translateDayName(widget.dayName),
                style: textStyle.copyWith(
                  fontSize: textSize_15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                textAlign: TextAlign.justify,
                softWrap: false,
                overflow: TextOverflow.visible,
              ),
            ],
          ),
        ),
        onPressed: () {
          showTimePicker(context: context, initialTime: TimeOfDay.now());
        },
      ),
    );
  }
}
