import 'package:injectable/injectable.dart';
import 'package:valley_of_arts/core/configs/app_config.dart';

@module
abstract class AppModule {

  @lazySingleton
  AppConfig get appConfig => AppConfig.fromEnv();
}