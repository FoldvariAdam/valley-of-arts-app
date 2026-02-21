import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:valley_of_arts/data/data_sources/remote/valley/models/models.dart';

part 'tickets_api_client.g.dart';

@RestApi(baseUrl: 'https://jegyek.muveszetekvolgye.hu/api')
abstract class TicketsApiClient {
  factory TicketsApiClient(Dio dio, {String baseUrl}) = _TicketsApiClient;

  @GET('/products')
  Future<ProductsResponse> getProducts(@Query('l') String language);
}
