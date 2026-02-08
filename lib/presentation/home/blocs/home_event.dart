part of 'home_bloc.dart';

@immutable
sealed class HomeEvent extends Equatable {}

final class HomeGetPinnedEventsEvent extends HomeEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}


