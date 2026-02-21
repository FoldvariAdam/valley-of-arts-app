import 'package:injectable/injectable.dart';
import 'package:valley_of_arts/data/data.dart';
import 'package:valley_of_arts/domain/domain.dart';

@LazySingleton(as: TicketsRepository)
class TicketsRepositoryImpl implements TicketsRepository {
  final TicketsApiClient _ticketsApiClient;

  TicketsRepositoryImpl(this._ticketsApiClient);

  @override
  Future<TicketsResult> getTickets() async {
    /// TODO: Add localization here
    final products = await _ticketsApiClient.getProducts('hu');

    final items = products.data ?? [];

    final festivalTickets = items
        .where(isFestivalTicket)
        .map((e) => e.toDomainModel())
        .toList();

    final campingTickets = items
        .where(isCampingTicket)
        .map((e) => e.toDomainModel())
        .toList();

    final extras = items
        .where(isExtra)
        .map((e) => e.toDomainModel())
        .toList();

    return TicketsResult(
      festival: festivalTickets,
      camping: campingTickets,
      extras: extras,
    );
  }

  bool isFestivalTicket(ProductResponse p) {
    return (p.name ?? '').toLowerCase().contains('bérlet');
  }

  bool isCampingTicket(ProductResponse p) {
    final name = (p.name ?? '').toLowerCase();

    return name.contains('kemping') ||
        name.contains('sátor') ||
        name.contains('faház') ||
        name.contains('bell tent') ||
        name.contains('kabin');
  }

  bool isExtra(ProductResponse p) {
    final name = (p.name ?? '').toLowerCase();

    return name.contains('parkoló') ||
        name.contains('locker');
  }
}
