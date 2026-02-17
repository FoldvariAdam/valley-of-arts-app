import 'package:injectable/injectable.dart';
import 'package:valley_of_arts/data/data.dart';

@lazySingleton
class FavoritesLocalDataSource extends IsarHelper<ProgramModel> {
  FavoritesLocalDataSource(super.isar);
}
