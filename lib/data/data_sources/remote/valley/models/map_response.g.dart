// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapResponse _$MapResponseFromJson(Map<String, dynamic> json) =>
    MapResponse(data: MapData.fromJson(json['data'] as Map<String, dynamic>));

Map<String, dynamic> _$MapResponseToJson(MapResponse instance) =>
    <String, dynamic>{'data': instance.data.toJson()};

MapData _$MapDataFromJson(Map<String, dynamic> json) => MapData(
  types: (json['types'] as List<dynamic>)
      .map((e) => TypesResponse.fromJson(e as Map<String, dynamic>))
      .toList(),
  locations: (json['locations'] as List<dynamic>)
      .map((e) => LocationResponse.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$MapDataToJson(MapData instance) => <String, dynamic>{
  'types': instance.types.map((e) => e.toJson()).toList(),
  'locations': instance.locations.map((e) => e.toJson()).toList(),
};
