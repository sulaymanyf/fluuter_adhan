class CalendricalHelper {
  static double julianDay_year_month_day(int year, int month, int day) {
    return julianDay_y_m_d_h(year, month, day, 0.0);
  }

  static double julianDay(DateTime date) {
    var dateTime =
        new DateTime(date.year, date.month, date.day, date.minute, date.second);
    return julianDay_y_m_d_h(dateTime.year, dateTime.month, dateTime.day,
        dateTime.hour + (dateTime.minute / 60.0));
  }

  static double julianDay_y_m_d_h(int year, int month, int day, double hours) {
    /* Equation from Astronomical Algorithms page 60 */

    // NOTE: Integer conversion is done intentionally for the purpose of decimal truncation

    int Y = month > 2 ? year : year - 1;
    int M = month > 2 ? month : month + 12;
    double D = day + (hours / 24);

    int A = (Y / 100).toInt();
    int B = (2 - A + (A / 4)).toInt();

    int i0 = (365.25 * (Y + 4716)).toInt();
    int i1 = (30.6001 * (M + 1)).toInt();
    return i0 + i1 + D + B - 1524.5;
  }

  static double julianCentury(double JD) {
    /* Equation from Astronomical Algorithms page 163 */
    return (JD - 2451545.0) / 36525;
  }
}
