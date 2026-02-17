part of 'favorites_bloc.dart';

@immutable
sealed class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object?> get props => [];
}

final class FavoritesInitialState extends FavoritesState {
  const FavoritesInitialState();
}

final class FavoritesLoadingState extends FavoritesState {
  const FavoritesLoadingState();
}

final class FavoritesLoadedState extends FavoritesState {
  final List<Program> favoritePrograms;

  const FavoritesLoadedState(this.favoritePrograms);

  /// TODO Check if this works
  @override
  List<Object?> get props => [favoritePrograms];
}

final class FavoritesErrorState extends FavoritesState {
  const FavoritesErrorState();
}
