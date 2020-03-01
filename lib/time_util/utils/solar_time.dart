import 'dart:math';

import 'package:flutter_adhan/time_util/utils/solar_coordinates.dart';

import '../coordinates.dart';
import 'astronomical.dart';
import 'calendrical_helper.dart';

class SolarTime {
  double transit;
  double sunrise;
  double sunset;
  Coordinates observer;
  SolarCoordinates solar;
  SolarCoordinates prevSolar;
  SolarCoordinates nextSolar;
  double approximateTransit;

  SolarTime(DateTime today, Coordinates coordinates) {
    var tomorrow = new DateTime(today.year, today.month, today.day + 1).toUtc();
    var yesterday =
        new DateTime(today.year, today.month, today.day - 1).toUtc();

    this.prevSolar =
        new SolarCoordinates(CalendricalHelper.julianDay(yesterday));
    this.solar = new SolarCoordinates(CalendricalHelper.julianDay(today));
    this.nextSolar =
        new SolarCoordinates(CalendricalHelper.julianDay(tomorrow));

    this.approximateTransit = Astronomical.approximateTransit(
        coordinates.longitude,
        solar.apparentSiderealTime,
        solar.rightAscension);
    final double solarAltitude = -50.0 / 60.0;

    this.observer = coordinates;
    this.transit = Astronomical.correctedTransit(
        this.approximateTransit,
        coordinates.longitude,
        solar.apparentSiderealTime,
        solar.rightAscension,
        prevSolar.rightAscension,
        nextSolar.rightAscension);
    this.sunrise = Astronomical.correctedHourAngle(
        this.approximateTransit,
        solarAltitude,
        coordinates,
        false,
        solar.apparentSiderealTime,
        solar.rightAscension,
        prevSolar.rightAscension,
        nextSolar.rightAscension,
        solar.declination,
        prevSolar.declination,
        nextSolar.declination);
    this.sunset = Astronomical.correctedHourAngle(
        this.approximateTransit,
        solarAltitude,
        coordinates,
        true,
        solar.apparentSiderealTime,
        solar.rightAscension,
        prevSolar.rightAscension,
        nextSolar.rightAscension,
        solar.declination,
        prevSolar.declination,
        nextSolar.declination);
  }

  double hourAngle(double angle, bool afterTransit) {
    return Astronomical.correctedHourAngle(
        this.approximateTransit,
        angle,
        this.observer,
        afterTransit,
        this.solar.apparentSiderealTime,
        this.solar.rightAscension,
        this.prevSolar.rightAscension,
        this.nextSolar.rightAscension,
        this.solar.declination,
        this.prevSolar.declination,
        this.nextSolar.declination);
  }

  // hours from transit
  double afternoon(double shadowLength) {
    // TODO (from Swift version) source shadow angle calculation
    final double tangent = (observer.latitude - solar.declination).abs();
    var s = tan(Astronomical.toRadians(tangent));
    final double inverse = shadowLength + tan(Astronomical.toRadians(tangent));
    final double angle = Astronomical.toDegrees(atan(1.0 / inverse));

    return hourAngle(angle, true);
  }
}
