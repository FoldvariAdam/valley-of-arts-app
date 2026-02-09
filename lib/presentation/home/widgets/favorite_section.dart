import 'package:flutter/material.dart';
import 'package:valley_of_arts/core/core.dart';
import 'package:valley_of_arts/domain/programs/models/models.dart';

class FavoritesSection extends StatelessWidget {
  final List<Program> favoriteEvents;

  const FavoritesSection({
    super.key,
    required this.favoriteEvents,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Padding(
      padding: EdgeInsets.all(appTheme.s3),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.favorite,
                size: 20,
                /// TODO Change this color
                color: Colors.red,
              ),
              const SizedBox(width: 8),
              Text(
                'Kedvenc események',
                style: appTheme.smallHeadLine
              ),
              const Spacer(),
              Text(
                '${favoriteEvents.length} esemény',
                  style: appTheme.descriptionText
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Empty state vs list
          if (favoriteEvents.isEmpty)
            _EmptyFavorites()
          else
            Column(
              children: [
                for (final e in favoriteEvents) ...[
                  /*EventCard(
                    event: e,
                    onToggleFavorite: onToggleFavorite,
                    variant: EventCardVariant.defaultV,
                  ),*/
                  const SizedBox(height: 12),
                ],
              ],
            ),
        ],
      ),
    );
  }
}

class _EmptyFavorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 44),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: appTheme.mutedColor,
              shape: BoxShape.circle,
              //border: Border.all(color: AppConfig.borderWith(0.6)),
            ),
            child: Icon(
              Icons.favorite_border,
              size: 34,
              color: appTheme.mutedForegroundColor,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'Még nincs kedvenc',
            /*style: TextStyle(
              color: AppConfig.foregroundColor,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),*/
          ),
          const SizedBox(height: 8),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 320),
            child: Text(
              'Böngészd az eseményeket és jelöld be a kedvenceidet a szív ikonra kattintva',
              textAlign: TextAlign.center,
              /*style: TextStyle(
                color: AppConfig.mutedForegroundColor,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                height: 1.25,
              ),*/
            ),
          ),
        ],
      ),
    );
  }
}
