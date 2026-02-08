import 'package:json_annotation/json_annotation.dart';
import 'package:valley_of_arts/data/data_sources/remote/valley/models/location_response.dart';
import 'package:valley_of_arts/data/data_sources/remote/valley/models/program_categories_response.dart';

part 'program_response.g.dart';

@JsonSerializable()
class ProgramResponse {
  final int? id;
  final String? slug;
  final String? name;
  final String? nameEn;
  final String? start;
  final String? end;
  final String? description;
  final String? descriptionEn;
  final String? longDescription;
  final String? longDescriptionEn;
  final int? locationId;
  final bool? isAllDay;
  final bool? isInvalid;
  final int? onSite;
  final int? onMobile;
  final String? createdAt;
  final String? updatedAt;
  final int? pinned;
  final bool? isChanged;
  final bool? onStage;
  final LocationResponse? location;
  final List<ProgramCategoriesResponse>? programCategories;

  ProgramResponse({
    this.id,
    this.slug,
    this.name,
    this.nameEn,
    this.start,
    this.end,
    this.description,
    this.descriptionEn,
    this.longDescription,
    this.longDescriptionEn,
    this.locationId,
    this.isAllDay,
    this.isInvalid,
    this.onSite,
    this.onMobile,
    this.createdAt,
    this.updatedAt,
    this.pinned,
    this.isChanged,
    this.onStage,
    this.location,
    this.programCategories,
  });

  factory ProgramResponse.fromJson(Map<String, dynamic> json) =>
      _$ProgramResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProgramResponseToJson(this);
}
