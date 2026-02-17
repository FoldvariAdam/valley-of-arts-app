part of 'programs_bloc.dart';

@immutable
sealed class ProgramsEvent extends Equatable {
  const ProgramsEvent();

  @override
  List<Object?> get props => [];
}

final class ProgramsStartedEvent extends ProgramsEvent {
  const ProgramsStartedEvent();
}

final class ProgramsFilterChangedEvent extends ProgramsEvent {
  final String? date;
  final List<int>? categories;
  final int? location;

  const ProgramsFilterChangedEvent({this.date, this.categories, this.location});

  @override
  List<Object?> get props => [date, categories, location];
}
