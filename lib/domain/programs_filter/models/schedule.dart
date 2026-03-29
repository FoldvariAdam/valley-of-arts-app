import 'package:equatable/equatable.dart';

class Schedule extends Equatable {
  final List<DateTime> dates;
  final List<String> times;

  const Schedule({required this.dates, required this.times});

  @override
  List<Object?> get props => [dates, times];
}
