// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductsResponse _$ProductsResponseFromJson(Map<String, dynamic> json) =>
    ProductsResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ProductResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductsResponseToJson(ProductsResponse instance) =>
    <String, dynamic>{'data': instance.data?.map((e) => e.toJson()).toList()};

ProductResponse _$ProductResponseFromJson(Map<String, dynamic> json) =>
    ProductResponse(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      longDescription: json['long_description'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      prices: (json['prices'] as List<dynamic>?)
          ?.map((e) => Prices.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentPrice: (json['current_price'] as num?)?.toDouble(),
      from: json['from'] as String?,
      to: json['to'] as String?,
      imageUrl: json['image_url'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      isOrderable: json['is_orderable'] as bool?,
      isFeatured: json['is_featured'] as bool?,
      hasDiscount: json['has_discount'] as bool?,
      limitations: json['limitations'] as String?,
      taxAmount: (json['tax_amount'] as num?)?.toDouble(),
      total: (json['total'] as num?)?.toDouble(),
      totalFormatted: json['total_formatted'] as String?,
      discountedPrice: (json['discounted_price'] as num?)?.toDouble(),
      discountedTaxAmount: (json['discounted_tax_amount'] as num?)?.toDouble(),
      discountedTotal: (json['discounted_total'] as num?)?.toDouble(),
      discountedTotalFormatted: json['discounted_total_formatted'] as String?,
      discountText: json['discount_text'] as String?,
    );

Map<String, dynamic> _$ProductResponseToJson(ProductResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'long_description': instance.longDescription,
      'price': instance.price,
      'prices': instance.prices?.map((e) => e.toJson()).toList(),
      'current_price': instance.currentPrice,
      'from': instance.from,
      'to': instance.to,
      'image_url': instance.imageUrl,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'is_orderable': instance.isOrderable,
      'is_featured': instance.isFeatured,
      'has_discount': instance.hasDiscount,
      'limitations': instance.limitations,
      'tax_amount': instance.taxAmount,
      'total': instance.total,
      'total_formatted': instance.totalFormatted,
      'discounted_price': instance.discountedPrice,
      'discounted_tax_amount': instance.discountedTaxAmount,
      'discounted_total': instance.discountedTotal,
      'discounted_total_formatted': instance.discountedTotalFormatted,
      'discount_text': instance.discountText,
    };

Prices _$PricesFromJson(Map<String, dynamic> json) => Prices(
  to: json['to'] as String?,
  from: json['from'] as String?,
  gross: json['gross'] as String?,
  total: (json['total'] as num?)?.toInt(),
  value: (json['value'] as num?)?.toDouble(),
  quantity: (json['quantity'] as num?)?.toInt(),
  toFormatted: json['to_formatted'] as String?,
  fromFormatted: json['from_formatted'] as String?,
  id: (json['id'] as num?)?.toInt(),
);

Map<String, dynamic> _$PricesToJson(Prices instance) => <String, dynamic>{
  'to': instance.to,
  'from': instance.from,
  'gross': instance.gross,
  'total': instance.total,
  'value': instance.value,
  'quantity': instance.quantity,
  'to_formatted': instance.toFormatted,
  'from_formatted': instance.fromFormatted,
  'id': instance.id,
};
