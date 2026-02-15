import 'package:flutter/material.dart';
import 'package:valley_of_arts/core/core.dart';

class AppCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final AppCardTheme? style;

  const AppCard({super.key, required this.child, this.onTap, this.style});

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  bool _pressed = false;

  bool get _isInteractive => widget.onTap != null;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final baseTheme = AppCardTheme.of(context);
    final cardTheme = widget.style != null
        ? baseTheme.merge(widget.style)
        : baseTheme;

    _controller = AnimationController(
      vsync: this,
      duration: cardTheme.animationDuration,
    );

    _scale = Tween(
      begin: 1.0,
      end: cardTheme.pressedScale,
    ).animate(CurvedAnimation(parent: _controller, curve: cardTheme.curve!));
  }

  @override
  Widget build(BuildContext context) {
    final baseTheme = context.appCardTheme;
    final appCardTheme = baseTheme.merge(widget.style);

    final bg = _pressed
        ? appCardTheme.pressedBackgroundColor!
        : appCardTheme.backgroundColor!;

    final border = _pressed
        ? appCardTheme.pressedBorderColor!
        : appCardTheme.borderColor!;

    Widget cardContent = AnimatedContainer(
      duration: appCardTheme.animationDuration!,
      curve: appCardTheme.curve!,
      decoration: BoxDecoration(
        color: _isInteractive ? bg : appCardTheme.backgroundColor,
        borderRadius: appCardTheme.borderRadius,
        border: Border.all(
          color: _isInteractive ? border : appCardTheme.borderColor!,
          width: appCardTheme.borderWidth!,
        ),
        boxShadow: [
          BoxShadow(
            color: appCardTheme.shadowColor!.withValues(
              alpha: _pressed ? 0.18 : 0.10,
            ),
            blurRadius: _pressed
                ? appCardTheme.pressedBlurRadius!
                : appCardTheme.blurRadius!,
            offset: appCardTheme.shadowOffset!,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(appCardTheme.padding!),
        child: widget.child,
      ),
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

    return Padding(
      padding: EdgeInsets.all(
         appCardTheme.margin!,
      ),
      child: cardContent,
    );
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
}
