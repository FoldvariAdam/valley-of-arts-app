// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'types_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TypesResponse _$TypesResponseFromJson(Map<String, dynamic> json) =>
    TypesResponse(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      nameEn: json['name_en'] as String?,
      color: json['color'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$TypesResponseToJson(TypesResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'name_en': instance.nameEn,
      'color': instance.color,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
