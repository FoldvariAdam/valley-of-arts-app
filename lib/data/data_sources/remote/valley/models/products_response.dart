import 'package:json_annotation/json_annotation.dart';

part 'products_response.g.dart';

@JsonSerializable()
class ProductsResponse {
  List<ProductResponse>? data;

  ProductsResponse({this.data});

  factory ProductsResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsResponseToJson(this);
}

@JsonSerializable()
class ProductResponse {
  String? id;
  String? name;
  String? description;
  String? longDescription;
  double? price;
  List<Prices>? prices;
  double? currentPrice;
  String? from;
  String? to;
  String? imageUrl;
  String? createdAt;
  String? updatedAt;
  bool? isOrderable;
  bool? isFeatured;
  bool? hasDiscount;
  String? limitations;
  double? taxAmount;
  double? total;
  String? totalFormatted;
  double? discountedPrice;
  double? discountedTaxAmount;
  double? discountedTotal;
  String? discountedTotalFormatted;
  String? discountText;

  ProductResponse({
    this.id,
    this.name,
    this.description,
    this.longDescription,
    this.price,
    this.prices,
    this.currentPrice,
    this.from,
    this.to,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
    this.isOrderable,
    this.isFeatured,
    this.hasDiscount,
    this.limitations,
    this.taxAmount,
    this.total,
    this.totalFormatted,
    this.discountedPrice,
    this.discountedTaxAmount,
    this.discountedTotal,
    this.discountedTotalFormatted,
    this.discountText,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);
}

@JsonSerializable()
class Prices {
  String? to;
  String? from;
  String? gross;
  int? total;
  double? value;
  int? quantity;
  String? toFormatted;
  String? fromFormatted;
  int? id;

  Prices({
    this.to,
    this.from,
    this.gross,
    this.total,
    this.value,
    this.quantity,
    this.toFormatted,
    this.fromFormatted,
    this.id,
  });

  factory Prices.fromJson(Map<String, dynamic> json) =>
      _$PricesFromJson(json);

  Map<String, dynamic> toJson() => _$PricesToJson(this);
}