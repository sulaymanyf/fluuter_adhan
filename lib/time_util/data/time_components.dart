class TimeComponents {
  int hours;
  int minutes;
  int seconds;

  static TimeComponents fromDouble(double value) {
    if (value.isInfinite || value.isNaN) {
      return null;
    }
    final int hours = value.floor();
    final int minutes = ((value - hours) * 60.0).floor();
    final int seconds = ((value - (hours + minutes / 60.0)) * 60 * 60).floor();
    return new TimeComponents(hours, minutes, seconds);
  }

  TimeComponents(int hours, int minutes, int seconds) {
    this.hours = hours;
    this.minutes = minutes;
    this.seconds = seconds;
  }

  DateTime dateComponents(DateTime dateTime) {
    var date = new DateTime(dateTime.year, dateTime.month, dateTime.day,
        dateTime.hour, this.minutes, this.seconds);
    var ss = date.add(new Duration(hours: hours));

    return date.add(new Duration(hours: hours));
  }
}
