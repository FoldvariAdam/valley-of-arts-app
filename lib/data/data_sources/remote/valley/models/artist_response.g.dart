// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtistResponse _$ArtistResponseFromJson(Map<String, dynamic> json) =>
    ArtistResponse(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      nameEn: json['name_en'] as String?,
      description: json['description'] as String?,
      descriptionEn: json['description_en'] as String?,
      fbId: json['fb_id'] as String?,
      onSite: json['on_site'] as bool?,
      onMobile: (json['on_mobile'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      programCount: (json['program_count'] as num?)?.toInt(),
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => AttachmentsResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ArtistResponseToJson(ArtistResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'name_en': instance.nameEn,
      'description': instance.description,
      'description_en': instance.descriptionEn,
      'fb_id': instance.fbId,
      'on_site': instance.onSite,
      'on_mobile': instance.onMobile,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'program_count': instance.programCount,
      'attachments': instance.attachments?.map((e) => e.toJson()).toList(),
    };
