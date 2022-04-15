import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:washee/core/helpers/machine_enum.dart';
import 'package:washee/core/presentation/themes/dimens.dart';
import 'package:washee/core/presentation/themes/themes.dart';
import 'package:washee/core/widgets/dialog_exit.dart';
import 'package:washee/features/booking/presentation/widgets/machine_type_button.dart';

import '../../../../core/presentation/themes/colors.dart';
import '../../data/models/booking_model.dart';

class ChooseMachineView extends StatefulWidget {
  final List<BookingModel> bookingsForDay;
  final DateTime currentDate;

  ChooseMachineView({required this.bookingsForDay, required this.currentDate});
  @override
  State<ChooseMachineView> createState() => _ChooseMachineViewState();
}

class _ChooseMachineViewState extends State<ChooseMachineView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
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
              height: 300.h,
              width: 900.w,
              child: Column(
                children: [
                  Center(
                      child: Text(
                    "Vælg hvilken maskine du vil booke",
                    style: textStyle.copyWith(fontSize: textSize_29),
                  )),
                  Padding(
                    padding: EdgeInsets.only(top: 49.h, bottom: 40.h),
                    child: Container(
                      width: 623.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MachineTypeButton(
                            machineType: MachineType.WashingMachine,
                            bookingsForDay: widget.bookingsForDay,
                            currentDate: widget.currentDate,
                          ),
                          MachineTypeButton(
                            machineType: MachineType.Dryer,
                            bookingsForDay: widget.bookingsForDay,
                            currentDate: widget.currentDate,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          DialogExitCross()
        ],
      ),
    );
  }
}
