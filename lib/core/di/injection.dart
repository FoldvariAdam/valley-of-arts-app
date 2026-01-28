import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:valley_of_arts/core/di/injection.config.dart';

@injectableInit
void configureDependencies() => GetIt.instance.init();