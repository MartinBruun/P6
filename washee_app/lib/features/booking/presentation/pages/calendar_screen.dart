import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:washee/core/externalities/web/web_connector.dart';
import 'package:washee/core/standards/time/date_helper.dart';
import 'package:washee/core/ui/themes/dimens.dart';
import 'package:washee/features/booking/presentation/providers/calendar_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:washee/injection_container.dart';
import 'package:washee/core/ui/themes/colors.dart';
import 'package:washee/core/ui/themes/themes.dart';
import 'package:washee/features/booking/data/models/booking_model.dart';
import 'package:washee/features/booking/presentation/widgets/calendar_view.dart';

class CalendarScreen extends StatefulWidget {
  static const routeName = "/calendar-screen";

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final List<DateTime> months = [
    new DateTime(
        DateHelper().currentTime().year, DateHelper().currentTime().month, 1),
    new DateTime(DateHelper().currentTime().year,
        DateHelper().currentTime().month + 1, 1),
    new DateTime(DateHelper().currentTime().year,
        DateHelper().currentTime().month + 2, 1)
  ];

  bool _isLoadingDaysAndBookings = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      _isLoadingDaysAndBookings = true;
    });
    _getBookings()
        .then((dynamic) => _setUpCalendar())
        .then((dynamic) => setState(() {
              _isLoadingDaysAndBookings = false;
            }));
  }

  _setUpCalendar() {
    var calendar = Provider.of<CalendarProvider>(context, listen: false);
    for (var month in months) {
      calendar.getDaysInBetween(month);
    }
  }

  _getBookings() async {
    var calendar = Provider.of<CalendarProvider>(context, listen: false);
    // var global = Provider.of<GlobalProvider>(context, listen: false);
  

    Response response = await sl<WebConnector>().retrieve("/api/1/bookings", queryParameters: {});
    // var jsonBookings = global.getMockBookings();
    var parsedBookings = constructBookingList(response.data);
    calendar.updateBookings(parsedBookings);
  }

  List<BookingModel> constructBookingList(
      List<Map<String, dynamic>> bookingsAsJson) {
    List<BookingModel> _bookings = [];
    for (var booking in bookingsAsJson) {
      _bookings.add(BookingModel.fromJson(booking));
    }

    return _bookings;
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
      body: _isLoadingDaysAndBookings
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
