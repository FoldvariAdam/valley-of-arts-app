import 'package:valley_of_arts/domain/tickets/models/ticket.dart';

class TicketsResult {
  final List<Ticket> festival;
  final List<Ticket> camping;
  final List<Ticket> extras;

  TicketsResult({
    required this.festival,
    required this.camping,
    required this.extras,
  });
}