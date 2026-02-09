import 'package:json_annotation/json_annotation.dart';
import 'package:valley_of_arts/data/data_sources/remote/valley/models/attachments_response.dart';

part 'artist_response.g.dart';

@JsonSerializable()
class ArtistResponse {
  int? id;
  String? name;
  String? nameEn;
  String? description;
  String? descriptionEn;
  String? fbId;
  bool? onSite;
  int? onMobile;
  String? createdAt;
  String? updatedAt;
  int? programCount;
  List<AttachmentsResponse>? attachments;

  ArtistResponse({
    this.id,
    this.name,
    this.nameEn,
    this.description,
    this.descriptionEn,
    this.fbId,
    this.onSite,
    this.onMobile,
    this.createdAt,
    this.updatedAt,
    this.programCount,
    this.attachments,
  });

  factory ArtistResponse.fromJson(Map<String, dynamic> json) =>
      _$ArtistResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistResponseToJson(this);
}
