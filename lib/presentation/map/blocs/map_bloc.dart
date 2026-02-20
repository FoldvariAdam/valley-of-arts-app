import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:valley_of_arts/data/data.dart';
import 'package:valley_of_arts/domain/programs_filter/programs_filter.dart';

part 'map_event.dart';
part 'map_state.dart';

@injectable
class MapBloc extends Bloc<MapEvent, MapState> {
  final ProgramsRepository _programRepository;
  final GetLocationsGroupedByVillageUseCase _getLocationsGroupedByVillageUseCase;

  MapBloc(this._programRepository, this._getLocationsGroupedByVillageUseCase) : super(const MapInitialState()) {
    on<MapGetLocationsEvent>((event, emit) async {
      final villages = await _getLocationsGroupedByVillageUseCase.execute();
      emit(MapVillagesLoadedState(villages: villages));
    });

    on<MapGetProgramEvent>((event, emit) {
      // TODO: get first event
    });
  }
}
