import 'package:json_annotation/json_annotation.dart';
import 'package:valley_of_arts/data/data_sources/remote/valley/models/program_response.dart';

part 'paginated_programs_response.g.dart';

@JsonSerializable()
class PaginatedProgramsResponse {
  final List<ProgramResponse>? data;

  PaginatedProgramsResponse({
    this.data,
  });

  factory PaginatedProgramsResponse.fromJson(Map<String, dynamic> json) =>
      _$PaginatedProgramsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaginatedProgramsResponseToJson(this);
}