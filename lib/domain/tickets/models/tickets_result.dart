import 'package:equatable/equatable.dart';
import 'package:valley_of_arts/domain/tickets/models/ticket.dart';

class TicketsResult extends Equatable {
  final List<Ticket> festival;
  final List<Ticket> camping;
  final List<Ticket> extras;

  const TicketsResult({
    required this.festival,
    required this.camping,
    required this.extras,
  });

  @override
  List<Object?> get props => [festival, camping, extras];
}