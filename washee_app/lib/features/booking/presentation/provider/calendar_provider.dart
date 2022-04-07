import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:washee/core/helpers/date_helper.dart';

class CalendarProvider extends ChangeNotifier {
  bool _isLoadingDays = false;
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

  Map<String, List<DateTime>> daysInMonthMap = {};

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

  String getWeekDay(DateTime date) {
    return DateFormat('EEEE').format(date);
  }

  DateHelper _dateHelper = DateHelper();
  bool _isSelected = false;

  bool get isLoadingDays => _isLoadingDays;

  List<int> get numberOfFields => _numberOfFields;

  List<int> get greenScoreData => _greenScoreData;

  DateHelper get dateHelper => _dateHelper;

  bool get isSelected => _isSelected;

  set isLoadingDays(bool value) {
    _isLoadingDays = value;
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
}
