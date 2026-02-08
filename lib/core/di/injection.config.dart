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
import 'package:valley_of_arts/core/controllers/nav_bar_controller.dart'
    as _i407;
import 'package:valley_of_arts/core/di/network_module.dart' as _i54;
import 'package:valley_of_arts/data/data_sources/remote/valley/apis/valley_api_client.dart'
    as _i900;
import 'package:valley_of_arts/data/repositories/programs/programs_repository.dart'
    as _i930;
import 'package:valley_of_arts/data/repositories/programs/programs_repository_impl.dart'
    as _i629;
import 'package:valley_of_arts/presentation/home/blocs/home_bloc.dart' as _i59;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final networkModule = _$NetworkModule();
    gh.lazySingleton<_i407.NavBarController>(() => _i407.NavBarController());
    gh.lazySingleton<_i361.Dio>(() => networkModule.dio());
    gh.lazySingleton<_i900.ValleyApiClient>(
      () => networkModule.valleyApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i930.ProgramsRepository>(
      () => _i629.ProgramsRepositoryImpl(
        valleyApiClient: gh<_i900.ValleyApiClient>(),
      ),
    );
    gh.factory<_i59.HomeBloc>(
      () => _i59.HomeBloc(programRepository: gh<_i930.ProgramsRepository>()),
    );
    return this;
  }
}

class _$NetworkModule extends _i54.NetworkModule {}
