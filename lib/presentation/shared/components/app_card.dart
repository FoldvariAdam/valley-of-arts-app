import 'package:flutter/material.dart';
import 'package:valley_of_arts/core/core.dart';

class AppCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;

  const AppCard({super.key, required this.child, this.onTap});

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  bool _pressed = false;

  bool get _isInteractive => widget.onTap != null;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );

    _scale = Tween(
      begin: 1.0,
      end: 0.96,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(_) {
    if (!_isInteractive) return;
    _controller.forward();
    setState(() => _pressed = true);
  }

  void _onTapUp(_) {
    if (!_isInteractive) return;
    _controller.reverse();
    setState(() => _pressed = false);
  }

  void _onTapCancel() {
    if (!_isInteractive) return;
    _controller.reverse();
    setState(() => _pressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    final bg = _pressed ? appTheme.accentColor : appTheme.cardBackgroundColor;
    final border = _pressed ? appTheme.accentColor : appTheme.borderColor;

    Widget cardContent = AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: _isInteractive ? bg : appTheme.cardBackgroundColor,
        borderRadius: appTheme.r2xl,
        border: Border.all(
          color: _isInteractive ? border : appTheme.borderColor,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: _pressed ? 0.18 : 0.10),
            blurRadius: _pressed ? 22 : 16,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: widget.child,
    );

    if (_isInteractive) {
      cardContent = GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        onTap: widget.onTap,
        child: ScaleTransition(scale: _scale, child: cardContent),
      );
    }

    return cardContent;
  }
}
