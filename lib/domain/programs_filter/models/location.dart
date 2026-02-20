import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class Location {
  final int id;
  final String name;
  final int villageId;
  final String villageName;
  final Position? position;

  Location({
    required this.id,
    required this.name,
    required this.villageId,
    required this.villageName,
    required this.position,
  });
}

class VillageWithLocations {
  final int? id;
  final String villageName;
  final List<Location> locations;
  final Position position;

  VillageWithLocations({
    required this.id,
    required this.villageName,
    required this.locations,
    required this.position,
  });
}
