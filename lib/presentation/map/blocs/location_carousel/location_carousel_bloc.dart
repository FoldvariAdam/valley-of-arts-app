import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:valley_of_arts/data/repositories/programs/programs.dart';
import 'package:valley_of_arts/domain/programs/models/models.dart';

part 'location_carousel_event.dart';

part 'location_carousel_state.dart';

@injectable
class LocationCarouselBloc
    extends Bloc<LocationCarouselEvent, LocationCarouselState> {
  final ProgramsRepository _programRepository;

  LocationCarouselBloc(this._programRepository)
    : super(LocationCarouselInitialState()) {
    on<LocationGetProgramEvent>((event, emit) async {
      try {
        final programs = await _programRepository.getPrograms(
          page: 0,
          perPage: 1,
          locationId: event.locationId,
        );

        if (programs.isEmpty) {
          emit(LocationCarouselProgramEmptyState());
          return;
        }

        emit(LocationCarouselProgramLoadedState(program: programs.first));
      } catch (_) {
      }
    });
  }
}
