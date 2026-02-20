import 'package:isar_community/isar.dart';
import 'package:valley_of_arts/domain/programs/models/models.dart';

part 'program_model.g.dart';

@collection
class ProgramModel {
  Id id = Isar.autoIncrement;

  @Index()
  late int programId;
  late String name;
  late String description;
  late DateTime startTime;
  late DateTime endTime;
  late String locationName;
  late String displayUrl;
  late String category;
  late bool isFavorite;
  late int locationId;

  ProgramModel();

  /// TODO ezeknek biztos itt a helye?

  ProgramModel.fromDomain(Program program)
    : programId = program.id,
      name = program.name,
      description = program.description,
      startTime = program.startTime,
      endTime = program.endTime,
      locationName = program.locationName,
      displayUrl = program.displayUrl,
      category = program.category,
      isFavorite = program.isFavorite,
      locationId = program.locationId;

  Program toDomain() => Program(
    id: programId,
    name: name,
    description: description,
    startTime: startTime,
    endTime: endTime,
    locationName: locationName,
    displayUrl: displayUrl,
    category: category,
    isFavorite: isFavorite,
    locationId: locationId,
  );
}
