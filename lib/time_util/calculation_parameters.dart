import 'package:flutter_adhan/time_util/prayer_adjustments.dart';

import 'enum_class/calculation_method_names.dart';
import 'enum_class/high_latitude_rule.dart';
import 'enum_class/madhab.dart';
import 'night_portions.dart';

class CalculationParameters {
  var method = CalculationMethodNames.MUSLIM_WORLD_LEAGUE;

  var madhab = Madhab.SHAFI;

  var highLatitudeRule = HighLatitudeRule.MIDDLE_OF_THE_NIGHT;

  var adjustments = PrayerAdjustments(0, 0, 0, 0, 0, 0);

  PrayerAdjustments methodAdjustments = PrayerAdjustments(0, 0, 0, 0, 0, 0);

  double fajrAngle;

  double ishaAngle;

  int ishaInterval;

  CalculationParameters(
      {this.method,
      this.madhab = Madhab.SHAFI,
      this.highLatitudeRule = HighLatitudeRule.MIDDLE_OF_THE_NIGHT,
      this.methodAdjustments,
      this.fajrAngle,
      this.ishaAngle,
      this.ishaInterval = 0});

  CalculationParameters withMethodAdjustments(PrayerAdjustments adjustments) {
    this.methodAdjustments = adjustments;
    return this;
  }

  NightPortions nightPortions() {
    switch (highLatitudeRule) {
      case HighLatitudeRule.MIDDLE_OF_THE_NIGHT:
        // TODO: Handle this case.
        return NightPortions(1.0 / 2.0, 1.0 / 2.0);
        break;
      case HighLatitudeRule.SEVENTH_OF_THE_NIGHT:
        // TODO: Handle this case.
        return new NightPortions(1.0 / 7.0, 1.0 / 7.0);
        break;
      case HighLatitudeRule.TWILIGHT_ANGLE:
        // TODO: Handle this case.
        return NightPortions(this.fajrAngle / 60.0, this.ishaAngle / 60.0);
        break;
    }
  }
}
