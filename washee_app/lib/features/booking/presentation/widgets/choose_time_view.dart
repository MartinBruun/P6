import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:washee/features/booking/data/models/booking_model.dart';
import 'package:washee/features/booking/presentation/provider/calendar_provider.dart';
import 'package:washee/features/booking/presentation/widgets/save_time_button.dart';
import 'package:washee/features/booking/presentation/widgets/time_slots.dart';

import '../../../../core/presentation/themes/colors.dart';
import '../../../../core/widgets/cancel_button.dart';

class ChooseTimeView extends StatefulWidget {
  final List<BookingModel>? bookingsForDate;

  ChooseTimeView({required this.bookingsForDate});

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

    Future.delayed(Duration(seconds: 2)).then((value) {
      var calendar = Provider.of<CalendarProvider>(context, listen: false);
      _slots = calendar.getTimeSlots();
      setState(() {
        _loadingTimeSlots = false;
      });
    });
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
                  Container(
                    height: 1120.h,
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
                          SaveTimeButton(),
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
