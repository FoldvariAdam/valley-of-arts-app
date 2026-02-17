part of 'home_bloc.dart';

@immutable
sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

final class HomeStartedEvent extends HomeEvent {
  const HomeStartedEvent();
}

final class HomeLoadMoreCurrentProgramsRequestedEvent extends HomeEvent {
  const HomeLoadMoreCurrentProgramsRequestedEvent();
}
