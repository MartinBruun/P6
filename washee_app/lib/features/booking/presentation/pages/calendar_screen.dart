import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:provider/provider.dart';
import 'package:washee/core/presentation/themes/dimens.dart';
import 'package:washee/core/providers/global_provider.dart';
import 'package:washee/core/usecases/usecase.dart';
import 'package:washee/features/booking/domain/usecases/get_bookings.dart';
import 'package:washee/features/booking/presentation/provider/calendar_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:washee/injection_container.dart';
import '../../../../core/presentation/themes/colors.dart';
import '../../../../core/presentation/themes/themes.dart';
import '../../data/models/booking_model.dart';
import '../widgets/calendar_view.dart';

class CalendarScreen extends StatefulWidget {
  static const routeName = "/calendar-screen";

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

//TODO: IT could be great not to have to call DateTime.now so many times, but just call it in top of the constructor
class _CalendarScreenState extends State<CalendarScreen> {
  final List<DateTime> months = [
    new DateTime(DateTime.now().year, DateTime.now().month, 1),
    new DateTime(DateTime.now().year, DateTime.now().month + 1, 1),
    new DateTime(DateTime.now().year, DateTime.now().month + 2, 1)
  ];

  bool _isLoadingDaysAndBookings = false;

  @override
  void initState() {
    // Load up the Map with months and their respective number of days before we
    // show the calendar views to the user
    super.initState();

    setState(() {
      _isLoadingDaysAndBookings = true;
    });
    Future.delayed(Duration(seconds: 3)).then((value) async {
      _setUpCalendar();
      await _getBookings();
      setState(() {
        _isLoadingDaysAndBookings = false;
      });
    });
  }

  _setUpCalendar() {
    var calendar = Provider.of<CalendarProvider>(context, listen: false);
    for (var month in months) {
      calendar.getDaysInBetween(month);
    }
  }

  _getBookings() async {
    var calendar = Provider.of<CalendarProvider>(context, listen: false);
    var global = Provider.of<GlobalProvider>(context, listen: false);

    await Future.delayed(Duration(seconds: 1));
    // if (!provider.didFetchBookings) {
    //   provider.updateBookings(await sl<GetBookingsUseCase>().call(NoParams()));
    //   if (provider.bookings.isNotEmpty) {
    //     provider.didFetchBookings = true;
    //   }
    // }
    var jsonBookings = global.getMockBookings();
    var parsedBookings = constructBookingList(jsonBookings);
    calendar.updateBookings(parsedBookings);
  }

  List<BookingModel> constructBookingList(
      List<Map<String, dynamic>> bookingsAsJson) {
    List<BookingModel> _bookings = [];
    for (var booking in bookingsAsJson) {
      _bookings.add(BookingModel.fromJSON(booking));
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
