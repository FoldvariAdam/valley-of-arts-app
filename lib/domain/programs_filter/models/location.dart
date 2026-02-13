class Location {
  final int id;
  final String name;
  final int cityId;
  final String cityName;

  Location({
    required this.id,
    required this.name,
    required this.cityId,
    required this.cityName,
  });
}

class CityWithLocations {
  final int? cityId;
  final String cityName;
  final List<Location> locations;

  CityWithLocations({
    required this.cityId,
    required this.cityName,
    required this.locations,
  });
}
