import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:valley_of_arts/domain/programs/models/models.dart';
import 'package:valley_of_arts/domain/programs_filter/models/models.dart';

enum NavigationRoute {
  favorites(shouldCloseBottomBar: true),
  home(),
  locationDetails(shouldCloseBottomBar: true),
  map(),
  programs(),
  programDetails(shouldCloseBottomBar: true),
  schedule(),
  settings();

  final bool shouldCloseBottomBar;

  final String? _customPath;

  const NavigationRoute({String? customPath, this.shouldCloseBottomBar = false})
    : _customPath = customPath;

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

  void goToPageWithRouteParam({
    bool withoutStacking = true,
    required NavigationRoute route,
  }) {
    _goToPageImpl(
      context: context,
      route: route,
      withoutStacking: withoutStacking,
    );
  }

  void goToFavoritesPage() {
    _goToPageImpl(context: context, route: NavigationRoute.favorites);
  }

  void goToHomePage() {
    _goToPageImpl(
      context: context,
      route: NavigationRoute.home,
      withoutStacking: true,
    );
  }

  void goToLocationDetailsPage({required Location location}) {
    _goToPageImpl(
      context: context,
      route: NavigationRoute.programDetails,
      extra: {'location': location},
    );
  }

  void goToMapPage({bool withoutStacking = true}) {
    _goToPageImpl(
      context: context,
      route: NavigationRoute.map,
      withoutStacking: withoutStacking,
    );
  }

  void goToProgramsPage() {
    _goToPageImpl(
      context: context,
      route: NavigationRoute.programs,
      withoutStacking: true,
    );
  }

  void goToProgramDetailsPage({required Program program}) {
    _goToPageImpl(
      context: context,
      route: NavigationRoute.programDetails,
      extra: {'program': program},
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
