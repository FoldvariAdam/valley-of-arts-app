part of 'home_bloc.dart';

@immutable
/// TODO abstract or sealed?
abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

final class HomeStart extends HomeEvent {}

final class HomeGetCurrentProgramsEvent extends HomeEvent {}


