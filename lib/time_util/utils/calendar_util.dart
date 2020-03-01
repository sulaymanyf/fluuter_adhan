import '../data/date_components.dart';
import '../enum_class/Calendar.dart';

class CalendarUtil {
  static bool isLeapYear(int year) {
    return year % 4 == 0 && !(year % 100 == 0 && year % 400 != 0);
  }

  static DateTime roundedMinute(DateTime when) {
    int minute = when.minute;
    int second = when.second;
    var date = DateTime(when.year, when.month, when.day, when.hour,
        minute + (second / 60).round(), 0);
    return date;
  }

  static DateTime resolveTime(DateComponents components) {
    return resolveTime3(components.year, components.month, components.day);
  }

  static DateTime resolveTime3(int year, int month, int day) {
    var date = new DateTime(year, month, day, 08, 0, 0);

    return date;
  }

  static DateTime add(DateTime when, int amount, Calendar calendar) {
    var today = new DateTime(
        when.year, when.month, when.day, when.hour, when.minute, when.second);

    switch (calendar) {
      case Calendar.YEAR:
        // TODO: Handle this case.
        return new DateTime(when.year + amount, when.month, when.day, when.hour,
            when.minute, when.second);
        break;
      case Calendar.MONTH:
        // TODO: Handle this case.
        return new DateTime(when.year, when.month + amount, when.day, when.hour,
            when.minute, when.second);
        break;
      case Calendar.DAY_OF_MONTH:
        // TODO: Handle this case.
        return today.add(new Duration(days: amount));
        break;

      case Calendar.HOUR:
        return today.add(new Duration(hours: amount));
        break;
      case Calendar.MINUTE:
        return today.add(new Duration(minutes: amount));
        break;
      case Calendar.SECOND:
        return today.add(new Duration(seconds: amount));
        break;
    }
  }
}
