import 'package:equatable/equatable.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class Location extends Equatable {
  final int id;
  final String name;
  final int villageId;
  final String villageName;
  final Position? position;

  const Location({
    required this.id,
    required this.name,
    required this.villageId,
    required this.villageName,
    required this.position,
  });

  @override
  List<Object?> get props => [id, name, villageId, villageName, position];
}

class VillageWithLocations extends Equatable {
  final int? id;
  final String villageName;
  final List<Location> locations;
  final Position position;

  const VillageWithLocations({
    required this.id,
    required this.villageName,
    required this.locations,
    required this.position,
  });

  @override
  List<Object?> get props => [id, villageName, locations, position];
}
