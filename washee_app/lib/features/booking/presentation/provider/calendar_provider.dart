import 'package:flutter/material.dart';
import 'package:washee/core/helpers/date_helper.dart';
import 'package:washee/features/booking/data/models/booking_model.dart';

class CalendarProvider extends ChangeNotifier {
  bool _isLoadingDays = false;
  bool _didFetchBookings = false;
  bool _isFetchingBookings = false;
  final List<int> _numberOfFields = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31
  ];

  final List<int> _greenScoreData = [
    -1,
    -1,
    -1,
    -1,
    -1,
    1,
    -1,
    10,
    -1,
    -1,
    -1,
    -1,
    -1,
    2,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
  ];

  List<BookingModel> _bookings = [];

  List<BookingModel> get bookings => _bookings;

  Map<String, List<DateTime>> daysInMonthMap = {};

  // Fills up the daysInMonthMap with the respective number of dates for the given month
  getDaysInBetween(DateTime startDate) {
    var endDate = DateTime(startDate.year, startDate.month + 1, 0);

    daysInMonthMap[_dateHelper.monthName(startDate.month)] = [];

    if (daysInMonthMap[_dateHelper.monthName(startDate.month)] != null) {
      for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
        daysInMonthMap['${_dateHelper.monthName(startDate.month)}']!
            .add(startDate.add(Duration(days: i)));
      }
    } else {
      print(
          "NULL!!! - Month name is: ${_dateHelper.monthName(startDate.month)}");
    }
  }

  DateHelper _dateHelper = DateHelper();
  bool _isSelected = false;

  bool get isLoadingDays => _isLoadingDays;

  bool get didFetchBookings => _didFetchBookings;

  bool get isFetchingBookings => _isFetchingBookings;

  List<int> get numberOfFields => _numberOfFields;

  List<int> get greenScoreData => _greenScoreData;

  DateHelper get dateHelper => _dateHelper;

  bool get isSelected => _isSelected;

  set isLoadingDays(bool value) {
    _isLoadingDays = value;
    notifyListeners();
  }

  set didFetchBookings(bool value) {
    _didFetchBookings = value;
    notifyListeners();
  }

  set isFetchingBookings(bool value) {
    _isFetchingBookings = value;
    notifyListeners();
  }

  set isSelected(bool value) {
    _isSelected = value;
    notifyListeners();
  }

  // int getGreenScore(int field, DateTime date) {
  //   DateTime tempFieldDate = _dateHelper.getFieldNumberDate(field, date);
  //   return tempFieldDate == null ? -1 : greenScoreData[tempFieldDate.day - 1];
  // }

  int getGreenScore(DateTime date, int daysInCurrentMonth) {
    if (date.day <= daysInCurrentMonth) {
      return greenScoreData[date.day - 1];
    } else {
      return 0;
    }
  }

  updateBookings(List<BookingModel> bookings) {
    if (bookings.isNotEmpty) {
      for (var booking in bookings) {
        _bookings.add(booking);
      }
    }
  }

  List<BookingModel> getBookingsForMonth(DateTime date) {
    var _bookingsForMonth =
        _bookings.where((element) => element.start_time.month == date.month);
    if (_bookingsForMonth.isNotEmpty) {
      return _bookingsForMonth.toList();
    }
    return List.empty();
  }
}
