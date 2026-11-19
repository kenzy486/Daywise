import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

/// Locale-aware formatting. Arabic uses Eastern Arabic digits, as in the design.
class Fmt {
  static const _western = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  static const _eastern = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

  static bool _ar(BuildContext c) => Localizations.localeOf(c).languageCode == 'ar';
  static String _loc(BuildContext c) => _ar(c) ? 'ar' : 'en_US';

  /// Converts any Western digits in [s] to Eastern Arabic digits in Arabic.
  static String digits(BuildContext c, String s) {
    if (!_ar(c)) return s;
    var out = s;
    for (var i = 0; i < 10; i++) {
      out = out.replaceAll(_western[i], _eastern[i]);
    }
    return out;
  }

  /// 7 → "7", 7.5 → "7.5", 2.25 → "2.3"
  static String number(BuildContext c, num v) {
    final s = v == v.roundToDouble() ? v.round().toString() : v.toStringAsFixed(1);
    return digits(c, s);
  }

  static String _date(BuildContext c, String pattern, DateTime d) =>
      digits(c, DateFormat(pattern, _loc(c)).format(d));

  /// "THURSDAY, 22 OCTOBER" / "الخميس، ٢٢ أكتوبر"
  static String longDay(BuildContext c, DateTime d) =>
      _ar(c) ? _date(c, 'EEEE، d MMMM', d) : _date(c, 'EEEE, d MMMM', d).toUpperCase();

  /// "THURSDAY, 22 OCTOBER 2026"
  static String longDayYear(BuildContext c, DateTime d) =>
      _ar(c) ? _date(c, 'EEEE، d MMMM y', d) : _date(c, 'EEEE, d MMMM y', d).toUpperCase();

  /// "THU, 22 OCT"
  static String shortDay(BuildContext c, DateTime d) =>
      _ar(c) ? _date(c, 'EEEE، d MMMM', d) : _date(c, 'EEE, d MMM', d).toUpperCase();

  /// "21 Oct"
  static String dayMonth(BuildContext c, DateTime d) => _date(c, _ar(c) ? 'd MMMM' : 'd MMM', d);

  /// "Wed, 21 Oct"
  static String weekdayDayMonth(BuildContext c, DateTime d) =>
      _date(c, _ar(c) ? 'EEEE، d MMMM' : 'EEE, d MMM', d);

  /// "21"
  static String dayOfMonth(BuildContext c, DateTime d) => digits(c, d.day.toString());

  /// "15–21 Oct" (or "28 Sep – 4 Oct" across months)
  static String range(BuildContext c, DateTime a, DateTime b) {
    if (a.month == b.month && a.year == b.year) {
      return digits(c, '${a.day}–${DateFormat(_ar(c) ? 'd MMMM' : 'd MMM', _loc(c)).format(b)}');
    }
    return '${dayMonth(c, a)} – ${dayMonth(c, b)}';
  }

  /// "8–21 October 2026"
  static String longRange(BuildContext c, DateTime a, DateTime b) {
    if (a.month == b.month && a.year == b.year) {
      return digits(c, '${a.day}–${DateFormat('d MMMM y', _loc(c)).format(b)}');
    }
    return digits(
      c,
      '${DateFormat('d MMMM', _loc(c)).format(a)} – ${DateFormat('d MMMM y', _loc(c)).format(b)}',
    );
  }
}
