import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:washee/core/errors/booking_error_prompt.dart';
import 'package:washee/core/errors/error_handler.dart';
import 'package:washee/features/booking/presentation/provider/calendar_provider.dart';

import '../../../../core/presentation/themes/colors.dart';
import '../../../../core/presentation/themes/dimens.dart';
import '../../../../core/presentation/themes/themes.dart';

class TimeSlotItem extends StatefulWidget {
  final DateTime time;
  final bool isAvailable;

  TimeSlotItem({required this.time, required this.isAvailable});

  @override
  State<TimeSlotItem> createState() => _TimeSlotItemState();
}

class _TimeSlotItemState extends State<TimeSlotItem> {
  String _formatHoursAndMinutes(DateTime time) {
    String formatted = "";
    if (time.hour < 9) {
      formatted += "0" + time.hour.toString();
    } else {
      formatted += time.hour.toString();
    }

    if (time.minute != 30) {
      formatted += ":" + "0" + time.minute.toString();
    } else {
      formatted += ":" + time.minute.toString();
    }
    return formatted;
  }

  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    var calendar = Provider.of<CalendarProvider>(context, listen: false);
    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: Container(
        width: 770.w,
        height: 80.h,
        decoration: BoxDecoration(
          color: _selected ? AppColors.deepGreen : AppColors.sportItemGray,
          borderRadius: BorderRadius.circular(20.w),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: InkWell(
                onTap: () {},
                child: Text(
                  widget.isAvailable
                      ? _formatHoursAndMinutes(widget.time)
                      : _formatHoursAndMinutes(widget.time) + "       optaget",
                  style: textStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: textSize_32,
                    color: !widget.isAvailable ? AppColors.red : Colors.white,
                  ),
                ),
              ),
            ),
            IconButton(
                onPressed: () async {
                  if (!widget.isAvailable) {
                    ErrorHandler.errorHandlerView(
                        context: context,
                        prompt: BookingErrorPrompt(
                            message: "Tidspunktet er optaget!"));
                  } else {
                    final endTime =
                        widget.time.add(const Duration(minutes: 150));
                    if (_selected == false) {
                      calendar.clearTimeSlots();
                      calendar.addTimeSlot(widget.time);
                      calendar.addTimeSlot(widget.time.add(const Duration(
                          minutes:
                              30))); // Should be rewritten as a loop, with duration taken from the chosen services length
                      calendar.addTimeSlot(
                          widget.time.add(const Duration(minutes: 60)));
                      calendar.addTimeSlot(
                          widget.time.add(const Duration(minutes: 90)));
                      calendar.addTimeSlot(
                          widget.time.add(const Duration(minutes: 120)));
                      calendar.addTimeSlot(endTime);

                      print("Added from: " +
                          widget.time.toString() +
                          " to " +
                          endTime.toString());
                      print(calendar.addedTimeSlots.toString());
                    } else {
                      calendar.clearTimeSlots();
                      print("Removed from: " +
                          widget.time.toString() +
                          " to " +
                          endTime.toString());
                      print(calendar.addedTimeSlots.toString());
                    }
                    setState(() {
                      _selected = !_selected;
                    });
                  }
                },
                icon: widget.isAvailable
                    ? Icon(
                        _selected
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: _selected
                            ? AppColors.activeTrackGreen
                            : Colors.white,
                        size: iconSize_44,
                      )
                    : Icon(
                        Icons.not_interested_outlined,
                        color: AppColors.red,
                      )),
          ],
        ),
      ),
    );
  }
}
