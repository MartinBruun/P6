import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:washee/core/helpers/date_helper.dart';
import 'package:washee/core/presentation/themes/colors.dart';
import 'package:washee/core/presentation/themes/dimens.dart';
import 'package:washee/core/presentation/themes/themes.dart';
import 'package:washee/features/booking/data/models/booking_model.dart';
import 'package:washee/features/booking/presentation/provider/calendar_provider.dart';
import 'package:washee/features/booking/presentation/widgets/choose_machine_view.dart';
import '../../data/models/booking_model.dart';

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

  List<BookingModel> _bookingsForCurrentDay = [];
  int _numberOfOccupiedSlots = 0;
  bool _isToday = false;
  DateHelper helper = DateHelper();

  @override
  void initState() {
    var calendar = Provider.of<CalendarProvider>(context, listen: false);
    _isToday = helper.isToday(widget.currentDate);
    _bookingsForCurrentDay = calendar.getBookingsForDay(widget.currentDate);
    _numberOfOccupiedSlots = calendar.getNumberOfOccupiedSlots(
        _bookingsForCurrentDay, widget.currentDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      width: 0.13.sw,
      margin: EdgeInsets.all(0.0005.sw),
      padding: EdgeInsets.all(1.w),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: greenScoreColor(),
        ),
        child: Consumer<CalendarProvider>(
          builder: (context, data, _) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Center(
                  child: Text(
                    _numberOfOccupiedSlots == 0 ? 'Ledig' : "",
                    style: textStyle.copyWith(
                        fontSize: textSize_14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.justify,
                    softWrap: false,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ),
              Container(
                width: 50.h,
                height: 50.h,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _isToday ? Colors.blue : Colors.transparent),
                child: Center(
                  child: Text(
                    '${widget.dayNumber.toString()}',
                    style: textStyle.copyWith(
                        fontSize: textSize_25,
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
                  fontSize: textSize_18,
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
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return ChooseMachineView(
                bookingsForDay: _bookingsForCurrentDay,
                currentDate: widget.currentDate,
              );
            },
          );
        },
      ),
    );
  }
}
