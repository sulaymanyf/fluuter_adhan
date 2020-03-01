import 'dart:math';

import '../coordinates.dart';
import 'astronomical.dart';
import 'double_util.dart';

class QiblaUtil {
  static final Coordinates MAKKAH = new Coordinates(21.4225241, 39.8261818);

  static double calculateQiblaDirection(Coordinates coordinates) {
    // Equation from "Spherical Trigonometry For the use of colleges and schools" page 50
    final double longitudeDelta = Astronomical.toRadians(MAKKAH.longitude) -
        Astronomical.toRadians(coordinates.longitude);
    final double latitudeRadians = Astronomical.toRadians(coordinates.latitude);
    final double term1 = sin(longitudeDelta);
    final double term2 =
        cos(latitudeRadians) * tan(Astronomical.toRadians(MAKKAH.latitude));
    final double term3 = sin(latitudeRadians) * cos(longitudeDelta);

    final double angle = atan2(term1, term2 - term3);
    return DoubleUtil.unwindAngle(Astronomical.toDegrees(angle));
  }
}
