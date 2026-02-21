import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:valley_of_arts/core/core.dart';
import 'package:valley_of_arts/domain/programs/models/models.dart';
import 'package:valley_of_arts/generated/locale_keys.g.dart';
import 'package:valley_of_arts/presentation/favorites/blocs/favorites_bloc.dart';
import 'package:valley_of_arts/presentation/shared/components/components.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Padding(
      padding: EdgeInsets.all(appTheme.s1),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          PageHeader(
            title: LocaleKeys.Favorites_Title.tr(),
            subtitle: LocaleKeys.Favorites_SubTitle.tr(),
            showBackButton: true,
          ),

          Expanded(
            child: BlocProvider(
              create: (context) =>
                  GetIt.instance.get<FavoritesBloc>()
                    ..add(const FavoritesFetchEvent()),
              child: BlocBuilder<FavoritesBloc, FavoritesState>(
                builder: (context, state) {
                  if (state is FavoritesLoadedState) {
                    return AppAnimatedListView<Program>(
                      items: state.favoritePrograms,
                      spacing: appTheme.s1,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, program, index) {
                        return Stack(
                          clipBehavior: Clip.none,
                          children: [
                            ProgramCard(
                              program: program,
                              showIsFavorite: false,
                              onTap: () => NavigationService.of(
                                context,
                              ).goToProgramDetailsPage(program: program),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: InkWell(
                                onTap: () =>
                                    _showDeleteDialog(context, program),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: appTheme.secondaryColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 3,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.delete,
                                    size: 24,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }

                  return Container();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, Program program) {
    final appTheme = context.appTheme;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(appTheme.s2),
        ),
        title: Text(
          "Törlés megerősítése",
          style: appTheme.mediumHeadLine.copyWith(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          children: [
            Text(
              "Biztosan törölni szeretnéd a programot a kedvenceid közül?",
              style: appTheme.bodyText,
            ),
            SizedBox(height: appTheme.s2),
            Text(program.name, style: appTheme.bodyText),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text("Mégse", style: TextStyle(color: Colors.grey[600])),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<FavoritesBloc>().add(
                FavoriteDeleteEvent(program.id),
              );
            },
            style: TextButton.styleFrom(
              backgroundColor: appTheme.secondaryColor,
            ),
            child: const Text("Törlés", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
