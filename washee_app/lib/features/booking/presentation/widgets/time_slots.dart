import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:washee/features/booking/presentation/widgets/time_slot_item.dart';

import '../../data/models/booking_model.dart';

class TimeSlots extends StatefulWidget {
  final List<BookingModel>? bookings;
  final List<DateTime> slots;

  TimeSlots({required this.bookings, required this.slots});

  @override
  State<TimeSlots> createState() => _TimeSlotsState();
}

class _TimeSlotsState extends State<TimeSlots> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: ((context, index) => Center(
              child: TimeSlotItem(
            time: widget.slots[index],
          ))),
      itemCount: widget.slots.length,
    );
  }
}
