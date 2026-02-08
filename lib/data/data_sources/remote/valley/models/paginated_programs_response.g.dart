// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_programs_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedProgramsResponse _$PaginatedProgramsResponseFromJson(
  Map<String, dynamic> json,
) => PaginatedProgramsResponse(
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => ProgramResponse.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PaginatedProgramsResponseToJson(
  PaginatedProgramsResponse instance,
) => <String, dynamic>{'data': instance.data?.map((e) => e.toJson()).toList()};
