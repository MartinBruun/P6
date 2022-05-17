import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

class DateHelper {
  static final DateHelper _singleton = DateHelper._internal();

  factory DateHelper() {
    return _singleton;
  }

  DateHelper._internal();

  DateTime currentTime() {
    var danishTime = tz.getLocation('Europe/Copenhagen');
    var now = tz.TZDateTime.now(danishTime);
    return now;
  }

  String convertToNonNaiveTime(DateTime time) {
    // The backend is timezone sensitive, and needs it in the following specified format
    var danishTime = tz.getLocation('Europe/Copenhagen');
    var now = tz.TZDateTime.from(time, danishTime);
    return now.toUtc().toString();
  }

  tz.Location getLocation(String location) {
    return tz.getLocation(location);
  }

  DateTime from(DateTime other, tz.Location location) {
    return tz.TZDateTime.from(other, location);
  }


  int _daysInMonth(DateTime date) {
    var lastDayOfMonth = DateTime(date.year, date.month + 1, 0);
    return lastDayOfMonth.day;
  }

  int getDaysInMonth(DateTime date) {
    return _daysInMonth(date);
  }

  DateTime firstDateInMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  DateTime getLastDateInMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0);
  }

  bool isToday(DateTime aDate) {
    DateTime now = DateHelper().currentTime();
    return DateTime(now.year, now.month, now.day)
        .isAtSameMomentAs(DateTime(aDate.year, aDate.month, aDate.day));
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

  String getDayName(int weekday) {
    String dayName = " ";
    switch (weekday) {
      case 0:
        dayName = "Mandag";
        break;
      case 1:
        dayName = "Tirsdag";
        break;
      case 2:
        dayName = "Onsdag";
        break;
      case 3:
        dayName = "Torsdag";
        break;
      case 4:
        dayName = "Fredag";
        break;
      case 5:
        dayName = "Lørdag";
        break;
      case 6:
        dayName = "Søndag";
        break;
      default:
        dayName = "fejl";
    }
    return dayName;
  }

  String translateDayName(String englishName) {
    String danishName = " ";
    switch (englishName) {
      case "Monday":
        danishName = "Mandag";
        break;
      case "Tuesday":
        danishName = "Tirsdag";
        break;
      case "Wednesday":
        danishName = "Onsdag";
        break;
      case "Thursday":
        danishName = "Torsdag";
        break;
      case "Friday":
        danishName = "Fredag";
        break;
      case "Saturday":
        danishName = "Lørdag";
        break;
      case "Sunday":
        danishName = "Søndag";
        break;
      default:
        danishName = "fejl";
    }
    return danishName;
  }

  DateTime? getFieldNumberDate(int fieldnumber, DateTime date) {
    var offset = _dayShiftOffset(date);
    var daysInMonth = getDaysInMonth(date);

    if (fieldnumber - offset < 0) {
      return null;
    } else if (fieldnumber + 1 - offset > daysInMonth) {
      return null;
    } else {
      return DateTime(date.year, date.month, fieldnumber + 1 - offset);
    }
  }

  int _dayShiftOffset(DateTime date) {
    int offset = 0;
    DateTime firstDate = firstDateInMonth(date);
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

  String getWeekDay(DateTime date) {
    return DateFormat('EEEE').format(date);
  }
}
