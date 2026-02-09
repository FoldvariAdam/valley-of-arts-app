import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:valley_of_arts/core/navigation/navigation_service.dart';
import 'package:valley_of_arts/core/navigation/shells/shells.dart';
import 'package:valley_of_arts/presentation/presentation.dart';

GoRouter? _router;
final _appShellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'AppShellRouteNavigatorKey',
);

GoRouter createRouterConfig({required String initialLocation}) {
  _router ??= GoRouter(
    initialLocation: initialLocation,
    routes: [
      ShellRoute(
        navigatorKey: _appShellNavigatorKey,
        builder: (context, state, widget) => AppShell(child: widget),
        routes: [
          GoRoute(
            name: NavigationRoute.events.path,
            path: NavigationRoute.events.fullPath,
            builder: (context, state) => const EventsPage(),
          ),
          GoRoute(
            name: NavigationRoute.eventDetails.path,
            path: NavigationRoute.eventDetails.fullPath,
            builder: (context, state) => const EventDetailsPage(),
          ),
          GoRoute(
            name: NavigationRoute.favorites.path,
            path: NavigationRoute.favorites.fullPath,
            builder: (context, state) => const FavoritesPage(),
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

  return _router!;
}
