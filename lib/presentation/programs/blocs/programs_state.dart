part of 'programs_bloc.dart';

@immutable
sealed class ProgramsState extends Equatable {
  const ProgramsState();

  @override
  List<Object?> get props => [];
}

abstract class ProgramsWithDataState extends ProgramsState {
  final List<Program> programs;

  const ProgramsWithDataState(this.programs);

  @override
  List<Object?> get props => [programs];
}

final class ProgramsInitialState extends ProgramsState {
  const ProgramsInitialState();
}

final class ProgramsFiltersLoadedState extends ProgramsWithDataState {
  final Schedule schedule;
  final List<Category> categories;
  final List<VillageWithLocations> locations;

  const ProgramsFiltersLoadedState({
    required this.schedule,
    required this.categories,
    required this.locations,
    required List<Program> programs,
  }) : super(programs);

  @override
  List<Object?> get props => [schedule, categories, locations];
}

final class ProgramsLoadingState extends ProgramsState {
  const ProgramsLoadingState();
}

final class ProgramsLoadedState extends ProgramsWithDataState {
  const ProgramsLoadedState({required List<Program> programs})
    : super(programs);
}
