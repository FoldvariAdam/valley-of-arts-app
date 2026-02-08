import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:valley_of_arts/data/repositories/programs/programs_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ProgramsRepository _programRepository;

  HomeBloc({required ProgramsRepository programRepository})
      : _programRepository = programRepository, super(HomeInitial()) {
    on<HomeGetPinnedEventsEvent>((event, emit) async {
      final programs = _programRepository.getPrograms();
    });
  }
}
