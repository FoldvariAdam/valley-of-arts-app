import 'package:valley_of_arts/domain/programs/models/models.dart';

abstract class ProgramsRepository {
  Future<List<Program>> getPrograms({
    List<int>? categoryIds,
    String? date,
    int? locationId,
    String? time,
    bool? onlyPinned,
    int? page,
    int? perPage,
  });

  Future<int> getFavoritesLength();
}
