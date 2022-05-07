import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:washee/core/helpers/date_helper.dart';
import 'package:washee/core/helpers/green_score_database.dart';
import 'package:washee/core/helpers/web_communicator.dart';
import 'package:washee/core/washee_box/machine_model.dart';
import 'package:washee/features/booking/data/models/booking_model.dart';
import 'package:washee/core/errors/exception_handler.dart';
import '../../../../core/presentation/themes/colors.dart';
import '../../data/models/booking_model.dart';
import 'package:washee/injection_container.dart';

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
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
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
      ExceptionHandler().handle(
          "NULL IN getDaysInBetween - Month name is: ${_dateHelper.monthName(startDate.month)}",
          log: true,
          show: true,
          crash: false);
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

//TODO: should be moved to some bookings provider, we ought only to have one store for bookings
  updateBookings(List<BookingModel> bookings) {
    if (bookings.isNotEmpty) {
      _bookings.clear();
      _bookings = bookings;
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

  List<BookingModel> getBookingsForDay(DateTime date, int machineID) {
    var validBookings = _bookings.where((element) =>
        element.startTime!.day == date.day &&
        element.machineResource ==
            sl<WebCommunicator>().machinesURL + "/${machineID.toString()}/");
    if (validBookings.isNotEmpty) {
      return validBookings.toList();
    }
    return List.empty();
  }

  List<DateTime> getTimeSlots(DateTime currentDate) {
    var startTime = DateTime(2022, currentDate.month, currentDate.day, 06, 0);
    List<DateTime> _slots = [];
    _slots.add(startTime);
    for (int i = 0; i < 34; i++) {
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

  DateTime? getLeastTimeSlot() {
    if (_addedTimeSlots.isNotEmpty) {
      return _addedTimeSlots.reduce(
          (current, next) => current.compareTo(next) > 0 ? next : current);
    }
    return null;
  }

  bool isSlotAvailable(List<BookingModel> bookings, DateTime currentSlot) {
    int overlaps = 0;
    // bool alreadyChosen = false;

    for (var booking in bookings) {
      if (doesSlotOverlap(booking.startTime!, currentSlot, booking.endTime!)) {
        overlaps++;
      }
    }

    return overlaps > 0 ? false : true;
  }

  bool isSlotOutdated(DateTime currentSlot) {
    if (_isSameMonth(currentSlot) &&
        (currentSlot.day > DateHelper().currentTime().day)) {
      return false;
    } else if (_isMonthLater(currentSlot)) {
      return false;
    }

    if (currentSlot.day == DateHelper().currentTime().day) {
      if ((currentSlot.hour < DateHelper().currentTime().hour)) {
        return true;
      }
      return false;
    }
    return true;
  }

  bool _isSameMonth(DateTime currentSlot) {
    if (currentSlot.month == DateHelper().currentTime().month) {
      return true;
    }
    return false;
  }

  bool _isMonthLater(DateTime currentSlot) {
    if (currentSlot.month > DateHelper().currentTime().month) {
      return true;
    }
    return false;
  }

  int getNumberOfPossibleBookings(
      List<BookingModel> bookingsForDate, DateTime currentDate) {
    var slots = getTimeSlots(currentDate);
    var openPossibleBookings = 0;

    int slotCounter = 0;
    for (var slot in slots) {
      for (var booking in bookingsForDate) {
        if (booking.startTime!.hour == slot.hour &&
            booking.startTime!.minute == slot.minute) {
          slotCounter = -5;
          // print(booking);
        }
      }
      if (slotCounter == 6) {
        openPossibleBookings += 1;
        slotCounter = 0;
      }
      slotCounter += 1;
    }

    return openPossibleBookings;
  }

  sortAddedTimeSlots() {
    _addedTimeSlots.sort((a, b) => a.compareTo(b));
    notifyListeners();
  }

  Color determineGreenScoreColor(int greenScore) {
    switch (greenScore) {
      case -1:
        return AppColors.sportItemGray;
      case 0:
        return Colors.red;
      case 1:
        return Colors.red;
      case 2:
        return Colors.red;
      case 3:
        return Colors.orange;
      case 4:
        return Colors.orange;
      case 5:
        return Colors.orange;
      case 6:
        return Colors.green;
      case 7:
        return Colors.green;
      case 8:
        return Colors.green;
      case 9:
        return Colors.green;
      default:
        return AppColors.sportItemGray;
    }
  }

  int getGreenScoreAverage(List<BookingModel> bookings, DateTime currentDate) {
    int bestGreenScore = -1;
    bool isWithinInterval =
        currentDate.day >= 6 && currentDate.day <= 24 ? true : false;
    if (isWithinInterval) {
      bestGreenScore = _calcBestSelectableGreenScore(bookings, currentDate);
    }
    // print("Returning the avg value of: " + bestGreenScore.toString());
    return (isWithinInterval && (bestGreenScore >= 0))
        ? bestGreenScore ~/ 6
        : -1; //TODO: se her ~/betyder divider og returner en int
  }

  int _calcBestSelectableGreenScore(
      List<BookingModel> bookings, DateTime currentDate) {
    List<GreenScore> greenScoresForDay =
        GreenScoreDataBase.greenScoreDataList[currentDate.day]!;
    var timeSlots = getTimeSlots(currentDate);

    greenScoresForDay =
        updateGreenScoreWithVacancy(bookings, greenScoresForDay, currentDate);

    return calculateBestGreenScore(greenScoresForDay, timeSlots);
  }

  List<GreenScore> updateGreenScoreWithVacancy(List<BookingModel> bookings,
      List<GreenScore> greenscoresList, DateTime currentDate) {
    int greenScoreDayLength = greenscoresList.length;

    for (int index = 0; index < greenscoresList.length; index++) {
      var slot = greenscoresList[index];
      var slotDate = DateTime(currentDate.year, currentDate.month,
          currentDate.day, slot.hour, slot.minute, 0);

      for (var booking in bookings) {
        if (doesSlotOverlap(booking.startTime!, slotDate, booking.endTime!)) {
          greenscoresList[index].vacant = false;
        }
      }
    }

    return greenscoresList;
  }

  int calculateBestGreenScore(
      List<GreenScore> greenScoresForDay, List<DateTime> timeSlots) {
    int bestScore = -1;
    int sum = 0;
    int greenScoreDayLength = greenScoresForDay.length;
    for (int index = 0; index < greenScoreDayLength; index++) {
      var allowedInBestScore = true;
      if (!isSlotOutdated(timeSlots[index])) {
        //calculate 6 consecutive slots
        if (index + 5 < greenScoreDayLength) {
          for (int j in Iterable.generate(6)) {
            int subIndex = index + j;
            // If we encounter a booked slot we set the sum back to zero
            if (greenScoresForDay[subIndex].vacant == false) {
              allowedInBestScore = false;
              // print("found dis-allowed slot:" + subIndex.toString());
              sum = 0;
            } else if (allowedInBestScore) {
              sum += greenScoresForDay[subIndex].greenScore;
              // print("found allowed slot:" + subIndex.toString());
              // print("current sum:" + sum.toString());
            }
          }

          if (allowedInBestScore) {
            // print("trying to set best score if");
            // print(bestScore.toString()+"<"+sum.toString());
            if (bestScore < sum) {
              bestScore = sum;
            }
          }
          allowedInBestScore = true;
          sum = 0;
        }
      }
    }

    return bestScore;
  }
}
