import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:washee/core/helpers/date_helper.dart';
import 'package:washee/features/booking/data/models/booking_model.dart';
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
  List<BookingModel> _localBookings = [];

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      var calendar = Provider.of<CalendarProvider>(context, listen: false);
      _localBookings = calendar.getBookingsForMonth(widget.date);
      print("Local Bookings for month: ${widget.date.month} - \n" +
          _localBookings.toString());
    });
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
                    // Look up the current month in the Map and get the current date specified by the index
                    var _currentDate = data.daysInMonthMap[
                        _dateHelper.monthName(widget.date.month)]![index];

                    // Using the Months Map we retrieve the name of the weekday by using the index
                    var _dayName = data.dateHelper.getWeekDay(
                        data.daysInMonthMap[
                            _dateHelper.monthName(widget.date.month)]![index]);

                    return DayCard(
                      localBookings: _localBookings,
                      greenScore: data.getGreenScore(_currentDate,
                          data.dateHelper.getDaysInMonth(_currentDate)),
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
