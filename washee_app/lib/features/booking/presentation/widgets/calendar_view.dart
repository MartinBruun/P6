import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:washee/core/helpers/date_helper.dart';
import 'package:washee/features/booking/presentation/widgets/day_card.dart';

import '../../../../core/presentation/themes/dimens.dart';
import '../../../../core/presentation/themes/themes.dart';
import '../provider/calendar_provider.dart';

class CalendarView extends StatefulWidget {
  CalendarView({
    required this.date,
  }) : super();

  final DateTime date;

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateHelper _dateHelper = DateHelper();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CalendarProvider>(
      builder: (context, data, _) {
        return Padding(
          padding: EdgeInsets.only(
            top: 30.h,
          ),
          child: Column(
            children: [
              Text(
                data.dateHelper.monthName(widget.date.month),
                style: textStyle.copyWith(
                  fontSize: textSize_32,
                  color: Colors.white,
                ),
              ),
              Container(
                height: 750.h,
                child: GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  padding: EdgeInsets.only(top: 10.h),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7),
                  itemBuilder: (context, index) {
                    // Look up the current month in the Map and get the current date specified by the index
                    var _currentDate = data.daysInMonthMap[
                        _dateHelper.monthName(widget.date.month)]![index];

                    // Using the Months Map we retrieve the name of the weekday by using the index
                    var _dayName = data.dateHelper.getWeekDay(
                        data.daysInMonthMap[
                            _dateHelper.monthName(widget.date.month)]![index]);

                    return DayCard(
                      dayNumber: index + 1,
                      dayName: _dayName,
                      currentDate: _currentDate,
                    );
                  },
                  itemCount: data
                      .daysInMonthMap[_dateHelper.monthName(widget.date.month)]!
                      .length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
