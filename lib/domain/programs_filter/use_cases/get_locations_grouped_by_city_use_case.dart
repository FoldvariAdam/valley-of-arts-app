import 'package:injectable/injectable.dart';
import 'package:valley_of_arts/data/repositories/programs_filter/programs_filters_repository.dart';
import 'package:valley_of_arts/domain/programs_filter/programs_filter.dart';

@injectable
class GetLocationsGroupedByCityUseCase {
  final ProgramsFiltersRepository _repository;

  GetLocationsGroupedByCityUseCase(this._repository);

  Future<List<CityWithLocations>> execute() async {
    final locations = await _repository.getLocations();
    return _groupLocationsByCity(locations);
  }

  List<CityWithLocations> _groupLocationsByCity(List<Location> locations) {
    final Map<String, CityWithLocations> grouped = {};

    for (final loc in locations) {
      final cityName = loc.cityName;

      if (cityName.trim().isEmpty) continue;

      if (!grouped.containsKey(cityName)) {
        grouped[cityName] = CityWithLocations(
          cityId: loc.cityId,
          cityName: cityName,
          locations: [],
        );
      }

      grouped[cityName]!.locations.add(loc);
    }

    return grouped.values.toList();
  }
}
