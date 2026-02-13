import 'package:valley_of_arts/domain/programs_filter/models/models.dart';

abstract class ProgramsFiltersRepository {
  Future<Schedule> getAvailableDates();
  Future<List<Location>> getLocations();
  Future<List<Category>> getCategories();
}
