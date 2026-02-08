// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationResponse _$LocationResponseFromJson(Map<String, dynamic> json) =>
    LocationResponse(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      nameEn: json['name_en'] as String?,
      cityId: (json['city_id'] as num?)?.toInt(),
      address: json['address'] as String?,
      location: (json['location'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      description: json['description'] as String?,
      descriptionEn: json['description_en'] as String?,
      onSite: (json['on_site'] as num?)?.toInt(),
      onMobile: (json['on_mobile'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      onMap: (json['on_map'] as num?)?.toInt(),
      markerX: (json['marker_x'] as num?)?.toInt(),
      markerY: (json['marker_y'] as num?)?.toInt(),
      markerDirection: json['marker_direction'] as String?,
      markerIcon: json['marker_icon'] as String?,
      locationTypeId: (json['location_type_id'] as num?)?.toInt(),
      programsSheetDocumentId: json['programs_sheet_document_id'] as String?,
      hasPrograms: json['has_programs'] as bool?,
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => AttachmentsResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      city: json['city'] == null
          ? null
          : CityResponse.fromJson(json['city'] as Map<String, dynamic>),
      locationType: json['location_type'] == null
          ? null
          : TypesResponse.fromJson(
              json['location_type'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$LocationResponseToJson(LocationResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'name_en': instance.nameEn,
      'city_id': instance.cityId,
      'address': instance.address,
      'location': instance.location,
      'description': instance.description,
      'description_en': instance.descriptionEn,
      'on_site': instance.onSite,
      'on_mobile': instance.onMobile,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'on_map': instance.onMap,
      'marker_x': instance.markerX,
      'marker_y': instance.markerY,
      'marker_direction': instance.markerDirection,
      'marker_icon': instance.markerIcon,
      'location_type_id': instance.locationTypeId,
      'programs_sheet_document_id': instance.programsSheetDocumentId,
      'has_programs': instance.hasPrograms,
      'attachments': instance.attachments?.map((e) => e.toJson()).toList(),
      'city': instance.city?.toJson(),
      'location_type': instance.locationType?.toJson(),
    };
