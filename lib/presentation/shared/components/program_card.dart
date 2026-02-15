import 'package:flutter/material.dart';
import 'package:valley_of_arts/core/core.dart';
import 'package:valley_of_arts/domain/programs/models/models.dart';
import 'package:valley_of_arts/presentation/shared/components/components.dart';

class ProgramCard extends StatelessWidget {
  final Program program;
  final bool compact;
  final VoidCallback? onTap;
  final Function(String id) onToggleFavorite;

  const ProgramCard({
    super.key,
    required this.program,
    required this.onToggleFavorite,
    this.compact = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return AppCard(
      onTap: onTap,
      style: const AppCardTheme(padding: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (program.displayUrl.isNotEmpty)
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(appTheme.s3),
                  ),
                  child: Image.network(
                    program.displayUrl,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
                /*Positioned(
                      right: 10,
                      top: 10,
                      child: _favoriteButton(),
                    )*/
              ],
            ),
          Padding(
            padding: EdgeInsets.all(appTheme.s3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  program.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: appTheme.smallHeadLine
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

                    Text(
                      program.startTime.toFullDateTimeString(),
                      style: appTheme.metaText,
                    ),

                    SizedBox(width: appTheme.s1),

                    Icon(Icons.place, size: appTheme.s2),

                    SizedBox(width: appTheme.s0),

                    Expanded(
                      child: Text(
                        program.locationName,
                        style: appTheme.metaText,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /*  Widget _favoriteButton() {
    return GestureDetector(
      onTap: () {
        setState(() => widget.program.isFavorite = !widget.program.isFavorite);
        widget.onToggleFavorite(widget.program.id);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: widget.program.isFavorite
              ? Colors.red.withOpacity(.8)
              : Colors.black.withOpacity(.3),
          shape: BoxShape.circle,
        ),
        child: Icon(
          widget.program.isFavorite ? Icons.favorite : Icons.favorite_border,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }*/
}
