import 'package:flutter_adhan/time_util/prayer_adjustments.dart';

import 'calculation_parameters.dart';
import 'enum_class/calculation_method_names.dart';

class CalculationMethod {
  static CalculationParameters getCalculationMethodParams(
      CalculationMethodNames calculationMethodNames) {
    switch (calculationMethodNames) {
      case CalculationMethodNames.DUBAI:
        return CalculationParameters(
                fajrAngle: 18.2,
                ishaAngle: 18.2,
                method: calculationMethodNames)
            .withMethodAdjustments(PrayerAdjustments(0, -3, 3, 3, 3, 0));
        break;
      case CalculationMethodNames.MUSLIM_WORLD_LEAGUE:
        var calculationParameters = CalculationParameters(
                fajrAngle: 18.0,
                ishaAngle: 17.0,
                method: calculationMethodNames)
            .withMethodAdjustments(PrayerAdjustments(0, 0, 1, 0, 0, 0));

        return calculationParameters;
        break;
      case CalculationMethodNames.EGYPTIAN:
        return CalculationParameters(
                fajrAngle: 20.0,
                ishaAngle: 18.0,
                method: calculationMethodNames)
            .withMethodAdjustments(PrayerAdjustments(0, 0, 1, 0, 0, 0));
        break;
      case CalculationMethodNames.KARACHI:
        return CalculationParameters(
                fajrAngle: 18.0,
                ishaAngle: 18.0,
                method: calculationMethodNames)
            .withMethodAdjustments(PrayerAdjustments(0, 0, 1, 0, 0, 0));
        break;
      case CalculationMethodNames.UMM_AL_QURA:
        return CalculationParameters(
            fajrAngle: 18.5, ishaInterval: 90, method: calculationMethodNames);
        break;
      case CalculationMethodNames.MOON_SIGHTING_COMMITTEE:
        return CalculationParameters(
                fajrAngle: 18.0,
                ishaAngle: 18.0,
                method: calculationMethodNames)
            .withMethodAdjustments(PrayerAdjustments(0, 0, 5, 0, 3, 0));
        break;
      case CalculationMethodNames.NORTH_AMERICA:
        return CalculationParameters(
                fajrAngle: 15.0,
                ishaAngle: 15.0,
                method: calculationMethodNames)
            .withMethodAdjustments(PrayerAdjustments(0, 0, 1, 0, 0, 0));
        break;
      case CalculationMethodNames.KUWAIT:
        return CalculationParameters(
            fajrAngle: 18.0, ishaAngle: 17.5, method: calculationMethodNames);
        break;
      case CalculationMethodNames.QATAR:
        return CalculationParameters(
            fajrAngle: 18.0, ishaInterval: 90, method: calculationMethodNames);
        break;
      case CalculationMethodNames.SINGAPORE:
        // TODO: Handle this case.
        return CalculationParameters(
                fajrAngle: 20.0,
                ishaAngle: 18.0,
                method: calculationMethodNames)
            .withMethodAdjustments(PrayerAdjustments(0, 0, 1, 0, 0, 0));
        break;
      case CalculationMethodNames.TEHRAN:
        return CalculationParameters(
                fajrAngle: 17.7, ishaAngle: 14, method: calculationMethodNames)
            .withMethodAdjustments(PrayerAdjustments(0, 0, 1, 0, 0, 0));
        break;
      case CalculationMethodNames.JAFARI:
        return CalculationParameters(
                fajrAngle: 16, ishaAngle: 14, method: calculationMethodNames)
            .withMethodAdjustments(PrayerAdjustments(0, 0, 1, 0, 0, 0));
        break;
    }
  }
}
