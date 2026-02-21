part of 'tickets_bloc.dart';

@immutable
sealed class TicketsEvent extends Equatable {
  const TicketsEvent();

  @override
  List<Object?> get props => [];
}

final class TicketsFetchEvent extends TicketsEvent {
  const TicketsFetchEvent();
}
