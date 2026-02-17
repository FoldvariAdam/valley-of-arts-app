import 'package:flutter/material.dart';
import 'package:valley_of_arts/core/navigation/navigation.dart';
import 'package:valley_of_arts/presentation/shared/components/components.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassIconButton(
      icon: Icons.arrow_back,
      onTap: NavigationService.of(context).goBack,
      entranceFromX: -20,
    );
  }
}
