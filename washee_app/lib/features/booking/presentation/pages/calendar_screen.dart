import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:washee/core/presentation/themes/dimens.dart';
import 'package:washee/features/booking/presentation/provider/calendar_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/presentation/themes/colors.dart';
import '../../../../core/presentation/themes/themes.dart';
import '../widgets/calendar_view.dart';

class CalendarScreen extends StatefulWidget {
  static const routeName = "/calendar-screen";

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final List<DateTime> months = [
    new DateTime(2022, 04, 1),
    new DateTime(2022, 05, 1),
    new DateTime(2022, 06, 1)
  ];

  bool _isLoadingDays = false;

  @override
  void initState() {
    // Load up the Map with months and their respective number of days before we
    // show the calendar views to the user
    super.initState();
    var calendar = Provider.of<CalendarProvider>(context, listen: false);
    setState(() {
      _isLoadingDays = true;
    });
    for (var month in months) {
      calendar.getDaysInBetween(month);
    }

    Future.delayed(Duration(seconds: 3)).then((value) {
      setState(() {
        _isLoadingDays = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.middleGray,
        title: Text(
          "Booking Kalender",
          style: textStyle.copyWith(
            fontSize: textSize_40,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
      ),
      body: _isLoadingDays
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.h),
                    child: Text(
                      "Loader Kalenderen, et øjeblik...",
                      style: textStyle.copyWith(
                        fontSize: textSize_22,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ],
              ),
            )
          : ListView(
              children: [
                CalendarView(
                  date: months[0],
                ),
                CalendarView(
                  date: months[1],
                ),
                CalendarView(
                  date: months[2],
                ),
              ],
            ),
    );
  }
}
