import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:washee/features/booking/presentation/widgets/save_time_button.dart';
import 'package:washee/features/booking/presentation/widgets/time_slots.dart';

import '../../../../core/presentation/themes/colors.dart';
import '../../../../core/widgets/cancel_button.dart';

class ChooseTimeView extends StatefulWidget {
  ChooseTimeView({Key? key}) : super(key: key);

  @override
  State<ChooseTimeView> createState() => _ChooseTimeViewState();
}

class _ChooseTimeViewState extends State<ChooseTimeView> {
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
              height: 737.h,
              width: 754.w,
              child: Column(
                children: [
                  TimeSlots(),
                  Padding(
                    padding: EdgeInsets.only(top: 49.h),
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
