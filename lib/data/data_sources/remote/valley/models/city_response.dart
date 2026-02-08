import 'package:json_annotation/json_annotation.dart';

part 'city_response.g.dart';

@JsonSerializable()
class CityResponse {
  final int? id;
  final String? name;
  final String? nameEn;
  final String? createdAt;
  final String? updatedAt;

  CityResponse({
    this.id,
    this.name,
    this.nameEn,
    this.createdAt,
    this.updatedAt,
  });

  factory CityResponse.fromJson(Map<String, dynamic> json) =>
      _$CityResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CityResponseToJson(this);
}
