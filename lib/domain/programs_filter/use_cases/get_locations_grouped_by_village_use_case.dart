import 'dart:math';

import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' show Position;
import 'package:valley_of_arts/data/repositories/programs_filter/programs_filters_repository.dart';
import 'package:valley_of_arts/domain/programs_filter/programs_filter.dart';

@injectable
class GetLocationsGroupedByVillageUseCase {
  final ProgramsFiltersRepository _repository;

  GetLocationsGroupedByVillageUseCase(this._repository);

  /// TODO: Firebase-ből
  static const List<int> _excludedLocationIds = [1052];

  Future<List<VillageWithLocations>> execute() async {
    final locations = await _repository.getLocations();
    return _groupLocationsByVillage(locations);
  }

  List<VillageWithLocations> _groupLocationsByVillage(
    List<Location> locations,
  ) {
    final Map<String, List<Location>> allGrouped = {};

    final filteredLocations = locations.where(
      (loc) => !_excludedLocationIds.contains(loc.id) && loc.position != null,
    ).toList();

    for (final loc in filteredLocations) {
      final villageName = loc.villageName;
      if (villageName.trim().isEmpty) continue;

      allGrouped.putIfAbsent(villageName, () => []).add(loc);
    }

    final Map<String, VillageWithLocations> villages = {};

    for (final entry in allGrouped.entries) {
      final villageName = entry.key;
      final villageLocations = entry.value;

      final firstWithPosition = villageLocations.firstWhereOrNull(
        (loc) => loc.position != null,
      );

      if (firstWithPosition != null) {
        final sortedLocations = _sortLocationsByProximity(villageLocations);

        villages[villageName] = VillageWithLocations(
          id: firstWithPosition.villageId,
          villageName: villageName,
          locations: sortedLocations,
          position: firstWithPosition.position!,
        );
      }
    }

    return villages.values.toList();
  }

  List<Location> _sortLocationsByProximity(List<Location> locations) {
    if (locations.isEmpty) return [];

    final start = locations.firstWhere((loc) => loc.position != null);
    final sorted = [start];
    final remaining = locations.where((l) => l != start).toList();

    while (remaining.isNotEmpty) {
      remaining.sort((a, b) =>
          _distance(sorted.last.position!, a.position!).compareTo(
              _distance(sorted.last.position!, b.position!)));
      sorted.add(remaining.removeAt(0));
    }

    return sorted;
  }


  double _distance(Position a, Position b) {
    final dx = a.lng - b.lng;
    final dy = a.lat - b.lat;
    return sqrt(dx * dx + dy * dy);
  }

}
