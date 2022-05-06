import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:washee/core/account/user.dart';
import 'package:washee/core/helpers/date_helper.dart';
import 'package:washee/core/helpers/machine_enum.dart';
import 'package:washee/core/presentation/themes/dimens.dart';
import 'package:washee/core/presentation/themes/themes.dart';
import 'package:washee/features/booking/data/models/booking_model.dart';
import 'package:washee/features/booking/presentation/provider/calendar_provider.dart';
import 'package:washee/features/booking/presentation/widgets/choose_machine_view.dart';
import 'package:washee/features/booking/presentation/widgets/outdated_date_dialog.dart';
import 'package:washee/features/unlock/presentation/widgets/insufficient_funds_dialog.dart';
import '../../data/models/booking_model.dart';

class DayCard extends StatefulWidget {
  final int dayNumber;
  final String dayName;
  final DateTime currentDate;

  DayCard({
    required this.dayNumber,
    required this.dayName,
    required this.currentDate,
  });

  @override
  State<DayCard> createState() => _DayCardState();
}

class _DayCardState extends State<DayCard> {
  List<BookingModel> _washBookingsForCurrentDay = [];
  List<BookingModel> _dryBookingsForCurrentDay = [];
  int _washNumberOfPossibleBookings = 0;
  int _dryNumberOfPossibleBookings = 0;
  bool _isToday = false;
  DateHelper helper = DateHelper();
  int _greenScoreAverage = -1;

  @override
  void initState() {
    var calendar = Provider.of<CalendarProvider>(context, listen: false);
    _isToday = helper.isToday(widget.currentDate);
    _washBookingsForCurrentDay = calendar.getBookingsForDay(
        widget.currentDate, MachineType.WashingMachine);
    _dryBookingsForCurrentDay =
        calendar.getBookingsForDay(widget.currentDate, MachineType.Dryer);
    _washNumberOfPossibleBookings = calendar.getNumberOfPossibleBookings(
        _washBookingsForCurrentDay, widget.currentDate);
    _dryNumberOfPossibleBookings = calendar.getNumberOfPossibleBookings(
        _dryBookingsForCurrentDay, widget.currentDate);

    _greenScoreAverage = widget.currentDate.month == 5
        ? calendar.getGreenScoreAverage(
            _washBookingsForCurrentDay, widget.currentDate)
        : -1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var calendar = Provider.of<CalendarProvider>(context, listen: false);
    return Container(
      color: Colors.black12,
      width: 0.13.sw,
      margin: EdgeInsets.all(0.0005.sw),
      padding: EdgeInsets.all(1.w),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: calendar.determineGreenScoreColor(_greenScoreAverage),
        ),
        child: Consumer<CalendarProvider>(
          builder: (context, data, _) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "V: " +
                    "$_washNumberOfPossibleBookings - T: $_dryNumberOfPossibleBookings",
                style: textStyle.copyWith(
                    fontSize: textSize_20,
                    fontWeight: FontWeight.bold,
                    color: _isToday ? Colors.blue : Colors.white),
                textAlign: TextAlign.justify,
                softWrap: false,
                overflow: TextOverflow.visible,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.h, top: 10.h),
                child: Center(
                  child: Text(
                    '${widget.dayNumber.toString()}',
                    style: textStyle.copyWith(
                        fontSize: textSize_28,
                        fontWeight: FontWeight.bold,
                        color: _isToday ? Colors.blue : Colors.white),
                    textAlign: TextAlign.justify,
                    softWrap: false,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ),
              Text(
                helper.translateDayName(widget.dayName),
                style: textStyle.copyWith(
                  fontSize: textSize_20,
                  fontWeight: FontWeight.w700,
                  color: _isToday ? Colors.blue : Colors.white,
                ),
                textAlign: TextAlign.justify,
                softWrap: false,
                overflow: TextOverflow.visible,
              ),
            ],
          ),
        ),
        onPressed: () async {
          ActiveUser user = ActiveUser();
          if ((widget.currentDate.month == DateHelper().currentTime().month) &&
              (widget.currentDate.day < DateHelper().currentTime().day)) {
            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return OutDatedDateDialog();
              },
            );
          } else if (user.activeAccount!.balance > 0) {
            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return ChooseMachineView(
                  washesForDay: _washBookingsForCurrentDay,
                  dryingsForDay: _dryBookingsForCurrentDay,
                  currentDate: widget.currentDate,
                );
              },
            );
          } else {
            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return InsufficentFundsDialog();
              },
            );
          }
        },
      ),
    );
  }
}
