import 'package:valley_of_arts/domain/programs/models/models.dart';

abstract class FavoritesRepository {
  Future<List<Program>> getFavorites();
  Future<int> getFavoritesCount();
  Future<void> deleteFavorite(int id);
  Future<void> clearAllFavorites();
  Future<void> addFavorite(Program program);
  bool isFavorite(int id);
  Stream<List<int>> watchFavoriteIds();
}
