// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'program_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProgramResponse _$ProgramResponseFromJson(Map<String, dynamic> json) =>
    ProgramResponse(
      id: (json['id'] as num?)?.toInt(),
      slug: json['slug'] as String?,
      name: json['name'] as String?,
      nameEn: json['name_en'] as String?,
      start: json['start'] as String?,
      end: json['end'] as String?,
      description: json['description'] as String?,
      descriptionEn: json['description_en'] as String?,
      longDescription: json['long_description'] as String?,
      longDescriptionEn: json['long_description_en'] as String?,
      locationId: (json['location_id'] as num?)?.toInt(),
      isAllDay: json['is_all_day'] as bool?,
      isInvalid: json['is_invalid'] as bool?,
      onSite: (json['on_site'] as num?)?.toInt(),
      onMobile: (json['on_mobile'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      pinned: (json['pinned'] as num?)?.toInt(),
      isChanged: json['is_changed'] as bool?,
      onStage: json['on_stage'] as bool?,
      artists: (json['artists'] as List<dynamic>?)
          ?.map((e) => ArtistResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      location: json['location'] == null
          ? null
          : LocationResponse.fromJson(json['location'] as Map<String, dynamic>),
      programCategories: (json['program_categories'] as List<dynamic>?)
          ?.map(
            (e) =>
                ProgramCategoriesResponse.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$ProgramResponseToJson(ProgramResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'slug': instance.slug,
      'name': instance.name,
      'name_en': instance.nameEn,
      'start': instance.start,
      'end': instance.end,
      'description': instance.description,
      'description_en': instance.descriptionEn,
      'long_description': instance.longDescription,
      'long_description_en': instance.longDescriptionEn,
      'location_id': instance.locationId,
      'is_all_day': instance.isAllDay,
      'is_invalid': instance.isInvalid,
      'on_site': instance.onSite,
      'on_mobile': instance.onMobile,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'pinned': instance.pinned,
      'is_changed': instance.isChanged,
      'on_stage': instance.onStage,
      'artists': instance.artists?.map((e) => e.toJson()).toList(),
      'location': instance.location?.toJson(),
      'program_categories': instance.programCategories
          ?.map((e) => e.toJson())
          .toList(),
    };
