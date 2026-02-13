import 'package:intl/intl.dart';

extension DateTimeFormatting on DateTime {
  String toFullDateTimeString() {
    final monthDay = DateFormat('MM.dd').format(this);
    final weekday = DateFormat('EEEE', 'hu_HU').format(this);
    final hourMinute = DateFormat('HH:mm').format(this);

    return '$monthDay $weekday $hourMinute';
  }
}

extension ShortMonthFormatting on DateTime {
  String toShortMonthString() {
    return DateFormat('MMM dd', 'hu_HU').format(this);
  }
}

extension BackendDateQueryX on DateTime {
  String toBackendDateQuery() {
    final y = year.toString().padLeft(4, '0');
    final m = month.toString().padLeft(2, '0');
    final d = day.toString().padLeft(2, '0');

    return '$y-$m-$d';
  }
}


