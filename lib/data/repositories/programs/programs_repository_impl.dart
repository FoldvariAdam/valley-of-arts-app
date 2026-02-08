import 'package:injectable/injectable.dart';
import 'package:valley_of_arts/data/data_sources/remote/valley/apis/valley_api_client.dart';
import 'package:valley_of_arts/data/repositories/programs/programs_repository.dart';

@LazySingleton(as: ProgramsRepository)
class ProgramsRepositoryImpl implements ProgramsRepository {
  ProgramsRepositoryImpl({required ValleyApiClient valleyApiClient})
    : _valleyApiClient = valleyApiClient;

  final ValleyApiClient _valleyApiClient;

  @override
  Future<void> getPrograms({
    List<int>? categoryIds,
    String? date,
    int? locationId,
    String? time,
    bool? onlyPinned,
    int? page,
    int? perPage,
  }) async {
    final programs = await _valleyApiClient.getPrograms();

    print('assd');
  }
}
