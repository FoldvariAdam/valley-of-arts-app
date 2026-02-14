import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:valley_of_arts/core/core.dart';
import 'package:valley_of_arts/generated/locale_keys.g.dart';

class AppBottomBarItem {
  final NavigationRoute route;
  final IconData icon;
  final String label;

  const AppBottomBarItem({
    required this.route,
    required this.icon,
    required this.label,
  });
}

class AppBottomBar extends StatefulWidget {
  const AppBottomBar({super.key});

  @override
  State<AppBottomBar> createState() => _AppBottomBarState();
}

class _AppBottomBarState extends State<AppBottomBar> {
  final NavBarController _navBarController = GetIt.instance
      .get<NavBarController>();
  NavigationRoute _currentRoute = NavigationRoute.home;

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final navigationService = NavigationService.of(context);

    return AnimatedBuilder(
      animation: _navBarController,
      builder: (context, child) {
        return AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: _navBarController.isOpen ? 64 : 0,
            child: Container(
              decoration: BoxDecoration(
                color: appTheme.componentBackgroundColor,
                border: Border(top: BorderSide(color: appTheme.borderColor)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _buildItems(navigationService, appTheme),
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildItems(
    NavigationService navigationService,
    AppTheme appTheme,
  ) {
    final items = <AppBottomBarItem>[
      AppBottomBarItem(
        route: NavigationRoute.home,
        icon: Icons.home_filled,
        label: LocaleKeys.AppBottomBar_Home.tr(),
      ),
      AppBottomBarItem(
        route: NavigationRoute.programs,
        icon: Icons.event,
        label: LocaleKeys.AppBottomBar_Events.tr(),
      ),
      AppBottomBarItem(
        route: NavigationRoute.map,
        icon: Icons.map,
        label: LocaleKeys.AppBottomBar_Map.tr(),
      ),
      AppBottomBarItem(
        route: NavigationRoute.schedule,
        icon: Icons.directions_bus,
        label: LocaleKeys.AppBottomBar_Schedule.tr(),
      ),
      AppBottomBarItem(
        route: NavigationRoute.settings,
        icon: Icons.settings,
        label: LocaleKeys.AppBottomBar_Settings.tr(),
      ),
    ];

    return items.map((item) {
      final isActive = _currentRoute == item.route;
      return _BottomNavButton(
        item: item,
        isActive: isActive,
        onTap: () {
          setState(() => _currentRoute = item.route);
          navigationService.goToPageWithRouteParam(route: item.route);
        },
      );
    }).toList();
  }
}

class _BottomNavButton extends StatefulWidget {
  final AppBottomBarItem item;
  final bool isActive;
  final VoidCallback onTap;

  const _BottomNavButton({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_BottomNavButton> createState() => _BottomNavButtonState();
}

class _BottomNavButtonState extends State<_BottomNavButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 120),
        scale: _pressed ? 0.9 : 1.0,
        child: SizedBox(
          width: 72,
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: widget.isActive ? 0.2 : 0,
                child: Container(
                  width: 72,
                  height: 50,
                  decoration: BoxDecoration(
                    color: appTheme.primaryColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),

              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    widget.item.icon,
                    size: 20,
                    color: widget.isActive
                        ? appTheme.primaryColor
                        : appTheme.mutedForegroundColor,
                  ),
                  SizedBox(height: appTheme.s0),
                  Text(
                    widget.item.label,
                    style: appTheme.descriptionText.copyWith(
                      color: widget.isActive
                          ? appTheme.primaryColor
                          : appTheme.mutedForegroundColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
