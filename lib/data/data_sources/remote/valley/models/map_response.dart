import 'package:json_annotation/json_annotation.dart';
import 'package:valley_of_arts/data/data_sources/remote/valley/models/location_response.dart';
import 'package:valley_of_arts/data/data_sources/remote/valley/models/types_response.dart';

part 'map_response.g.dart';

@JsonSerializable()
class MapResponse {
  final MapData data;

  MapResponse({required this.data});

  factory MapResponse.fromJson(Map<String, dynamic> json) =>
      _$MapResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MapResponseToJson(this);
}

@JsonSerializable()
class MapData {
  final List<TypesResponse> types;
  final List<LocationResponse> locations;

  MapData({
    required this.types,
    required this.locations,
  });

  factory MapData.fromJson(Map<String, dynamic> json) =>
      _$MapDataFromJson(json);

  Map<String, dynamic> toJson() => _$MapDataToJson(this);
}
