import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:washee/features/booking/presentation/provider/calendar_provider.dart';

import '../../../../core/presentation/themes/colors.dart';
import '../../../../core/presentation/themes/dimens.dart';
import '../../../../core/presentation/themes/themes.dart';

class TimeSlotItem extends StatefulWidget {
  final DateTime time;

  TimeSlotItem({required this.time});

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

  bool _available = true;
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
                  _formatHoursAndMinutes(widget.time),
                  style: textStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: textSize_32,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () async {
                if (_selected == false) {
                  // Adds the timeslot to the user provider
                  calendar.addTimeSlot(widget.time);
                  print("Added: " + widget.time.toString());
                } else {
                  // Removes the timeslot from the user
                  calendar.removeTimeSlot(widget.time);
                  print("Removed: " + widget.time.toString());
                }
                setState(() {
                  _selected = !_selected;
                });
              },
              icon: Icon(
                _selected ? Icons.check_box : Icons.check_box_outline_blank,
                color: _selected ? AppColors.activeTrackGreen : Colors.white,
                size: iconSize_44,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
