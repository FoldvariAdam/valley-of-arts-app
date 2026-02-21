import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:valley_of_arts/core/core.dart';
import 'package:valley_of_arts/domain/tickets/models/models.dart';
import 'package:valley_of_arts/presentation/presentation.dart';

class TicketCard extends StatelessWidget {
  final Ticket ticket;

  const TicketCard({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return AppCard(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: appTheme.s1),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(ticket.name, style: appTheme.smallHeadLine),

                    SizedBox(height: appTheme.s1),
                  ],
                ),
              ),

              SizedBox(width: appTheme.s1),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(ticket.price.toString(), style: appTheme.smallHeadLine),
                ],
              ),
            ],
          ),

          CachedNetworkImage(
            imageUrl: ticket.imageUrl,
            fit: BoxFit.cover,
            memCacheHeight: 180,
            memCacheWidth: 300,
            placeholder: (context, url) => const ImagePlaceholder(),
            errorWidget: (context, url, error) => const ImagePlaceholder(),
            fadeInDuration: const Duration(milliseconds: 300),
          ),

          SizedBox(height: appTheme.s1),

          AppButton(
            width: double.infinity,
            height: 40,
            text: 'Jegyvásrlás',
            onPressed: () async {
              try {
                await TicketService().addTicketToCart(ticketId: ticket.id);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Hiba a kosárhoz adáskor: $e')),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class TicketService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://jegyek.muveszetekvolgye.hu',
      headers: {"Content-Type": "application/json"},
    ),
  );

  Future<void> addTicketToCart({required String ticketId, int qty = 1}) async {
    final body = {
      "cart": [
        {"id": ticketId, "qty": qty},
      ],
      "tickets": [],
      "coupon": null,
      "customer": null, // backend létrehozza a guest ID-t
      "callback": "https://www.muveszetekvolgye.hu/checkout/success",
    };

    try {
      final response = await _dio.post(
        '/api/cart?l=hu',
        data: jsonEncode(body),
      );

      if (response.statusCode != 200) {
        throw Exception('Hiba a kosár frissítésekor');
      }

      final data = response.data;
      final customerId = data['customer'];
      final checkoutUrl = 'https://www.muveszetekvolgye.hu/checkout';

      if (await canLaunchUrl(Uri.parse(checkoutUrl))) {
        await launchUrl(Uri.parse(checkoutUrl));
      } else {
        throw Exception('Nem sikerült megnyitni a checkout URL-t');
      }
    } catch (e) {
      print('Hiba a jegy hozzáadásakor: $e');
      rethrow;
    }
  }
}
