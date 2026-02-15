import 'package:flutter/material.dart';
import 'package:valley_of_arts/core/core.dart';
import 'package:valley_of_arts/domain/programs/models/models.dart';
import 'package:valley_of_arts/presentation/presentation.dart';

class TitleCard extends StatelessWidget {
  final Program program;

  const TitleCard({super.key, required this.program});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    final dateTimeRange = DateTimeRange(
      start: program.startTime,
      end: program.endTime,
    );

    return Transform.translate(
      offset: const Offset(0, -18),
      child: AppCard(
        child: Theme(
          data: Theme.of(context).copyWith(
            extensions: [
              ...Theme.of(context).extensions.values,
              AppCardTheme.of(context).copyWith(
                theme: const AppCardTheme(
                  /// TODO: Add it to the appTheme we use this at the program location filter too
                  backgroundColor: Color(0xFF3A9C95),
                  margin: 0,
                ),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(program.name, style: appTheme.mediumHeadLine),

              SizedBox(height: appTheme.s2),

              _InfoRow(
                icon: Icons.calendar_month,
                iconBg: appTheme.componentBackgroundColor,
                iconColor: appTheme.foregroundColor,
                label: 'Időpont',
                value:
                    '${program.startTime.toShortMonthString()} • ${dateTimeRange.timeRange}',
              ),

              SizedBox(height: appTheme.s1),

              _InfoRow(
                icon: Icons.category,
                iconBg: appTheme.componentBackgroundColor,
                iconColor: appTheme.foregroundColor,
                label: 'Kategória',
                value: program.category,
              ),

              SizedBox(height: appTheme.s1),

              _InfoRow(
                icon: Icons.location_on_sharp,
                iconBg: appTheme.componentBackgroundColor,
                iconColor: appTheme.foregroundColor,
                label: 'Helyszín',
                value: program.locationName,
                onTap: () => NavigationService.of(
                  context,
                ).goToMapPage(withoutStacking: false),
              ),

              SizedBox(height: appTheme.s1),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String label;
  final String value;
  final VoidCallback? onTap;

  const _InfoRow({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.label,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return AppCard(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(appTheme.s1),
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(icon, color: iconColor),
          ),
          SizedBox(width: appTheme.s1),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label.toUpperCase(), style: appTheme.metaText),

                SizedBox(height: appTheme.s0),

                Text(value, style: appTheme.bodyText),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
