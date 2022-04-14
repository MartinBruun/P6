import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:washee/features/booking/presentation/provider/calendar_provider.dart';

import '../../../../core/presentation/themes/colors.dart';
import '../../../../core/presentation/themes/dimens.dart';

class SaveTimeButton extends StatefulWidget {
  @override
  State<SaveTimeButton> createState() => _SaveTimeButtonState();
}

class _SaveTimeButtonState extends State<SaveTimeButton> {
  bool _isBookingTimeSlot = false;
  @override
  Widget build(BuildContext context) {
    var calendar = Provider.of<CalendarProvider>(context, listen: false);
    return Container(
      height: 84.h,
      width: 293.69.w,
      decoration: BoxDecoration(
        color: AppColors.main,
        borderRadius: BorderRadius.circular(20.w),
      ),
      child: Center(
        child: InkWell(
          onTap: () async {
            var valid = calendar.isBookedTimeValid();

            if (valid) {
              // post booking to the backend
              // clear the addedTimeSlots list
              calendar.clearTimeSlots();
              print("VALID BOOKING! Posting to the backend");
              Navigator.of(context).popUntil((route) => route.isFirst);
            } else {
              // Show dialog to the user with propriate error message
              print("INVALID BOOKING! Aborting");
            }
          },
          child: _isBookingTimeSlot
              ? CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
                )
              : Text(
                  'Book',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: textSize_32),
                ),
        ),
      ),
    );
  }
}