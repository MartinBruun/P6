class DateHelper {
  DateTime? getFieldNumberDate(int fieldnumber, DateTime date) {
    var offset = _dayShiftOffset(date);
    var daysInMonth = _daysInMonth(date);

    if (fieldnumber - offset < 0) {
      return null;
    } else if (fieldnumber + 1 - offset > daysInMonth) {
      return null;
    } else {
      return DateTime(date.year, date.month, fieldnumber + 1 - offset);
    }
  }

  int _daysInMonth(DateTime date) {
    var lastDayOfMonth = DateTime(date.year, date.month + 1, 0);
    return lastDayOfMonth.day;
  }

  int getDaysInMonth(DateTime date) {
    return _daysInMonth(date);
  }

  DateTime _firstDateInMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  int _dayShiftOffset(DateTime date) {
    int offset = 0;
    DateTime firstDate = _firstDateInMonth(date);
    switch (firstDate.weekday) {
      case DateTime.monday:
        offset = 0;
        break;
      case DateTime.tuesday:
        offset = 1;
        break;
      case DateTime.wednesday:
        offset = 2;
        break;
      case DateTime.thursday:
        offset = 3;
        break;
      case DateTime.friday:
        offset = 4;
        break;
      case DateTime.saturday:
        offset = 5;
        break;
      case DateTime.sunday:
        offset = 6;
        break;
      default:
    }
    return offset;
  }

  bool isToday(DateTime aDate) {
    DateTime now = new DateTime.now();
    int today = now.day;
    return today == aDate.day;
  }

  int getGreenScore(int field, DateTime date) {
    DateTime? tempFieldDate = getFieldNumberDate(field, date);
    return tempFieldDate == null ? -1 : greenScoreData[tempFieldDate.day - 1];
  }

  String monthName(int monthNumber) {
    String monthName = " ";
    switch (monthNumber) {
      case 1:
        monthName = "Januar";
        break;
      case 2:
        monthName = "Februar";
        break;
      case 3:
        monthName = "Marts";
        break;
      case 4:
        monthName = "April";
        break;
      case 5:
        monthName = "Maj";
        break;
      case 6:
        monthName = "Juni";
        break;
      case 7:
        monthName = "Juli";
        break;
      case 8:
        monthName = "August";
        break;
      case 9:
        monthName = "September";
        break;
      case 10:
        monthName = "Oktober";
        break;
      case 11:
        monthName = "November";
        break;
      case 12:
        monthName = "December";
        break;

      default:
    }
    return monthName;
  }

  final List<int> greenScoreData = [
    -1,
    -1,
    -1,
    -1,
    -1,
    0,
    -1,
    10,
    -1,
    -1,
    -1,
    -1,
    -1,
    0,
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
    -1,
    -1,
    -1,
    -1,
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
    -1,
    -1,
    -1,
    -1,
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
    -1,
    -1,
    -1,
    -1
  ];
}
