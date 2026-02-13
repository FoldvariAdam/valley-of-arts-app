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
    return AppCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (program.displayUrl.isNotEmpty)
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
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
            padding: EdgeInsets.all(compact ? 12 : 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  program.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: compact ? 16 : 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (!compact) ...[
                  const SizedBox(height: 6),
                  Text(
                    program.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      program.startTime.toFullDateTimeString(),
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.place, size: 14),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        program.locationName,
                        style: const TextStyle(fontSize: 12),
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
