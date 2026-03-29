part of 'location_carousel_bloc.dart';

@immutable
sealed class LocationCarouselState extends Equatable {
  const LocationCarouselState();

  @override
  List<Object?> get props => [];
}

final class LocationCarouselInitialState extends LocationCarouselState {}

final class LocationCarouselLoadingState extends LocationCarouselState {}

final class LocationCarouselProgramLoadedState extends LocationCarouselState {
  final Program program;

  const LocationCarouselProgramLoadedState({required this.program});

  @override
  List<Object?> get props => [program];
}

final class LocationCarouselProgramEmptyState extends LocationCarouselState {
  const LocationCarouselProgramEmptyState();
}
