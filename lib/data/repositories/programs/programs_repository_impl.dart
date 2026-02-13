import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:valley_of_arts/core/exceptions/exceptions.dart';
import 'package:valley_of_arts/data/data_sources/remote/valley/apis/valley_api_client.dart';
import 'package:valley_of_arts/data/repositories/programs/programs_repository.dart';
import 'package:valley_of_arts/domain/programs/programs.dart';

@LazySingleton(as: ProgramsRepository)
class ProgramsRepositoryImpl implements ProgramsRepository {
  final ValleyApiClient _valleyApiClient;

  ProgramsRepositoryImpl({required ValleyApiClient valleyApiClient})
    : _valleyApiClient = valleyApiClient;

  @override
  Future<List<Program>> getPrograms({
    List<int>? categoryIds,
    String? date,
    int? locationId,
    String? time,
    bool? onlyPinned,
    int? page,
    int? perPage,
  }) async {
    //https://backend.muveszetekvolgye.hu/api/v1/programs/259
    try {
      final programs = await _valleyApiClient.getPrograms(
        categoryIds: categoryIds,
        date: date,
        locationId: locationId,
        time: time,
        onlyPinned: onlyPinned,
        page: page,
        perPage: perPage,
      );

      return programs.toDomainModel();
    } catch (e) {
      if (e is DioException) {
        if (e.type == DioExceptionType.connectionError) {
          throw NetworkException();
        }
        throw ServerException(e.message ?? '');
      }

      throw UnknownException();
    }
  }

  @override
  Future<int> getFavoritesLength() async {
    await Future.delayed(const Duration(seconds: 3));

    return 4;
  }
}
