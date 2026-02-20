import 'package:valley_of_arts/data/data.dart';
import 'package:valley_of_arts/domain/programs/models/models.dart';

extension ProgramsMapper on PaginatedProgramsResponse {
  List<Program> toDomainModel(List<int> favoriteIds) =>
      data?.map((program) => program.toDomainModel(favoriteIds)).toList() ?? [];
}

extension ProgramMapper on ProgramResponse {
  /// TODO HANDLE ALL THE PROPERTIES (Ha pl nics id akkor ne hozza létre, menjen a kövire)
  Program toDomainModel(List<int> favoriteIds) {
    final artistUrl =
        artists?.firstOrNull?.attachments?.firstOrNull?.displayUrl;
    final locationUrl = location?.attachments?.firstOrNull?.displayUrl;

    return Program(
      id: id!,
      name: name ?? '',
      description: description ?? '',
      startTime: start != null ? DateTime.parse(start!) : DateTime.now(),
      endTime: end != null ? DateTime.parse(end!) : DateTime.now(),
      locationName: location?.name ?? '',
      displayUrl: artistUrl ?? locationUrl ?? '',
      category: programCategories?.firstOrNull?.name ?? '',
      isFavorite: favoriteIds.contains(id!),
      locationId: locationId!
    );
  }
}
