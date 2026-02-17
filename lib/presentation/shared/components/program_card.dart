import 'package:flutter/material.dart';
import 'package:valley_of_arts/core/core.dart';
import 'package:valley_of_arts/domain/programs/models/models.dart';
import 'package:valley_of_arts/presentation/shared/components/components.dart';

class ProgramCard extends StatelessWidget {
  final Program program;
  final bool compact;
  final VoidCallback? onTap;
  final bool showIsFavorite;

  const ProgramCard({
    super.key,
    required this.program,
    this.compact = false,
    this.onTap,
    this.showIsFavorite = true,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return AppCard(
      onTap: onTap,
      style: const AppCardTheme(padding: 0),
      child: Stack(
        children: [
          Column(
            children: [
              if (program.displayUrl.isNotEmpty) ...[
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(appTheme.s3),
                    ),
                    child: CachedProgramImage(imageUrl: program.displayUrl),
                  ),
                ),
              ],

              Padding(
                padding: EdgeInsets.all(appTheme.s3),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      program.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: appTheme.smallHeadLine,
                    ),

                    if (!compact && program.description.isNotEmpty) ...[
                      SizedBox(height: appTheme.s0),
                      Text(
                        program.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: appTheme.descriptionText,
                      ),
                    ],

                    SizedBox(height: appTheme.s1),

                    Row(
                      children: [
                        Icon(Icons.access_time, size: appTheme.s2),
                        SizedBox(width: appTheme.s0),
                        Expanded(
                          child: Text(
                            program.startTime.toFullDateTimeString(),
                            style: appTheme.metaText,
                          ),
                        ),
                        Icon(Icons.place, size: appTheme.s2),
                        SizedBox(width: appTheme.s0),
                        Expanded(
                          child: Text(
                            program.locationName,
                            style: appTheme.metaText,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          if (program.isFavorite && showIsFavorite)
            Positioned(
              right: 10,
              top: 10,
              child: Container(
                padding: EdgeInsets.all(appTheme.s1),
                decoration: BoxDecoration(
                  color: program.isFavorite
                      ? appTheme.secondaryColor.withValues(alpha: 0.8)
                      : Colors.white.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 15,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
