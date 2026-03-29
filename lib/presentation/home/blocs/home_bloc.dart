import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:valley_of_arts/data/repositories/programs/programs_repository.dart';
import 'package:valley_of_arts/domain/programs/models/models.dart';

part 'home_event.dart';

part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ProgramsRepository _programRepository;

  HomeBloc(this._programRepository) : super(const HomeState()) {
    on<HomeStartedEvent>((event, emit) async {
      emit(
        state.copyWith(
          loadingPopular: true,
          loadingCurrent: true,
          loadingFavorites: true,
        ),
      );

      await Future.wait([
        _loadPinned(emit),
        _loadCurrent(emit),
        _loadFavorites(emit),
      ]);
    });

    on<HomeLoadMoreCurrentProgramsRequestedEvent>((event, emit) async {
      emit(state.copyWith(loadingCurrent: true));
      await _loadCurrent(emit);
    }, transformer: droppable());
  }

  Future<void> _loadPinned(Emitter<HomeState> emit) async {
    try {
      final result = await _programRepository.getPrograms(onlyPinned: true);
      emit(state.copyWith(popularPrograms: result.take(6).toList(), loadingPopular: false));
    } catch (e) {
      emit(state.copyWith(errorPopular: e.toString(), loadingPopular: false));
    }
  }

  Future<void> _loadCurrent(Emitter<HomeState> emit, {int? page}) async {
    final nextPage = page ?? state.currentProgramsPage;
    try {
      final result = await _programRepository.getPrograms(
        page: nextPage,
        perPage: 20,
      );

      emit(
        state.copyWith(
          currentPrograms: [...state.currentPrograms ?? [], ...result],
          loadingCurrent: false,
          currentProgramsPage: nextPage + 1,
        ),
      );
    } catch (e) {
      emit(state.copyWith(errorCurrent: e.toString(), loadingCurrent: false));
    }
  }

  Future<void> _loadFavorites(Emitter<HomeState> emit) async {
    try {
      final result = await _programRepository.getFavoritesLength();
      emit(state.copyWith(favoritesLength: result, loadingFavorites: false));
    } catch (e) {
      emit(
        state.copyWith(errorFavorites: e.toString(), loadingFavorites: false),
      );
    }
  }
}
