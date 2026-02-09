import 'package:flutter/material.dart';
import 'package:valley_of_arts/core/core.dart';

class ScrollToTopButton extends StatelessWidget {
  final bool visible;
  final VoidCallback onPressed;

  const ScrollToTopButton({
    super.key,
    required this.visible,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: visible ? 1 : 0,
      child: IgnorePointer(
        ignoring: !visible,
        child: Center(
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(30),
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: appTheme.cardBackgroundColor,
                shape: BoxShape.circle,
                boxShadow: [
                  const BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(
                Icons.keyboard_arrow_up,
                color: appTheme.foregroundColor,
                size: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
