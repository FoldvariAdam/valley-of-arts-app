// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleResponse _$ScheduleResponseFromJson(Map<String, dynamic> json) =>
    ScheduleResponse(
      dates: (json['dates'] as List<dynamic>).map((e) => e as String).toList(),
      times: (json['times'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ScheduleResponseToJson(ScheduleResponse instance) =>
    <String, dynamic>{'dates': instance.dates, 'times': instance.times};
