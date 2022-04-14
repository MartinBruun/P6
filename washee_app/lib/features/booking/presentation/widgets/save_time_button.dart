import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return Container(
      height: 84.h,
      width: 293.69.w,
      decoration: BoxDecoration(
        color: AppColors.main,
        borderRadius: BorderRadius.circular(20.w),
      ),
      child: Center(
        child: InkWell(
          onTap: () async {},
          child: _isBookingTimeSlot
              ? CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
                )
              : Text(
                  'Save',
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
