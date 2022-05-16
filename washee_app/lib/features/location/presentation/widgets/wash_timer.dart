import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:washee/core/washee_box/machine_model.dart';

import '../../../../core/presentation/themes/colors.dart';
import '../../../../core/presentation/themes/dimens.dart';
import '../../../../core/presentation/themes/themes.dart';

// ignore: must_be_immutable
class WashTimer extends StatefulWidget {
  MachineModel activeMachine;
  WashTimer({required this.activeMachine});

  @override
  State<WashTimer> createState() => _WashTimerState();
}

class _WashTimerState extends State<WashTimer> with TickerProviderStateMixin {
  late AnimationController controller;
  String get countText {
    Duration count = controller.duration! * controller.value;
    return '0${count.inHours}:${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    // mocking the start and end times for now
    Duration calculatedDuration = widget.activeMachine.endTime!
        .difference(widget.activeMachine.startTime!)
        .abs();

    controller = AnimationController(vsync: this, duration: calculatedDuration);

    SchedulerBinding.instance!.addPostFrameCallback((_) {
      controller.reverse(from: controller.value == 0 ? 1.0 : controller.value);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.dialogLightGray,
        borderRadius: BorderRadius.circular(30.h),
      ),
      height: 586.h,
      width: 754.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 760.w,
            height: 100.h,
            child: Icon(
              Icons.lock_clock_outlined,
              color: Colors.white,
              size: 200.h,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Container(
                  height: 84.h,
                  width: 254.w,
                  decoration: BoxDecoration(
                    color: Colors.green[600],
                    borderRadius: BorderRadius.circular(20.h),
                  ),
                  child: Center(
                    child: AnimatedBuilder(
                      animation: controller,
                      builder: (context, child) => Text(
                        countText,
                        style: textStyle.copyWith(
                          fontSize: textSize_40,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
