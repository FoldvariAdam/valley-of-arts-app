import 'package:flutter/material.dart';
import 'package:valley_of_arts/core/core.dart';
import 'package:valley_of_arts/domain/programs/models/models.dart';
import 'package:valley_of_arts/domain/programs_filter/models/models.dart';
import 'package:valley_of_arts/presentation/presentation.dart';

class LocationPanel extends StatelessWidget {
  final Location location;
  final Program? nextProgram;

  final VoidCallback onClose;

  const LocationPanel({
    super.key,
    required this.location,
    required this.nextProgram,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return SizedBox(
      width: 300,
      child: AppCard(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.place, color: Colors.red, size: 26),
                ),
                SizedBox(width: appTheme.s1),
                Expanded(
                  child: Text(
                    location.name,
                    style: appTheme.smallHeadLine,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                GlassIconButton(icon: Icons.close, onTap: onClose),
              ],
            ),
            SizedBox(height: appTheme.s1,),
            AppButton(text: 'Részletek megtekintése', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
