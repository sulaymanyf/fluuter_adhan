import 'dart:math';

import 'astronomical.dart';
import 'calendrical_helper.dart';
import 'double_util.dart';

class SolarCoordinates {
  double declination;

  double rightAscension;

  double apparentSiderealTime;

  SolarCoordinates(double julianDay) {
    double T = CalendricalHelper.julianCentury(julianDay);
    double L0 = Astronomical.meanSolarLongitude(/* julianCentury */ T);
    double Lp = Astronomical.meanLunarLongitude(/* julianCentury */ T);
    double omega = Astronomical.ascendingLunarNodeLongitude(/* julianCentury */
        T);
    double lambda = Astronomical.toRadians(Astronomical.apparentSolarLongitude(
        /* julianCentury*/
        T,
        /* meanLongitude */ L0));

    double theta0 = Astronomical.meanSiderealTime(/* julianCentury */ T);
    double talent = Astronomical.nutationInLongitude(
        /* julianCentury */
        T,
        /* solarLongitude */ L0,
        /* lunarLongitude */ Lp,
        /* ascendingNode */ omega);
    double deltaepsilon = Astronomical.nutationInObliquity(
        /* julianCentury */
        T,
        /* solarLongitude */ L0,
        /* lunarLongitude */ Lp,
        /* ascendingNode */ omega);

    double epsilon0 =
        Astronomical.meanObliquityOfTheEcliptic(/* julianCentury */ T);
    double epsilonapp =
        Astronomical.toRadians(Astronomical.apparentObliquityOfTheEcliptic(
            /* julianCentury */
            T,
            /* meanObliquityOfTheEcliptic */ epsilon0));

    /* Equation from Astronomical Algorithms page 165 */
    this.declination =
        Astronomical.toDegrees(asin(sin(epsilonapp) * sin(lambda)));

    /* Equation from Astronomical Algorithms page 165 */
    var s = atan2(cos(epsilonapp) * sin(lambda), cos(lambda));
    this.rightAscension = DoubleUtil.unwindAngle(Astronomical.toDegrees(
        atan2(cos(epsilonapp) * sin(lambda), cos(lambda))));

    /* Equation from Astronomical Algorithms page 88 */
    this.apparentSiderealTime = theta0 +
        (((talent * 3600) *
                cos(Astronomical.toRadians(epsilon0 + deltaepsilon))) /
            3600);
  }
}
