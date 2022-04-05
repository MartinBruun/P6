import 'package:flutter/material.dart';
import 'package:washee/core/helpers/date_helper.dart';

class CalendarProvider extends ChangeNotifier {
  List<int> _numberOfFields = [
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
  DateHelper _dateHelper = DateHelper();

  List<int> get numberOfFields => _numberOfFields;

  DateHelper get dateHelper => _dateHelper;
}
