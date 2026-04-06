import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:valley_of_arts/core/core.dart';
import 'package:valley_of_arts/generated/locale_keys.g.dart';
import 'package:valley_of_arts/presentation/presentation.dart';

class FavoritesCard extends StatelessWidget {
  final int favoritesLength;

  const FavoritesCard({super.key, required this.favoritesLength});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Entrance(
      fromY: 20,
      delayMs: 0,
      child: AppCard(
        onTap: NavigationService.of(context).goToFavoritesPage,
        child: ChevronRow(
          leadingIcon: Icon(Icons.favorite, color: appTheme.primaryColor),
          title: LocaleKeys.Home_Favorites.tr(),
          subtitle: LocaleKeys.Home_FavoritesDescription.tr(args: [favoritesLength.toString()]),
        ),
      ),
    );
  }
}
