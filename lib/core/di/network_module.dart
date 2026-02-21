import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:valley_of_arts/data/data.dart';
import 'package:valley_of_arts/data/data_sources/remote/valley/apis/valley/valley_api_client.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio dio() {
    final dio = Dio();

    dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    );

    return dio;
  }

  @lazySingleton
  ValleyApiClient valleyApiClient(Dio dio) => ValleyApiClient(dio);

  @lazySingleton
  TicketsApiClient ticketsApiClient(Dio dio) => TicketsApiClient(dio);
}
