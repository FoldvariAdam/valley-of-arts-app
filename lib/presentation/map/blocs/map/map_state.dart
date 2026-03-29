part of 'map_bloc.dart';

@immutable
sealed class MapState extends Equatable {
  const MapState();

  @override
  List<Object?> get props => [];
}

final class MapInitialState extends MapState {
  const MapInitialState();
}

final class MapVillagesLoadedState extends MapState {
  final List<VillageWithLocations> villages;

  const MapVillagesLoadedState({
    required this.villages,
  });

  @override
  List<Object?> get props => [villages];
}
