import 'package:flutter/material.dart';
import 'package:valley_of_arts/presentation/shared/animations/entrance.dart';

class AnimatedListView<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final double spacing;
  final int delayStepMs;

  const AnimatedListView({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.spacing = 8,
    this.delayStepMs = 10,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Column(
          children: [
            Entrance(
              delayMs: index * delayStepMs,
              fromX: -20,
              fromY: 0,
              child: itemBuilder(context, item, index),
            ),
            SizedBox(height: spacing),
          ],
        );
      },
    );
  }
}
