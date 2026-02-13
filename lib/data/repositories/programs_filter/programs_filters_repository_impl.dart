import 'package:injectable/injectable.dart';
import 'package:valley_of_arts/data/data_sources/remote/valley/apis/valley_api_client.dart';
import 'package:valley_of_arts/data/repositories/programs_filter/programs_filters_repository.dart';
import 'package:valley_of_arts/domain/programs_filter/programs_filter.dart';

@LazySingleton(as: ProgramsFiltersRepository)
class ProgramsFilterRepositoryImpl implements ProgramsFiltersRepository {
  final ValleyApiClient _valleyApiClient;

  ProgramsFilterRepositoryImpl({required ValleyApiClient valleyApiClient})
    : _valleyApiClient = valleyApiClient;

  @override
  Future<Schedule> getAvailableDates() async {
    final response = await _valleyApiClient.getAvailableDates();
    return response.toDomainModel();
  }

  @override
  Future<List<Category>> getCategories() async => Category.values;

  @override
  Future<List<Location>> getLocations() async {
    final locations = await _valleyApiClient.getLocations();

    return locations.map((location) => location.toDomainModel()).toList();
  }
}
