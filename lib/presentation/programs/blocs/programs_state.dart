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

final class ProgramsInitial extends ProgramsState {
  const ProgramsInitial();
}

final class ProgramsFiltersLoaded extends ProgramsWithDataState {
  final Schedule schedule;
  final List<Category> categories;
  final List<CityWithLocations> locations;

  const ProgramsFiltersLoaded({
    required this.schedule,
    required this.categories,
    required this.locations,
    required List<Program> programs,
  }) : super(programs);

  @override
  List<Object?> get props => [schedule, categories, locations];
}

final class ProgramsLoading extends ProgramsState {
  const ProgramsLoading();
}

final class ProgramsLoaded extends ProgramsWithDataState {
  const ProgramsLoaded({required List<Program> programs}) : super(programs);
}
