part of 'map_bloc.dart';

@immutable
sealed class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object?> get props => [];
}

final class MapGetLocationsEvent extends MapEvent {
  const MapGetLocationsEvent();
}

final class MapGetProgramEvent extends MapEvent {
  const MapGetProgramEvent();
}


