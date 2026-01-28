import 'package:flutter/material.dart';
import 'package:valley_of_arts/core/themes/app_theme_factory.dart';

class BottomBarItem {
  final String route;
  final IconData icon;
  final String label;

  const BottomBarItem({
    required this.route,
    required this.icon,
    required this.label,
  });
}

class BottomBar extends StatelessWidget {
  final String currentRoute;
  final ValueChanged<String> onNavigate;

  const BottomBar({
    super.key,
    required this.currentRoute,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    final items = <BottomBarItem>[
      const BottomBarItem(
        route: '/',
        icon: Icons.home_filled,
        label: 'Kezdőlap',
      ),
      const BottomBarItem(
        route: '/events',
        icon: Icons.event,
        label: 'Események',
      ),
      const BottomBarItem(route: '/map', icon: Icons.map, label: 'Térkép'),
      const BottomBarItem(
        route: '/csigabusz',
        icon: Icons.directions_bus,
        label: 'Csigabusz',
      ),
      const BottomBarItem(
        route: '/settings',
        icon: Icons.settings,
        label: 'Beállítások',
      ),
    ];

    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: appTheme.cardColor,
          border: Border(top: BorderSide(color: appTheme.borderColor)),
        ),
        child: SizedBox(
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.map((item) {
              final isActive = currentRoute == item.route;

              return _BottomNavButton(
                item: item,
                isActive: isActive,
                onTap: () => onNavigate(item.route),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _BottomNavButton extends StatefulWidget {
  final BottomBarItem item;
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
              /// Active background (layoutId feeling)
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: widget.isActive ? 1 : 0,
                child: Container(
                  width: 56,
                  height: 48,
                  decoration: BoxDecoration(
                    color: appTheme.accentColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),

              /// Icon + label
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    widget.item.icon,
                    size: 20,
                    color: widget.isActive
                        ? appTheme.accentColor
                        : appTheme.mutedForegroundColor,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.item.label,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: widget.isActive
                          ? appTheme.accentColor
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
