// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:isar_community/isar.dart' as _i214;
import 'package:valley_of_arts/core/configs/app_config.dart' as _i876;
import 'package:valley_of_arts/core/controllers/nav_bar_controller.dart'
    as _i407;
import 'package:valley_of_arts/core/di/modules/app_module.dart' as _i265;
import 'package:valley_of_arts/core/di/modules/database_module.dart' as _i281;
import 'package:valley_of_arts/core/di/network_module.dart' as _i54;
import 'package:valley_of_arts/data/data.dart' as _i477;
import 'package:valley_of_arts/data/data_sources/local/isar/favorites_local_data_source.dart'
    as _i331;
import 'package:valley_of_arts/data/data_sources/local/isar/isar.dart' as _i534;
import 'package:valley_of_arts/data/data_sources/remote/valley/apis/valley_api_client.dart'
    as _i900;
import 'package:valley_of_arts/data/repositories/favorites/favorites_repository.dart'
    as _i1047;
import 'package:valley_of_arts/data/repositories/favorites/favorites_repository_impl.dart'
    as _i404;
import 'package:valley_of_arts/data/repositories/programs/programs_repository.dart'
    as _i930;
import 'package:valley_of_arts/data/repositories/programs/programs_repository_impl.dart'
    as _i629;
import 'package:valley_of_arts/data/repositories/programs_filter/programs_filters_repository.dart'
    as _i476;
import 'package:valley_of_arts/data/repositories/programs_filter/programs_filters_repository_impl.dart'
    as _i576;
import 'package:valley_of_arts/data/repositories/repositories.dart' as _i809;
import 'package:valley_of_arts/domain/domain.dart' as _i439;
import 'package:valley_of_arts/domain/programs/use_cases/toggle_favorite_use_case.dart'
    as _i103;
import 'package:valley_of_arts/domain/programs_filter/programs_filter.dart'
    as _i727;
import 'package:valley_of_arts/domain/programs_filter/use_cases/get_locations_grouped_by_village_use_case.dart'
    as _i51;
import 'package:valley_of_arts/presentation/favorites/blocs/favorites_bloc.dart'
    as _i250;
import 'package:valley_of_arts/presentation/home/blocs/home_bloc.dart' as _i59;
import 'package:valley_of_arts/presentation/map/blocs/map_bloc.dart' as _i825;
import 'package:valley_of_arts/presentation/programs/blocs/programs_bloc.dart'
    as _i791;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    final registerDatabase = _$RegisterDatabase();
    final networkModule = _$NetworkModule();
    gh.lazySingleton<_i407.NavBarController>(() => _i407.NavBarController());
    gh.lazySingleton<_i876.AppConfig>(() => appModule.appConfig);
    await gh.lazySingletonAsync<_i214.Isar>(
      () => registerDatabase.provideIsar(),
      preResolve: true,
    );
    gh.lazySingleton<_i361.Dio>(() => networkModule.dio());
    gh.lazySingleton<_i900.ValleyApiClient>(
      () => networkModule.valleyApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i476.ProgramsFiltersRepository>(
      () => _i576.ProgramsFilterRepositoryImpl(gh<_i900.ValleyApiClient>()),
    );
    gh.lazySingleton<_i331.FavoritesLocalDataSource>(
      () => _i331.FavoritesLocalDataSource(gh<_i214.Isar>()),
    );
    gh.factory<_i51.GetLocationsGroupedByVillageUseCase>(
      () => _i51.GetLocationsGroupedByVillageUseCase(
        gh<_i476.ProgramsFiltersRepository>(),
      ),
    );
    gh.lazySingleton<_i1047.FavoritesRepository>(
      () => _i404.FavoritesRepositoryImpl(gh<_i534.FavoritesLocalDataSource>()),
    );
    gh.factory<_i250.FavoritesBloc>(
      () => _i250.FavoritesBloc(gh<_i1047.FavoritesRepository>()),
    );
    gh.lazySingleton<_i103.ToggleFavoriteUseCase>(
      () => _i103.ToggleFavoriteUseCase(gh<_i1047.FavoritesRepository>()),
    );
    gh.lazySingleton<_i930.ProgramsRepository>(
      () => _i629.ProgramsRepositoryImpl(
        gh<_i900.ValleyApiClient>(),
        gh<_i1047.FavoritesRepository>(),
      ),
    );
    gh.factory<_i791.ProgramsBloc>(
      () => _i791.ProgramsBloc(
        gh<_i809.ProgramsRepository>(),
        gh<_i809.ProgramsFiltersRepository>(),
        gh<_i439.GetLocationsGroupedByVillageUseCase>(),
      ),
    );
    gh.factory<_i59.HomeBloc>(
      () => _i59.HomeBloc(gh<_i930.ProgramsRepository>()),
    );
    gh.factory<_i825.MapBloc>(
      () => _i825.MapBloc(
        gh<_i477.ProgramsRepository>(),
        gh<_i727.GetLocationsGroupedByVillageUseCase>(),
      ),
    );
    return this;
  }
}

class _$AppModule extends _i265.AppModule {}

class _$RegisterDatabase extends _i281.RegisterDatabase {}

class _$NetworkModule extends _i54.NetworkModule {}
