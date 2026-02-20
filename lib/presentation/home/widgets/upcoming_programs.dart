import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:valley_of_arts/core/core.dart';
import 'package:valley_of_arts/data/repositories/favorites/favorites_repository.dart';
import 'package:valley_of_arts/domain/programs/models/models.dart';
import 'package:valley_of_arts/generated/locale_keys.g.dart';
import 'package:valley_of_arts/presentation/shared/components/components.dart';

class UpcomingPrograms extends StatelessWidget {
  final List<Program> programs;

  const UpcomingPrograms({super.key, required this.programs});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Column(
      children: [
        Row(
          children: [
            _LiveIcon(),
            SizedBox(width: appTheme.s1),
            Text(LocaleKeys.Home_Upcoming.tr(), style: appTheme.smallHeadLine),
          ],
        ),
        SizedBox(height: appTheme.s2),
        StreamBuilder<List<int>>(
          stream: GetIt.instance.get<FavoritesRepository>().watchFavoriteIds(),
          builder: (context, snapshot) {
            final favoriteIds = snapshot.data ?? [];

            return AppAnimatedListView<Program>(
              items: programs,
              spacing: appTheme.s1,
              itemBuilder: (context, program, index) {
                final updatedProgram = program.copyWith(
                  isFavorite: favoriteIds.contains(program.id),
                );

                return ProgramCard(
                  program: updatedProgram,
                  onTap: () => NavigationService.of(
                    context,
                  ).goToProgramDetailsPage(program: updatedProgram),
                  compact: true,
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class _LiveIcon extends StatefulWidget {
  @override
  State<_LiveIcon> createState() => _LiveIconState();
}

class _LiveIconState extends State<_LiveIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        const Icon(Icons.play_arrow, color: Colors.green, size: 30),
        Positioned(
          right: -1,
          top: -2,
          child: FadeTransition(
            opacity: _c.drive(
              Tween(
                begin: 0.3,
                end: 1.0,
              ).chain(CurveTween(curve: Curves.easeInOut)),
            ),
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
