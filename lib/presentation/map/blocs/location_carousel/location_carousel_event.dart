part of 'location_carousel_bloc.dart';

@immutable
sealed class LocationCarouselEvent extends Equatable {
  const LocationCarouselEvent();

  @override
  List<Object?> get props => [];
}

final class LocationGetProgramEvent extends LocationCarouselEvent {
  final int locationId;

  const LocationGetProgramEvent(this.locationId);

  @override
  List<Object?> get props => [locationId];
}
