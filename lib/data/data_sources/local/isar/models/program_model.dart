
import 'package:isar_community/isar.dart';
import 'package:valley_of_arts/domain/programs/models/models.dart';

part 'program_model.g.dart';

@collection
class ProgramModel {
  Id id = Isar.autoIncrement;

  late String name;
  late String description;
  late DateTime startTime;
  late DateTime endTime;
  late String locationName;
  late String displayUrl;
  late String category;

  ProgramModel();

  ProgramModel.fromDomain(Program program)
      : name = program.name,
        description = program.description,
        startTime = program.startTime,
        endTime = program.endTime,
        locationName = program.locationName,
        displayUrl = program.displayUrl,
        category = program.category;

  Program toDomain() => Program(
    name: name,
    description: description,
    startTime: startTime,
    endTime: endTime,
    locationName: locationName,
    displayUrl: displayUrl,
    category: category,
  );
}
