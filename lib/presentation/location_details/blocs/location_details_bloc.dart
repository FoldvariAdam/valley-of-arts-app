import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:valley_of_arts/data/data.dart';
import 'package:valley_of_arts/domain/programs/models/models.dart';
import 'package:valley_of_arts/domain/programs_filter/models/models.dart';

part 'location_details_event.dart';

part 'location_details_state.dart';

@injectable
class LocationDetailsBloc
    extends Bloc<LocationDetailsEvent, LocationDetailsState> {
  final ProgramsRepository _programRepository;
  final ProgramsFiltersRepository _programsFiltersRepository;

  LocationDetailsBloc(this._programRepository, this._programsFiltersRepository)
    : super(LocationDetailsInitialState()) {
    on<LocationDetailsStartedEvent>((event, emit) async {
      try {
        emit(const LocationDetailsLoadingState());

        final programs = await _programRepository.getPrograms(
          locationId: event.locationId,
        );
        final schedule = await _programsFiltersRepository.getAvailableDates();

        emit(
          LocationDetailsFiltersLoadedState(
            schedule: schedule,
            programs: programs,
          ),
        );
      } catch (_) {}
    });

    on<LocationDetailsFilterChangedEvent>((event, emit) async {
      try {
        emit(const LocationDetailsLoadingState());

        final programs = await _programRepository.getPrograms(
          locationId: event.locationId,
          date: event.date,
        );

        emit(LocationDetailsLoadedState(programs: programs));
      } catch (_) {}
    });
  }
}
