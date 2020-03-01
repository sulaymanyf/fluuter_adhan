import 'package:flutter_adhan/time_util/shadow_length.dart';
import 'package:flutter_adhan/time_util/utils/calendar_util.dart';
import 'package:flutter_adhan/time_util/utils/solar_time.dart';

import 'calculation_parameters.dart';
import 'coordinates.dart';
import 'data/date_components.dart';
import 'data/time_components.dart';
import 'enum_class/Calendar.dart';
import 'enum_class/calculation_method_names.dart';
import 'night_portions.dart';

class PrayerTimes {
  DateTime fajr;
  DateTime sunrise;
  DateTime dhuhr;
  DateTime asr;
  DateTime maghrib;
  DateTime isha;

  Coordinates coordinates;
  DateComponents dateComponents;
  CalculationParameters calculationParameters;

  PrayerTimes(coordinates, dateComponents, calculationParameters) {
    params(coordinates, CalendarUtil.resolveTime(dateComponents),
        calculationParameters);
  }

  static DateTime seasonAdjustedMorningTwilight(
      double latitude, int day, int year, DateTime sunrise) {
    final double a = 75 + ((28.65 / 55.0) * latitude.abs());
    final double b = 75 + ((19.44 / 55.0) * latitude.abs());
    final double c = 75 + ((32.74 / 55.0) * latitude.abs());
    final double d = 75 + ((48.10 / 55.0) * latitude.abs());

    double adjustment;
    final int dyy = PrayerTimes.daysSinceSolstice(day, year, latitude);
    if (dyy < 91) {
      adjustment = a + (b - a) / 91.0 * dyy;
    } else if (dyy < 137) {
      adjustment = b + (c - b) / 46.0 * (dyy - 91);
    } else if (dyy < 183) {
      adjustment = c + (d - c) / 46.0 * (dyy - 137);
    } else if (dyy < 229) {
      adjustment = d + (c - d) / 46.0 * (dyy - 183);
    } else if (dyy < 275) {
      adjustment = c + (b - c) / 46.0 * (dyy - 229);
    } else {
      adjustment = b + (a - b) / 91.0 * (dyy - 275);
    }

    return new DateTime(sunrise.year, sunrise.month, sunrise.day, sunrise.hour,
        sunrise.minute, -(adjustment * 60.0).round());
  }

  static DateTime seasonAdjustedEveningTwilight(
      double latitude, int day, int year, DateTime sunset) {
    final double a = 75 + ((25.60 / 55.0) * latitude.abs());
    final double b = 75 + ((2.050 / 55.0) * latitude.abs());
    final double c = 75 - ((9.210 / 55.0) * latitude.abs());
    final double d = 75 + ((6.140 / 55.0) * latitude.abs());

    double adjustment;
    final int dyy = PrayerTimes.daysSinceSolstice(day, year, latitude);
    if (dyy < 91) {
      adjustment = a + (b - a) / 91.0 * dyy;
    } else if (dyy < 137) {
      adjustment = b + (c - b) / 46.0 * (dyy - 91);
    } else if (dyy < 183) {
      adjustment = c + (d - c) / 46.0 * (dyy - 137);
    } else if (dyy < 229) {
      adjustment = d + (c - d) / 46.0 * (dyy - 183);
    } else if (dyy < 275) {
      adjustment = c + (b - c) / 46.0 * (dyy - 229);
    } else {
      adjustment = b + (a - b) / 91.0 * (dyy - 275);
    }
    return new DateTime(sunset.year, sunset.month, sunset.day, sunset.hour,
        sunset.minute, (adjustment * 60.0).round());
  }

  static int daysSinceSolstice(int dayOfYear, int year, double latitude) {
    int daysSinceSolistice;
    final int northernOffset = 10;
    bool isLeapYear = CalendarUtil.isLeapYear(year);
    final int southernOffset = isLeapYear ? 173 : 172;
    final int daysInYear = isLeapYear ? 366 : 365;

    if (latitude >= 0) {
      daysSinceSolistice = dayOfYear + northernOffset;
      if (daysSinceSolistice >= daysInYear) {
        daysSinceSolistice = daysSinceSolistice - daysInYear;
      }
    } else {
      daysSinceSolistice = dayOfYear - southernOffset;
      if (daysSinceSolistice < 0) {
        daysSinceSolistice = daysSinceSolistice + daysInYear;
      }
    }
    return daysSinceSolistice;
  }

