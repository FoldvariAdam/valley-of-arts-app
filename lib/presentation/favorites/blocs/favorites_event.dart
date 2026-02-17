part of 'favorites_bloc.dart';

@immutable
sealed class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

final class FavoritesFetchEvent extends FavoritesEvent {
  const FavoritesFetchEvent();
}

final class FavoriteDeleteEvent extends FavoritesEvent {
  final int id;

  const FavoriteDeleteEvent(this.id);

  @override
  List<Object?> get props => [id];
}

final class FavoritesClearEvent extends FavoritesEvent {
  const FavoritesClearEvent();
}
