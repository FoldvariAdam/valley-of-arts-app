import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:valley_of_arts/data/data.dart';
import 'package:valley_of_arts/domain/domain.dart';

part 'tickets_event.dart';

part 'tickets_state.dart';

@injectable
class TicketsBloc extends Bloc<TicketsEvent, TicketsState> {
  final TicketsRepository _ticketsRepository;

  TicketsBloc(this._ticketsRepository) : super(TicketsInitialState()) {
    on<TicketsFetchEvent>((event, emit) async {
      try {
        final tickets = await _ticketsRepository.getTickets();

        emit(
          TicketsLoadedState(
            festivalTickets: tickets.festival,
            campingTickets: tickets.camping,
          ),
        );
      } catch (_) {}
    });
  }
}
