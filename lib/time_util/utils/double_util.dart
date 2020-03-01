class DoubleUtil {
  static double normalizeWithBound(double value, double max) {
    var ss = ((value / max)).floor();
    var sss = max * ss;
    var s = value - sss;
    return value - (max * ((value / max)).floor());
  }

  static double unwindAngle(double value) {
    return normalizeWithBound(value, 360);
  }

  static double closestAngle(double angle) {
    if (angle >= -180 && angle <= 180) {
      return angle;
    }
    return angle - (360 * (angle / 360).round());
  }
}
