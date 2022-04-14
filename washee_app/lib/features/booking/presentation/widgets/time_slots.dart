import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimeSlots extends StatefulWidget {
  TimeSlots({Key? key}) : super(key: key);

  @override
  State<TimeSlots> createState() => _TimeSlotsState();
}

class _TimeSlotsState extends State<TimeSlots> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: ((context, index) => Container()));
  }
}
