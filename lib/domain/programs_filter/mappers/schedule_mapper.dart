import 'package:valley_of_arts/data/data.dart';
import 'package:valley_of_arts/domain/programs_filter/models/models.dart';

extension ScheduleResponseMapper on ScheduleResponse {
  Schedule toDomainModel() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final parsedDates = dates.map(DateTime.parse).where((date) {
      final normalized = DateTime(date.year, date.month, date.day);
      return !normalized.isBefore(today);
    }).toList()..sort();

    return Schedule(dates: parsedDates, times: times);
  }
}
