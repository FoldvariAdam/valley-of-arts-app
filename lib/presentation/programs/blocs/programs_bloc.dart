import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:valley_of_arts/data/repositories/repositories.dart';
import 'package:valley_of_arts/domain/domain.dart';

part 'programs_event.dart';

part 'programs_state.dart';

@injectable
class ProgramsBloc extends Bloc<ProgramsEvent, ProgramsState> {
  final ProgramsRepository _programRepository;
  final ProgramsFiltersRepository _programsFiltersRepository;
  final GetLocationsGroupedByCityUseCase _getLocationsGroupedByCityUseCase;

  ProgramsBloc({
    required ProgramsRepository programRepository,
    required ProgramsFiltersRepository programsFiltersRepository,
    required GetLocationsGroupedByCityUseCase getLocationsGroupedByCityUseCase,
  }) : _programRepository = programRepository,
       _programsFiltersRepository = programsFiltersRepository,
       _getLocationsGroupedByCityUseCase = getLocationsGroupedByCityUseCase,
       super(const ProgramsInitial()) {
    on<ProgramsStarted>((event, emit) async {
      final filters = await Future.wait([
        _getLocationsGroupedByCityUseCase.execute(),
        _programsFiltersRepository.getAvailableDates(),
        _programsFiltersRepository.getCategories(),
        _programRepository.getPrograms(),
      ]);

      final locationsGroupedByCity = filters[0] as List<CityWithLocations>;
      final schedule = filters[1] as Schedule;
      final categories = filters[2] as List<Category>;
      final programs = filters[3] as List<Program>;

      emit(
        ProgramsFiltersLoaded(
          locations: locationsGroupedByCity,
          schedule: schedule,
          categories: categories,
          programs: programs,
        ),
      );
    });

    on<ProgramsFilterChanged>((event, emit) async {
      emit(const ProgramsLoading());
      final filteredPrograms = await _programRepository.getPrograms(
        date: event.date,
        locationId: event.location,
        categoryIds: event.categories,
      );

      emit(ProgramsLoaded(programs: filteredPrograms));
    });
  }
}
