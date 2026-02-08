import 'package:flutter/material.dart';
import 'package:valley_of_arts/core/core.dart';

class LabeledSwitch extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const LabeledSwitch({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: _TitleSubtitle(title: title, subtitle: subtitle),
              ),
              Switch(value: value, onChanged: onChanged),
            ],
          ),
        ),
      ],
    );
  }
}

class _TitleSubtitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const _TitleSubtitle({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: appTheme.bodyText
        ),
        const SizedBox(height: 2),
        Text(
          subtitle,
          style: appTheme.descriptionText
        ),
      ],
    );
  }
}
