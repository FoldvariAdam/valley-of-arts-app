import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valley_of_arts/core/core.dart';
import 'package:valley_of_arts/domain/programs_filter/models/models.dart';
import 'package:valley_of_arts/presentation/presentation.dart';

class LocationPanel extends StatelessWidget {
  final Location location;
  final VoidCallback onClose;

  const LocationPanel({
    super.key,
    required this.location,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.place, color: appTheme.foregroundColor, size: 24),

              SizedBox(width: appTheme.s1),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      location.name,
                      style: appTheme.smallHeadLine,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: appTheme.s0),

          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 16),
                      SizedBox(width: appTheme.s0),
                      Text(
                        'Következő program:',
                        style: appTheme.bodyText.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: appTheme.s0),

                  BlocBuilder<LocationCarouselBloc, LocationCarouselState>(
                    builder: (context, state) {
                      if (state is! LocationCarouselProgramLoadedState) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Jelenleg nincs következő program',
                              style: appTheme.bodyText.copyWith(
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        );
                      }

                      final program = state.program;

                      final dateTimeRange = DateTimeRange(
                        start: program.startTime,
                        end: program.endTime,
                      );

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            program.name,
                            style: appTheme.smallHeadLine,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),

                          SizedBox(height: appTheme.s0),

                          Text(
                            dateTimeRange.timeRange,
                            style: appTheme.bodyText.copyWith(
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: appTheme.s0),

          AppButton(
            height: 40,
            width: double.infinity,
            text: 'Részletek megtekintése',
            onPressed: () {
              NavigationService.of(
                context,
              ).goToLocationDetailsPage(location: location);
            },
          ),
        ],
      ),
    );
  }
}
