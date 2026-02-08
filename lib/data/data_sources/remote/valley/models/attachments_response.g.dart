// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachments_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttachmentsResponse _$AttachmentsResponseFromJson(Map<String, dynamic> json) =>
    AttachmentsResponse(
      id: json['id'] as String?,
      filename: json['filename'] as String?,
      mime: json['mime'] as String?,
      type: json['type'] as String?,
      size: (json['size'] as num?)?.toInt(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
      imageWidth: (json['image_width'] as num?)?.toInt(),
      imageHeight: (json['image_height'] as num?)?.toInt(),
      displayUrl: json['display_url'] as String?,
      thumbnailUrl: json['thumbnail_url'] as String?,
      downloadUrl: json['download_url'] as String?,
      displayName: json['display_name'] as String?,
    );

Map<String, dynamic> _$AttachmentsResponseToJson(
  AttachmentsResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'filename': instance.filename,
  'mime': instance.mime,
  'type': instance.type,
  'size': instance.size,
  'title': instance.title,
  'description': instance.description,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
  'deleted_at': instance.deletedAt,
  'image_width': instance.imageWidth,
  'image_height': instance.imageHeight,
  'display_url': instance.displayUrl,
  'thumbnail_url': instance.thumbnailUrl,
  'download_url': instance.downloadUrl,
  'display_name': instance.displayName,
};
