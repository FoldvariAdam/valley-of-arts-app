import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:valley_of_arts/data/data.dart';
import 'package:valley_of_arts/domain/programs_filter/models/models.dart';

extension LocationResponseMapper on LocationResponse {
  Location toDomainModel() => Location(
    id: id ?? 0,
    name: name ?? '',
    villageId: city?.id ?? 0,
    villageName: city?.name ?? '',
    position: position,
    displayUrl: attachments?.isNotEmpty == true
        ? attachments!.first.displayUrl ?? ''
        : '',
  );

  Position? get position => location != null && location!.length >= 2
      ? Position(location![1], location![0])
      : null;
}
