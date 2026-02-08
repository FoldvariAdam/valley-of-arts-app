// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'program_categories_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProgramCategoriesResponse _$ProgramCategoriesResponseFromJson(
  Map<String, dynamic> json,
) => ProgramCategoriesResponse(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  nameEn: json['name_en'] as String?,
  color: json['color'] as String?,
  createdAt: json['created_at'] as String?,
  updatedAt: json['updated_at'] as String?,
  order: (json['order'] as num?)?.toInt(),
  isHidden: (json['is_hidden'] as num?)?.toInt(),
);

Map<String, dynamic> _$ProgramCategoriesResponseToJson(
  ProgramCategoriesResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'name_en': instance.nameEn,
  'color': instance.color,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
  'order': instance.order,
  'is_hidden': instance.isHidden,
};
