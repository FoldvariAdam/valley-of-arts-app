part of 'location_details_bloc.dart';

@immutable
sealed class LocationDetailsState extends Equatable {
  const LocationDetailsState();

  @override
  List<Object?> get props => [];
}

abstract class LocationDetailsWithDataState extends LocationDetailsState {
  final List<Program> programs;

  const LocationDetailsWithDataState(this.programs);

  @override
  List<Object?> get props => [programs];
}

final class LocationDetailsInitialState extends LocationDetailsState {}

final class LocationDetailsFiltersLoadedState extends LocationDetailsWithDataState {
  final Schedule schedule;

  const LocationDetailsFiltersLoadedState({
    required this.schedule,
    required List<Program> programs,
  }) : super(programs);

  @override
  List<Object?> get props => [schedule];
}

final class LocationDetailsLoadingState extends LocationDetailsState {
  const LocationDetailsLoadingState();
}

final class LocationDetailsLoadedState extends LocationDetailsWithDataState {
  const LocationDetailsLoadedState({required List<Program> programs})
      : super(programs);
}
