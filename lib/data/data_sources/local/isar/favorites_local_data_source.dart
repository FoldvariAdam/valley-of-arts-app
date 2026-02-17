import 'package:injectable/injectable.dart';
import 'package:isar_community/isar.dart';
import 'package:valley_of_arts/data/data.dart';

@lazySingleton
class FavoritesLocalDataSource extends IsarHelper<ProgramModel> {
  FavoritesLocalDataSource(super.isar);

  /// TODO: Change it to future?
  bool isFavorite(int programId) {
    final favorite = super.collection
        .filter()
        .programIdEqualTo(programId)
        .findFirstSync();
    return favorite != null;
  }

  Future<void> deleteFavorite(int programId) async {
    final favorite = await super.collection
        .filter()
        .programIdEqualTo(programId)
        .findFirst();
    if (favorite != null) {
      await delete(favorite.id);
    }
  }
}
