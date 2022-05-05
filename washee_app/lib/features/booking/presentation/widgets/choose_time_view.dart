import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:washee/core/helpers/green_score_database.dart';
import 'package:washee/core/helpers/machine_enum.dart';
import 'package:washee/core/presentation/themes/dimens.dart';
import 'package:washee/core/presentation/themes/themes.dart';
import 'package:washee/features/booking/data/models/booking_model.dart';
import 'package:washee/features/booking/presentation/provider/calendar_provider.dart';
import 'package:washee/features/booking/presentation/widgets/save_time_button.dart';
import 'package:washee/features/booking/presentation/widgets/time_slots.dart';

import '../../../../core/presentation/themes/colors.dart';
import '../../../../core/widgets/cancel_button.dart';

class ChooseTimeView extends StatefulWidget {
  final List<BookingModel>? bookingsForDate;
  final DateTime currentDate;
  final int machineType;

  ChooseTimeView(
      {required this.bookingsForDate,
      required this.currentDate,
      required this.machineType});

  @override
  State<ChooseTimeView> createState() => _ChooseTimeViewState();
}

class _ChooseTimeViewState extends State<ChooseTimeView> {
  bool _loadingTimeSlots = false;
  List<DateTime> _slots = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      _loadingTimeSlots = true;
    });

    Future.delayed(Duration()).then((value) {
      var calendar = Provider.of<CalendarProvider>(context, listen: false);
      _slots = calendar.getTimeSlots(widget.currentDate);
      setState(() {
        _loadingTimeSlots = false;
      });
    });
  }

  List<GreenScore>? _getGreenScoresForDay() {
    if (GreenScoreDataBase.greenScoreDataList[widget.currentDate.day] != null) {
      return GreenScoreDataBase.greenScoreDataList[widget.currentDate.day];
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.only(top: 54.h),
              decoration: BoxDecoration(
                color: AppColors.dialogLightGray,
                borderRadius: BorderRadius.circular(30.w),
              ),
              height: 1350.h,
              width: 900.w,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 30.h),
                    child: Text(
                      widget.machineType == MachineType.WashingMachine
                          ? "Vaskemaskine"
                          : "Tørretumbler",
                      style: textStyle.copyWith(fontSize: textSize_40),
                    ),
                  ),
                  Container(
                    height: 1000.h,
                    width: 800.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.w),
                      border: Border.all(
                        color: Colors.white,
                        width: 2.w,
                      ),
                    ),
                    child: _loadingTimeSlots
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          )
                        : TimeSlots(
                            slots: _slots,
                            bookings: widget.bookingsForDate!,
                            greenScoresForDay: _getGreenScoresForDay()!,
                          ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 49.h, bottom: 40.h),
                    child: Container(
                      width: 623.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CancelButton(),
                          SaveTimeButton(machineType: widget.machineType),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
