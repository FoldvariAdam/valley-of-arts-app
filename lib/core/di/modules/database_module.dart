import 'package:injectable/injectable.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:valley_of_arts/data/data.dart';

@module
abstract class RegisterDatabase {
  @preResolve
  @lazySingleton
  Future<Isar> provideIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    return Isar.open([ProgramModelSchema], directory: dir.path);
  }
}
