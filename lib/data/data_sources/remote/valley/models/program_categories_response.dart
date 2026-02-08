import 'package:json_annotation/json_annotation.dart';

part 'program_categories_response.g.dart';

@JsonSerializable()
class ProgramCategoriesResponse {
  final int? id;
  final String? name;
  final String? nameEn;
  final String? color;
  final String? createdAt;
  final String? updatedAt;
  final int? order;
  final int? isHidden;

  ProgramCategoriesResponse({
    this.id,
    this.name,
    this.nameEn,
    this.color,
    this.createdAt,
    this.updatedAt,
    this.order,
    this.isHidden,
  });

  factory ProgramCategoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$ProgramCategoriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProgramCategoriesResponseToJson(this);
}