part of 'location_details_bloc.dart';

@immutable
sealed class LocationDetailsEvent extends Equatable {
  final int locationId;

  const LocationDetailsEvent(this.locationId);

  @override
  List<Object?> get props => [locationId];
}

final class LocationDetailsStartedEvent extends LocationDetailsEvent {
  const LocationDetailsStartedEvent({required int locationId})
    : super(locationId);
}

final class LocationDetailsFilterChangedEvent extends LocationDetailsEvent {
  final String? date;

  const LocationDetailsFilterChangedEvent({
    required int locationId,
    required this.date,
  }) : super(locationId);

  /// TODO check if props is inherited
  @override
  List<Object?> get props => [date];
}
