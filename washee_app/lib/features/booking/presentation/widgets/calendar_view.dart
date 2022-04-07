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
  DateHelper dateHelper = DateHelper();
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
                height: 800.h,
                child: GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  padding: EdgeInsets.only(top: 10.h),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7),
                  itemBuilder: (context, index) {
                    var _currentDate = data.daysInMonthMap[
                        dateHelper.monthName(widget.date.month)]![index];
                    var _dayName = data.getWeekDay(data.daysInMonthMap[
                        dateHelper.monthName(widget.date.month)]![index]);

                    return DayCard(
                      greenScore: data.getGreenScore(_currentDate,
                          data.dateHelper.getDaysInMonth(_currentDate)),
                      dayNumber: index + 1,
                      dayName: _dayName,
                      currentDate: _currentDate,
                    );
                  },
                  itemCount: data
                      .daysInMonthMap[dateHelper.monthName(widget.date.month)]!
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
