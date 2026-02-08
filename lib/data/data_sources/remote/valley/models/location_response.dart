import 'package:json_annotation/json_annotation.dart';
import 'package:valley_of_arts/data/data_sources/remote/valley/models/attachments_response.dart';
import 'package:valley_of_arts/data/data_sources/remote/valley/models/city_response.dart';
import 'package:valley_of_arts/data/data_sources/remote/valley/models/types_response.dart';

part 'location_response.g.dart';

@JsonSerializable()
class LocationResponse {
  int? id;
  String? name;
  String? nameEn;
  int? cityId;
  String? address;
  List<double>? location;
  String? description;
  String? descriptionEn;
  int? onSite;
  int? onMobile;
  String? createdAt;
  String? updatedAt;
  int? onMap;
  int? markerX;
  int? markerY;
  String? markerDirection;
  String? markerIcon;
  int? locationTypeId;
  String? programsSheetDocumentId;
  bool? hasPrograms;
  List<AttachmentsResponse>? attachments;
  CityResponse? city;
  TypesResponse? locationType;

  LocationResponse({
    this.id,
    this.name,
    this.nameEn,
    this.cityId,
    this.address,
    this.location,
    this.description,
    this.descriptionEn,
    this.onSite,
    this.onMobile,
    this.createdAt,
    this.updatedAt,
    this.onMap,
    this.markerX,
    this.markerY,
    this.markerDirection,
    this.markerIcon,
    this.locationTypeId,
    this.programsSheetDocumentId,
    this.hasPrograms,
    this.attachments,
    this.city,
    this.locationType,
  });

  factory LocationResponse.fromJson(Map<String, dynamic> json) =>
      _$LocationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LocationResponseToJson(this);
}
