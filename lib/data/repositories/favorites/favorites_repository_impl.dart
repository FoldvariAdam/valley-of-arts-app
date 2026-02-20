import 'package:injectable/injectable.dart';
import 'package:valley_of_arts/data/data_sources/local/isar/isar.dart';
import 'package:valley_of_arts/data/repositories/favorites/favorites_repository.dart';
import 'package:valley_of_arts/domain/programs/models/models.dart';

@LazySingleton(as: FavoritesRepository)
class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesLocalDataSource _dataSource;

  FavoritesRepositoryImpl(this._dataSource);

  @override
  Future<List<Program>> getFavorites() async {
    final favoritePrograms = await _dataSource.getAll();
    return favoritePrograms.map((program) => program.toDomain()).toList();
  }

  @override
  Future<void> deleteFavorite(int id) async {
    await _dataSource.deleteFavorite(id);
  }

  @override
  Future<void> clearAllFavorites() => _dataSource.deleteAll();

  @override
  Future<int> getFavoritesCount() => _dataSource.count();

  @override
  Future<void> addFavorite(Program program) =>
      _dataSource.save(ProgramModel.fromDomain(program));

  @override
  bool isFavorite(int id) => _dataSource.isFavorite(id);

  @override
  Stream<List<int>> watchFavoriteIds({bool fireImmediately = true}) {
    return _dataSource
        .watchAll(fireImmediately: true)
        .map((programModels) => programModels.map((e) => e.programId).toList());
  }
}
