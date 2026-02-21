import 'package:valley_of_arts/data/data.dart';
import 'package:valley_of_arts/domain/tickets/models/models.dart';

extension ProductsResponseMapper on ProductsResponse {
  List<Ticket> toDomainModel() {
    return data?.map((e) => e.toDomainModel()).toList() ?? [];
  }
}

extension ProductResponseMapper on ProductResponse {
  Ticket toDomainModel() {
    return Ticket(
      id: id ?? '',
      name: name ?? '',
      price: totalFormatted ?? '',
      imageUrl: imageUrl ?? '',
    );
  }
}