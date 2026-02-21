import 'package:valley_of_arts/domain/domain.dart';

abstract class TicketsRepository {
  Future<TicketsResult> getTickets();
}