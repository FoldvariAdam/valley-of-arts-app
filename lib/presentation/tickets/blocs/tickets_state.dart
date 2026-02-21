part of 'tickets_bloc.dart';

@immutable
sealed class TicketsState extends Equatable {
  const TicketsState();

  @override
  List<Object?> get props => [];
}

final class TicketsInitialState extends TicketsState {}

final class TicketsLoadedState extends TicketsState {
  final List<Ticket> festivalTickets;
  final List<Ticket> campingTickets;

  const TicketsLoadedState({
    required this.festivalTickets,
    required this.campingTickets,
  });

  @override
  List<Object?> get props => [festivalTickets, campingTickets];
}
