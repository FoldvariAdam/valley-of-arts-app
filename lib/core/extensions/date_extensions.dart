import 'package:intl/intl.dart';

extension DateTimeFormatting on DateTime {
  String toCustomString() {
    final monthDay = DateFormat('MM.dd').format(this);
    final weekday = DateFormat('EEEE', 'hu_HU').format(this);
    final hourMinute = DateFormat('HH:mm').format(this);

    return '$monthDay $weekday $hourMinute';
  }
}
