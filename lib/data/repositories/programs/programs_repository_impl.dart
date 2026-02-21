import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:valley_of_arts/core/exceptions/exceptions.dart';
import 'package:valley_of_arts/data/data_sources/remote/valley/apis/valley/valley_api_client.dart';
import 'package:valley_of_arts/data/repositories/favorites/favorites_repository.dart';
import 'package:valley_of_arts/data/repositories/programs/programs_repository.dart';
import 'package:valley_of_arts/domain/programs/programs.dart';

@LazySingleton(as: ProgramsRepository)
class ProgramsRepositoryImpl implements ProgramsRepository {
  final ValleyApiClient _valleyApiClient;
  final FavoritesRepository _favoritesRepository;

  ProgramsRepositoryImpl(this._valleyApiClient, this._favoritesRepository);

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

      final favorites = await _favoritesRepository.getFavorites();

      final favoriteIds = favorites.map((f) => f.id).toList();

      return programs.toDomainModel(favoriteIds);
    } catch (e) {
      if (e is DioException) {
        if (e.type == DioExceptionType.connectionError) {
          throw NetworkException();
        } else if (e.type == DioExceptionType.connectionTimeout) {

        }
        throw ServerException(e.message ?? '');
      }

      throw UnknownException();
    }
  }

  @override
  Future<int> getFavoritesLength() => _favoritesRepository.getFavoritesCount();
}
