import 'package:valley_of_arts/data/data.dart';
import 'package:valley_of_arts/domain/programs/models/models.dart';

extension ProgramsMapper on PaginatedProgramsResponse {
  List<Program> toDomainModel() =>
      data?.map((program) => program.toDomainModel()).toList() ?? [];
}

extension ProgramMapper on ProgramResponse {
  Program toDomainModel() => Program(
    name: name ?? '',
    description: description ?? '',
    startTime: start != null ? DateTime.parse(start!) : DateTime.now(),
    endTime: end != null ? DateTime.parse(end!) : DateTime.now(),
    locationName: location?.name ?? '',
    displayUrl: artists?.firstOrNull?.attachments?.firstOrNull?.displayUrl ?? '',
    category: programCategories?.firstOrNull?.name ?? '',
  );
}

