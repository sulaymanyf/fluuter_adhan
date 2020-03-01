library flutter_adhan;

import 'package:flutter_adhan/time_util/calculation_method.dart';
import 'package:flutter_adhan/time_util/calculation_parameters.dart';
import 'package:flutter_adhan/time_util/coordinates.dart';
import 'package:flutter_adhan/time_util/data/date_components.dart';
import 'package:flutter_adhan/time_util/enum_class/calculation_method_names.dart';
import 'package:flutter_adhan/time_util/enum_class/madhab.dart';
import 'package:flutter_adhan/time_util/paryer_times.dart';

/// A Calculator.
class PrayerTimeUtil {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;

  static PrayerTimes getPrayerTime(lat, lon, String madhab, methodNum) {
    final Coordinates coordinates = new Coordinates(lat, lon);
    var time = DateTime.now();
    final DateComponents dateComponents =
        DateComponents(time.year, time.month, time.day);
    final CalculationParameters parameters =
        CalculationMethod.getCalculationMethodParams(
            getCalculationMethod(methodNum));
    if (madhab == 'HANAFI') {
      parameters.madhab = Madhab.HANAFI;
    } else if (madhab == 'SHAFI') {
      parameters.madhab = Madhab.SHAFI;
    }
    return PrayerTimes(coordinates, dateComponents, parameters);
  }

  static getCalculationMethod(methodNum) {
    switch (methodNum) {
      case 1:
        return CalculationMethodNames.MUSLIM_WORLD_LEAGUE;
        break;
      case 2:
        return CalculationMethodNames.EGYPTIAN;
        break;
      case 3:
        return CalculationMethodNames.KARACHI;
        break;
      case 4:
        return CalculationMethodNames.UMM_AL_QURA;
        break;
      case 5:
        return CalculationMethodNames.DUBAI;
        break;
      case 6:
        return CalculationMethodNames.NORTH_AMERICA;
        break;
      case 7:
        return CalculationMethodNames.KUWAIT;
        break;
      case 8:
        return CalculationMethodNames.QATAR;
        break;
      case 9:
        return CalculationMethodNames.SINGAPORE;
        break;
      case 10:
        return CalculationMethodNames.TEHRAN;
        break;
      case 11:
        return CalculationMethodNames.JAFARI;
        break;
    }
  }
}

//library flutter_adhan;
//

//
///// A Calculator.
//class PrayerTimeUtil {
//  /// Returns [value] plus 1.
//
//  static PrayerTimes getPrayerTime(lat, lon, String madhab, methodNum) {
//    final Coordinates coordinates = new Coordinates(lat, lon);
//    var time = DateTime.now();
//    final DateComponents dateComponents =
//        DateComponents(time.year, time.month, time.day);
//    final CalculationParameters parameters =
//        CalculationMethod.getCalculationMethodParams(getCalculationMethod(methodNum));
//    if (madhab == 'HANAFI') {
//      parameters.madhab = Madhab.HANAFI;
//    } else if (madhab == 'SHAFI') {
//      parameters.madhab = Madhab.SHAFI;
//    }
//    return PrayerTimes(coordinates, dateComponents, parameters);
//  }
//  //MUSLIM_WORLD_LEAGUE,
//  //  EGYPTIAN,
//  //  KARACHI,
//  //  UMM_AL_QURA,
//  //  DUBAI,
//  //  MOON_SIGHTING_COMMITTEE,
//  //  NORTH_AMERICA,
//  //  KUWAIT,
//  //  QATAR,
//  //  SINGAPORE,
//  //  TEHRAN,
//  //  JAFARI
//
//}
