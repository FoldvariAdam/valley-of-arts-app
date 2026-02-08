// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityResponse _$CityResponseFromJson(Map<String, dynamic> json) => CityResponse(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  nameEn: json['name_en'] as String?,
  createdAt: json['created_at'] as String?,
  updatedAt: json['updated_at'] as String?,
);

Map<String, dynamic> _$CityResponseToJson(CityResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'name_en': instance.nameEn,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
