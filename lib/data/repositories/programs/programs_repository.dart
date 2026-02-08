abstract class ProgramsRepository {
  Future<void> getPrograms({
    List<int>? categoryIds,
    String? date,
    int? locationId,
    String? time,
    bool? onlyPinned,
    int? page,
    int? perPage,
  });
}