  params(Coordinates coordinates, DateTime dateTime,
      CalculationParameters parameters) {
    DateTime tempFajr = null;
    DateTime tempSunrise = null;
    DateTime tempDhuhr = null;
    DateTime tempAsr = null;
    DateTime tempMaghrib = null;
    DateTime tempIsha = null;

//    this.coordinates = coordinates;
//    this.dateComponents = DateComponents.from(dateTime);
//    this.calculationParameters = parameters;

    var date = new DateTime(dateTime.year, dateTime.month, dateTime.day,
        dateTime.hour, dateTime.minute, dateTime.second);

    final int year = date.year;
    final int dayOfYear = date.day;

    SolarTime solarTime = SolarTime(date, coordinates);

    TimeComponents timeComponents =
        TimeComponents.fromDouble(solarTime.transit);
    DateTime transit =
        timeComponents == null ? null : timeComponents.dateComponents(date);

    timeComponents = TimeComponents.fromDouble(solarTime.sunrise);
    DateTime sunriseComponents =
        timeComponents == null ? null : timeComponents.dateComponents(date);

    timeComponents = TimeComponents.fromDouble(solarTime.sunset);
    DateTime sunsetComponents =
        timeComponents == null ? null : timeComponents.dateComponents(date);

    bool error = transit == null ||
        sunriseComponents == null ||
        sunsetComponents == null;
    if (!error) {
      tempDhuhr = transit;
      tempSunrise = sunriseComponents;
      tempMaghrib = sunsetComponents;

      timeComponents = TimeComponents.fromDouble(solarTime
          .afternoon(ShadowLength.getShadowLength4(parameters.madhab)));
      if (timeComponents != null) {
        tempAsr = timeComponents.dateComponents(date);
      }

      final DateTime tomorrowSunrise = new DateTime(
          sunriseComponents.year,
          sunriseComponents.month,
          sunriseComponents.day + 1,
          sunriseComponents.hour,
          sunriseComponents.minute,
          sunriseComponents.second);

      // get night length
      int night = tomorrowSunrise.millisecondsSinceEpoch -
          sunsetComponents.millisecondsSinceEpoch;

      timeComponents = TimeComponents.fromDouble(
          solarTime.hourAngle(-parameters.fajrAngle, false));
      if (timeComponents != null) {
        tempFajr = timeComponents.dateComponents(date);
      }

      if (parameters.method == CalculationMethodNames.MOON_SIGHTING_COMMITTEE &&
          coordinates.latitude >= 55) {
        tempFajr = CalendarUtil.add(
            sunriseComponents, -1 * (night / 7000).toInt(), Calendar.SECOND);
      }

      final NightPortions nightPortions = parameters.nightPortions();

      DateTime safeFajr;
      if (parameters.method == CalculationMethodNames.MOON_SIGHTING_COMMITTEE) {
        safeFajr = seasonAdjustedMorningTwilight(
            coordinates.latitude, dayOfYear, year, sunriseComponents);
      } else {
        double portion = nightPortions.fajr;
        int nightFraction = (portion * night / 1000).toInt();
        safeFajr = new DateTime(
            sunriseComponents.year,
            sunriseComponents.month,
            sunriseComponents.day,
            sunriseComponents.hour,
            sunriseComponents.minute,
            sunriseComponents.second);
        safeFajr = safeFajr.add(new Duration(seconds: nightFraction * -1));

        if (tempFajr == null ||
            tempFajr.millisecondsSinceEpoch < safeFajr.millisecondsSinceEpoch) {
          tempFajr = safeFajr;
        }

        // Isha calculation with check against safe value

        if (parameters.ishaInterval > 0) {
          tempIsha = CalendarUtil.add(
              tempMaghrib, parameters.ishaInterval * 60, Calendar.SECOND);
        } else {
          timeComponents = TimeComponents.fromDouble(
              solarTime.hourAngle(-parameters.ishaAngle, true));
          if (timeComponents != null) {
            tempIsha = timeComponents.dateComponents(date);
          }

          if (parameters.method ==
                  CalculationMethodNames.MOON_SIGHTING_COMMITTEE &&
              coordinates.latitude >= 55) {
            int nightFraction = (night / 7000).toInt();
            tempIsha = new DateTime(
                sunsetComponents.year,
                sunsetComponents.month,
                sunsetComponents.day,
                sunsetComponents.hour,
                sunsetComponents.minute,
                sunsetComponents.second + nightFraction);
          }

          DateTime safeIsha;
          if (parameters.method ==
              CalculationMethodNames.MOON_SIGHTING_COMMITTEE) {
            safeIsha = PrayerTimes.seasonAdjustedEveningTwilight(
                coordinates.latitude, dayOfYear, year, sunsetComponents);
          } else {
            double portion = nightPortions.isha;
            int nightFraction = (portion * night / 1000).toInt();
            safeIsha = new DateTime(
                sunsetComponents.year,
                sunsetComponents.month,
                sunsetComponents.day,
                sunsetComponents.hour,
                sunsetComponents.minute,
                sunsetComponents.second);
          }
          safeIsha = safeIsha.add(new Duration(seconds: nightFraction));

          if (tempIsha == null ||
              (tempIsha.millisecondsSinceEpoch >
                  safeIsha.millisecondsSinceEpoch)) {
            tempIsha = safeIsha;
          }
        }
      }

      if (error || tempAsr == null) {
        // if we don't have all prayer times then initialization failed
        this.fajr = null;
        this.sunrise = null;
        this.dhuhr = null;
        this.asr = null;
        this.maghrib = null;
        this.isha = null;
      } else {
        // Assign final times to public struct members with all offsets
        this.fajr = CalendarUtil.roundedMinute(CalendarUtil.add(
            CalendarUtil.add(
                tempFajr, parameters.adjustments.fajr, Calendar.MINUTE),
            parameters.methodAdjustments.fajr,
            Calendar.MINUTE));
        this.sunrise = CalendarUtil.roundedMinute(CalendarUtil.add(
            CalendarUtil.add(
                tempSunrise, parameters.adjustments.sunrise, Calendar.MINUTE),
            parameters.methodAdjustments.sunrise,
            Calendar.MINUTE));
        this.dhuhr = CalendarUtil.roundedMinute(CalendarUtil.add(
            CalendarUtil.add(
                tempDhuhr, parameters.adjustments.dhuhr, Calendar.MINUTE),
            parameters.methodAdjustments.dhuhr,
            Calendar.MINUTE));
        this.asr = CalendarUtil.roundedMinute(CalendarUtil.add(
            CalendarUtil.add(
                tempAsr, parameters.adjustments.asr, Calendar.MINUTE),
            parameters.methodAdjustments.asr,
            Calendar.MINUTE));
        this.maghrib = CalendarUtil.roundedMinute(CalendarUtil.add(
            CalendarUtil.add(
                tempMaghrib, parameters.adjustments.maghrib, Calendar.MINUTE),
            parameters.methodAdjustments.maghrib,
            Calendar.MINUTE));
        this.isha = CalendarUtil.roundedMinute(CalendarUtil.add(
            CalendarUtil.add(
                tempIsha, parameters.adjustments.isha, Calendar.MINUTE),
            parameters.methodAdjustments.isha,
            Calendar.MINUTE));
      }
    }
  }

  @override
  String toString() {
    return 'PrayerTimes{fajr: $fajr, sunrise: $sunrise, dhuhr: $dhuhr, asr: $asr, maghrib: $maghrib, isha: $isha, coordinates: $coordinates, dateComponents: $dateComponents, calculationParameters: $calculationParameters}';
  }
}
