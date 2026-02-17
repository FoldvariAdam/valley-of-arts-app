import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:valley_of_arts/data/repositories/favorites/favorites_repository.dart';
import 'package:valley_of_arts/domain/domain.dart';

part 'favorites_event.dart';

part 'favorites_state.dart';

@injectable
class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesRepository _favoritesRepository;

  FavoritesBloc(this._favoritesRepository)
    : super(const FavoritesInitialState()) {
    on<FavoritesFetchEvent>((event, emit) async {
      emit(const FavoritesLoadingState());
      try {
        final favorites = await _favoritesRepository.getFavorites();
        emit(FavoritesLoadedState(favorites));
      } catch (e) {
        emit(const FavoritesErrorState());
      }
    }, transformer: sequential());

    on<FavoriteDeleteEvent>((event, emit) async {
      //emit(const FavoritesLoadingState());
      try {
        await _favoritesRepository.deleteFavorite(event.id);
        final favorites = await _favoritesRepository.getFavorites();
        emit(FavoritesLoadedState(favorites));
      } catch (e) {
        emit(const FavoritesErrorState());
      }
    }, transformer: sequential());

    on<FavoritesClearEvent>((event, emit) async {
      emit(const FavoritesLoadingState());
      try {
        await _favoritesRepository.clearAllFavorites();
        emit(const FavoritesLoadedState([]));
      } catch (e) {
        emit(const FavoritesErrorState());
      }
    }, transformer: sequential());
  }
}
