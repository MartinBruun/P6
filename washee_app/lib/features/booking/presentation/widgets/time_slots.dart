import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:washee/core/helpers/green_score_database.dart';
import 'package:washee/features/booking/presentation/provider/calendar_provider.dart';
import 'package:washee/features/booking/presentation/widgets/time_slot_item.dart';

import '../../data/models/booking_model.dart';

class TimeSlots extends StatefulWidget {
  final List<GreenScore> greenScoresForDay;
  final List<BookingModel>? bookings;
  final List<DateTime> slots;

  TimeSlots(
      {required this.bookings,
      required this.greenScoresForDay,
      required this.slots});

  @override
  State<TimeSlots> createState() => _TimeSlotsState();
}

class _TimeSlotsState extends State<TimeSlots> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var calendar = Provider.of<CalendarProvider>(context, listen: false);
    return ListView.builder(
      shrinkWrap: true,
      addAutomaticKeepAlives: true,
      itemBuilder: ((context, index) => Center(
              child: TimeSlotItem(
            greenScore: widget.greenScoresForDay.isEmpty
                ? -1
                : widget.greenScoresForDay[index].greenScore,
            isOutdated: calendar.isSlotOutdated(widget.slots[index]),
            isAvailable:
                calendar.isSlotAvailable(widget.bookings!, widget.slots[index]),
            time: widget.slots[index],
          ))),
      itemCount: widget.slots.length,
    );
  }
}
