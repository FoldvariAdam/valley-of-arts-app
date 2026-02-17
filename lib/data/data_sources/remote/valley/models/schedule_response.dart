import 'package:json_annotation/json_annotation.dart';

part 'schedule_response.g.dart';

@JsonSerializable()
class ScheduleResponse {
  final List<String> dates;
  final List<String> times;

  ScheduleResponse({required this.dates, required this.times});

  factory ScheduleResponse.fromJson(Map<String, dynamic> json) =>
      _$ScheduleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleResponseToJson(this);
}
