import 'package:flutter/widgets.dart';

extension ScrollControllerExtensions on ScrollController {
  static const animationDuration = Duration(milliseconds: 300);

  void scrollToChip(GlobalKey key, {bool isVertical = false}) {
    final context = key.currentContext;
    if (context == null) return;

    final box = context.findRenderObject() as RenderBox?;
    if (box == null) return;

    final scrollBox =
        position.context.storageContext.findRenderObject() as RenderBox;

    final positionOffset = box.localToGlobal(Offset.zero, ancestor: scrollBox);
    final targetOffset = isVertical ? positionOffset.dy : positionOffset.dx;

    animateTo(
      offset + targetOffset - 8,
      duration: animationDuration,
      curve: Curves.easeInOut,
    );
  }

  void scrollToAll() =>
      animateTo(0.0, duration: animationDuration, curve: Curves.easeInOut);
}
