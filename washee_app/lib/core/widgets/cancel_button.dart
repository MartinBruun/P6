import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:washee/features/booking/presentation/provider/calendar_provider.dart';

import '../../../../core/presentation/themes/colors.dart';
import '../../../../core/presentation/themes/dimens.dart';

class CancelButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var calendar = Provider.of<CalendarProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        calendar.clearTimeSlots();
        Navigator.of(context).pop();
      },
      child: Container(
        height: 84.h,
        width: 279.81.w,
        decoration: BoxDecoration(
          color: AppColors.dialogLightGray,
          borderRadius: BorderRadius.circular(20.w),
          border: Border.all(
            color: Colors.white,
            width: 1.w,
          ),
        ),
        child: Center(
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: textSize_32,
            ),
          ),
        ),
      ),
    );
  }
}
