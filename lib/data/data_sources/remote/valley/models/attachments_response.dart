import 'package:json_annotation/json_annotation.dart';

part 'attachments_response.g.dart';

@JsonSerializable()
class AttachmentsResponse {
  final String? id;
  final String? filename;
  final String? mime;
  final String? type;
  final int? size;
  final String? title;
  final String? description;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final int? imageWidth;
  final int? imageHeight;
  final String? displayUrl;
  final String? thumbnailUrl;
  final String? downloadUrl;
  final String? displayName;

  const AttachmentsResponse({
    this.id,
    this.filename,
    this.mime,
    this.type,
    this.size,
    this.title,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.imageWidth,
    this.imageHeight,
    this.displayUrl,
    this.thumbnailUrl,
    this.downloadUrl,
    this.displayName,
  });

  factory AttachmentsResponse.fromJson(Map<String, dynamic> json) =>
      _$AttachmentsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AttachmentsResponseToJson(this);
}
