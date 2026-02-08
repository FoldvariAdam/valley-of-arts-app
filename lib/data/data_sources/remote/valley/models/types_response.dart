import 'package:json_annotation/json_annotation.dart';

part 'types_response.g.dart';

@JsonSerializable()
class TypesResponse {
  final int? id;
  final String? name;
  final String? nameEn;
  final String? color;
  final String? createdAt;
  final String? updatedAt;

  const TypesResponse({
    this.id,
    this.name,
    this.nameEn,
    this.color,
    this.createdAt,
    this.updatedAt,
  });

  factory TypesResponse.fromJson(Map<String, dynamic> json) =>
      _$TypesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TypesResponseToJson(this);
}
