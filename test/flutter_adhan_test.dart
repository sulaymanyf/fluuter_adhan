import 'package:flutter_adhan/flutter_adhan.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('adds one to input values', () {
    final calculator = PrayerTimeUtil();
    expect(calculator.addOne(2), 3);
    expect(calculator.addOne(-7), -6);
    expect(calculator.addOne(0), 1);
    expect(() => calculator.addOne(null), throwsNoSuchMethodError);
    var prayerTime = PrayerTimeUtil.getPrayerTime(24.46, 118.1, 'HANAFI', 1);
    print(prayerTime.toString());
  });
}

// PrayerTimeUtil prayerTimeUtil = PrayerTimeUtil();
//    print(prayerTimeUtil.getPrayerTime(24.46, 118.1,'HANAFI',1).toString());
