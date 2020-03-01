class DateComponents {
  int year;
  int month;
  int day;

  DateComponents(int year, int month, int day) {
    this.year = year;
    this.month = month;
    this.day = day;
  }

  static DateComponents from(DateTime date) {
    return new DateComponents(date.year, date.month + 1, date.day);
  }
}
