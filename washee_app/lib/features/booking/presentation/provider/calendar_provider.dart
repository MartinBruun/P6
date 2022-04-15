import 'package:flutter/material.dart';
import 'package:washee/core/helpers/date_helper.dart';
import 'package:washee/features/booking/data/models/booking_model.dart';

import '../../data/models/booking_model.dart';

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

  List<DateTime> _addedTimeSlots = [];

  List<BookingModel> get bookings => _bookings;

  List<DateTime> get addedTimeSlots => _addedTimeSlots;

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
    if (_bookings.isNotEmpty) {
      var _bookingsForMonth =
          _bookings.where((element) => element.startTime!.month == date.month);
      if (_bookingsForMonth.isNotEmpty) {
        return _bookingsForMonth.toList();
      }
      return List.empty();
    }
    return List.empty();
  }

  bool dateIncludesBooking(DateTime date) {
    var validBookings = _bookings.where((element) =>
        (element.startTime!.day == date.day) &&
        (element.startTime!.month == date.month) &&
        (element.startTime!.year == date.year));
    print("Valid bookings for day: ${date.day} \n" +
        validBookings.toList().toString());
    if (validBookings.isNotEmpty) {
      return true;
    }
    return false;
  }

  List<BookingModel> getBookingsForDay(DateTime date) {
    var validBookings =
        _bookings.where((element) => element.startTime!.day == date.day);
    if (validBookings.isNotEmpty) {
      return validBookings.toList();
    }
    return List.empty();
  }

  List<DateTime> getTimeSlots(DateTime currentDate) {
    var startTime = DateTime(2022, currentDate.month, currentDate.day, 0, 0);
    List<DateTime> _slots = [];
    _slots.add(startTime);
    for (int i = 1; i <= 47; i++) {
      startTime = startTime.add(Duration(minutes: 30));
      _slots.add(startTime);
    }
    return _slots;
  }

  addTimeSlot(DateTime time) {
    _addedTimeSlots.add(time);
    notifyListeners();
  }

  removeTimeSlot(DateTime time) {
    _addedTimeSlots.removeWhere((element) =>
        (element.day == time.day) &&
        (element.hour == time.hour) &&
        (element.minute == time.minute));
    notifyListeners();
  }

  clearTimeSlots() {
    _addedTimeSlots.clear();
    notifyListeners();
  }

  bool doesSlotOverlap(
      DateTime startDate1, DateTime currentSlot, DateTime endDate1) {
    // if ((startDate1.isBefore(currentSlot) ||
    //         startDate1.isAtSameMomentAs(currentSlot)) &&
    //     (endDate1.isAfter(currentSlot) ||
    //         endDate1.isAtSameMomentAs(currentSlot))) {
    if ((startDate1.hour <= currentSlot.hour) &&
        (endDate1.hour >= currentSlot.hour)) {
      return true;
    } else {
      return false;
    }
  }

  bool isBookedTimeValid() {
    bool _durationAccepted = false;
    bool _consecutiveSlots = false;
    Duration _duration = _getAccumulatedTimes(_addedTimeSlots);

    if (_duration == Duration(hours: 2, minutes: 30)) {
      _durationAccepted = true;
    }

    if (!_durationAccepted) {
      return false;
    }

    _consecutiveSlots = _checkConsecutiveness(_addedTimeSlots);

    if (!_consecutiveSlots) {
      return false;
    }

    return true;
  }

  Duration _getAccumulatedTimes(List<DateTime> slots) {
    return Duration(minutes: slots.last.difference(slots.first).inMinutes);
  }

  bool _checkConsecutiveness(List<DateTime> slots) {
    bool _consecutivenessPreserved = false;
    for (int i = 0; i < slots.length; i++) {
      if (i == slots.length - 1) {
        break;
      } else {
        var duration = slots[i + 1].difference(slots[i]);
        if (duration == Duration(hours: 0, minutes: 30)) {
          _consecutivenessPreserved = true;
        } else {
          _consecutivenessPreserved = false;
          return false;
        }
      }
    }
    return _consecutivenessPreserved;
  }
}
