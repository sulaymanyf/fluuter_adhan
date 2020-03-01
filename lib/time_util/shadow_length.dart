import 'enum_class/madhab.dart';

class ShadowLength {
  static final double SINGLE = 1.0;
  static final double DOUBLE = 2.0;
  double _shadowLength;

  ShadowLength(double shadowLength) {
    this._shadowLength = shadowLength;
  }

  double getShadowLength() {
    return this._shadowLength;
  }

  double get shadowLength => _shadowLength;

  set shadowLength(double value) {
    _shadowLength = value;
  }

  static double getShadowLength4(Madhab madhab) {
    switch (madhab) {
      case Madhab.SHAFI:
        // TODO: Handle this case.
        return ShadowLength.SINGLE;
        break;
      case Madhab.HANAFI:
        // TODO: Handle this case.
        return ShadowLength.DOUBLE;
        break;
    }
  }
}
