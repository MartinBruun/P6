import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:washee/features/booking/presentation/provider/calendar_provider.dart';
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
  bool isSlotAvailable(List<BookingModel> bookings, DateTime currentSlot) {
    var calendar = Provider.of<CalendarProvider>(context, listen: false);
    int overlaps = 0;
    bool alreadyChosen = false;

    for (var booking in bookings) {
      if (calendar.doesSlotOverlap(
          booking.startTime!, currentSlot, booking.endTime!)) {
        overlaps++;
      }
    }

    for (var timeslot in calendar.addedTimeSlots) {
      if (currentSlot == timeslot) {
        alreadyChosen = true;
      }
    }

    print("Is slot: " +
        currentSlot.toString() +
        " available? " +
        alreadyChosen.toString());

    return overlaps > 0 || alreadyChosen ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: ((context, index) => Center(
              child: TimeSlotItem(
            isAvailable: isSlotAvailable(widget.bookings!, widget.slots[index]),
            time: widget.slots[index],
          ))),
      itemCount: widget.slots.length,
    );
  }
}
