import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:valley_of_arts/core/core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await configureDependencies();

  runApp(
    EasyLocalization(
      supportedLocales: [const Locale('en'), const Locale('hu')],
      path: 'assets/translations',
      fallbackLocale: const Locale('hu'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = createRouterConfig(
    initialLocation: NavigationRoute.home.fullPath,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: AppThemeFactory.create(),
    );
  }
}