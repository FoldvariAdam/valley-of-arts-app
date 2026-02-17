import 'package:injectable/injectable.dart';
import 'package:valley_of_arts/data/repositories/favorites/favorites_repository.dart';
import 'package:valley_of_arts/domain/programs/models/models.dart';

@lazySingleton
class ToggleFavoriteUseCase {
  final FavoritesRepository _repository;

  ToggleFavoriteUseCase(this._repository);

  Future<void> execute({
    required Program program,
    required bool isFavorite,
  }) async {
    if (isFavorite) {
      await _repository.addFavorite(program);
    } else {
      await _repository.deleteFavorite(program.id);
    }
  }
}
