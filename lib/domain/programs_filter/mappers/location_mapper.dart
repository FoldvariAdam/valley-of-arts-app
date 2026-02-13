import 'package:valley_of_arts/data/data.dart';
import 'package:valley_of_arts/domain/programs_filter/models/models.dart';

extension LocationResponseMapper on LocationResponse {
  Location toDomainModel() => Location(
    id: id ?? 0,
    name: name ?? '',
    cityId: city?.id ?? 0,
    cityName: city?.name ?? '',
  );
}
