import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:valley_of_arts/core/controllers/controllers.dart';
import 'package:valley_of_arts/core/navigation/navigation_service.dart';
import 'package:valley_of_arts/core/navigation/shells/shells.dart';
import 'package:valley_of_arts/domain/programs/models/program.dart';
import 'package:valley_of_arts/domain/programs/use_cases/use_cases.dart';
import 'package:valley_of_arts/presentation/presentation.dart';

GoRouter? _router;
final _appShellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'AppShellRouteNavigatorKey',
);

GoRouter createRouterConfig({required String initialLocation}) {
  final navBarController = GetIt.instance.get<NavBarController>();

  _router ??= GoRouter(
    initialLocation: initialLocation,
    routes: [
      ShellRoute(
        navigatorKey: _appShellNavigatorKey,
        builder: (context, state, widget) => AppShell(child: widget),
        routes: [
          GoRoute(
            name: NavigationRoute.programs.path,
            path: NavigationRoute.programs.fullPath,
            builder: (context, state) => const ProgramsPage(),
          ),
          GoRoute(
            name: NavigationRoute.programDetails.path,
            path: NavigationRoute.programDetails.fullPath,
            builder: (context, state) {
              final extras = state.extra as Map<String, Object?>;
              final program = extras['program'] as Program;

              return ProgramDetailsPage(
                program: program,
                toggleFavoriteUseCase: GetIt.instance
                    .get<ToggleFavoriteUseCase>(),
              );
            },
          ),
          GoRoute(
            name: NavigationRoute.favorites.path,
            path: NavigationRoute.favorites.fullPath,
            builder: (context, state) => const FavoritesPage(),
          ),
          GoRoute(
            name: NavigationRoute.locationDetails.path,
            path: NavigationRoute.locationDetails.fullPath,
            builder: (context, state) => const LocationDetailsPage(),
          ),
          GoRoute(
            name: NavigationRoute.home.path,
            path: NavigationRoute.home.fullPath,
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            name: NavigationRoute.map.path,
            path: NavigationRoute.map.fullPath,
            builder: (context, state) => const MapPage(),
          ),
          GoRoute(
            name: NavigationRoute.schedule.path,
            path: NavigationRoute.schedule.fullPath,
            builder: (context, state) => const SchedulePage(),
          ),
          GoRoute(
            name: NavigationRoute.settings.path,
            path: NavigationRoute.settings.fullPath,
            builder: (context, state) => const SettingsPage(),
          ),
        ],
      ),
    ],
  );

  _router!.routerDelegate.addListener(() {
    final navBarController = GetIt.instance<NavBarController>();

    final routerDelegate = _router!.routerDelegate;

    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    final String location = matchList.uri.toString();

    final matchedRoute = NavigationRoute.values.firstWhere(
          (e) => e.fullPath == location,
      orElse: () => NavigationRoute.home,
    );

    if (matchedRoute.shouldCloseBottomBar) {
      navBarController.close();
    } else {
      navBarController.open();
    }
  });

  return _router!;
}
