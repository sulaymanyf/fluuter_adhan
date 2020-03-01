class PrayerAdjustments {
  /**
   * Fajr offset in minutes
   */
  int fajr;

  /**
   * Sunrise offset in minutes
   */
  int sunrise;

  /**
   * Dhuhr offset in minutes
   */
  int dhuhr;

  /**
   * Asr offset in minutes
   */
  int asr;

  /**
   * Maghrib offset in minutes
   */
  int maghrib;

  /**
   * Isha offset in minutes
   */
  int isha;

  PrayerAdjustments(
      this.fajr, this.sunrise, this.dhuhr, this.asr, this.maghrib, this.isha);

  PrayerAdjustments.noAsg();
}
