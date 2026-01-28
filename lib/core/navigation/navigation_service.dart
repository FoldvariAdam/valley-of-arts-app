import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum NavigationRoute {
  events(),
  eventDetails(),
  home(),
  map(),
  schedule(),
  settings();

  final String? _customPath;

  const NavigationRoute({String? customPath}) : _customPath = customPath;

  String get path => _customPath ?? name;
}

extension NavigationRouteX on NavigationRoute {
  String get fullPath => '/${_customPath ?? name}';
}

class NavigationService {
  final BuildContext context;

  NavigationService(this.context);

  static NavigationService of(BuildContext context) =>
      NavigationService(context);

  void goBack<T extends Object?>([T? result]) =>
      GoRouter.of(context).pop(result);

  void goToEventsPage() {
    _goToPageImpl(
      context: context,
      route: NavigationRoute.events,
      withoutStacking: true,
    );
  }

  void goToEventDetailsPage() {
    _goToPageImpl(context: context, route: NavigationRoute.eventDetails);
  }

  void goToHomePage() {
    _goToPageImpl(
      context: context,
      route: NavigationRoute.home,
      withoutStacking: true,
    );
  }

  void goToMapPage() {
    _goToPageImpl(
      context: context,
      route: NavigationRoute.map,
      withoutStacking: true,
    );
  }

  void goToSchedulePage() {
    _goToPageImpl(
      context: context,
      route: NavigationRoute.schedule,
      withoutStacking: true,
    );
  }

  void goToSettingsPage() {
    _goToPageImpl(
      context: context,
      route: NavigationRoute.settings,
      withoutStacking: true,
    );
  }

  void _goToPageImpl({
    required BuildContext context,
    required NavigationRoute route,
    Object? extra,
    Map<String, String> params = const {},
    bool? withoutStacking,
  }) {
    final routeName = route.path;

    final currentRoute = _getCurrentRoute(context);

    final newRoute = context.namedLocation(routeName, pathParameters: params);

    if (currentRoute == newRoute) {
      return;
    }

    if (withoutStacking == true) {
      context.goNamed(routeName, extra: extra, pathParameters: params);
    } else {
      context.pushNamed(routeName, extra: extra, pathParameters: params);
    }
  }

  String _getCurrentRoute(BuildContext context) {
    return GoRouterState.of(context).uri.toString();
  }
}
