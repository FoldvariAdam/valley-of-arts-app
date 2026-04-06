import 'package:flutter/material.dart';
import 'package:valley_of_arts/core/core.dart';
import 'package:valley_of_arts/presentation/shared/animations/animations.dart';
import 'package:valley_of_arts/presentation/shared/components/components.dart';

class ScheduleStop {
  final String name;
  final List<String> arrivalTimes;

  const ScheduleStop({required this.name, required this.arrivalTimes});
}

const scheduleStops = <ScheduleStop>[
  ScheduleStop(
    name: 'Községház',
    arrivalTimes: [
      '09:00',
      '10:00',
      '11:00',
      '12:00',
      '13:00',
      '14:00',
      '15:00',
      '16:00',
      '17:00',
      '18:00',
      '19:00',
      '20:00',
    ],
  ),
  ScheduleStop(
    name: 'Vigándpetend központi buszmegálló',
    arrivalTimes: [
      '09:05',
      '10:05',
      '11:05',
      '12:05',
      '13:05',
      '14:05',
      '15:05',
      '16:05',
      '17:05',
      '18:05',
      '19:05',
      '20:05',
    ],
  ),
  ScheduleStop(
    name: 'Taliándörögd Klastrom kocsma / Színház színpad',
    arrivalTimes: [
      '09:15',
      '10:15',
      '11:15',
      '12:15',
      '13:15',
      '14:15',
      '15:15',
      '16:15',
      '17:15',
      '18:15',
      '19:15',
      '20:15',
    ],
  ),
  ScheduleStop(
    name: 'Benzinkút',
    arrivalTimes: [
      '09:20',
      '10:20',
      '11:20',
      '12:20',
      '13:20',
      '14:20',
      '15:20',
      '16:20',
      '17:20',
      '18:20',
      '19:20',
      '20:20',
    ],
  ),
];

String? getNextDeparture(List<String> times, DateTime now) {
  final current =
      '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  for (final t in times) {
    if (t.compareTo(current) > 0) return t;
  }
  return null;
}

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 96),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Entrance(fromY: 20, delayMs: 0, child: _Header()),

            SizedBox(height: appTheme.s2),

            const Entrance(
              fromY: 20,
              delayMs: 100,
              child: _RouteInfoCard(
                villages: ['Monostorapáti', 'Kapolcs', 'Vigántpetend'],
              ),
            ),

            SizedBox(height: appTheme.s1),

            _ArrivalSection(stops: scheduleStops.take(2).toList()),

            SizedBox(height: appTheme.s2),

            const Entrance(
              fromY: 20,
              delayMs: 100,
              child: _RouteInfoCard(
                villages: ['Taliándörögd', 'Kapolcs', 'Taliándörögd'],
              ),
            ),

            _ArrivalSection(stops: scheduleStops.skip(2).take(2).toList()),

            Entrance(fromY: 20, delayMs: 300, child: _InfoNote()),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Row(
      children: [
        const Icon(Icons.directions_bus, size: 50),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Csigabusz Menetrend', style: appTheme.mediumHeadLine),
              const SizedBox(height: 2),
              Text(
                'Völgykarszalaggal ingyenesen vehető igénybe',
                style: appTheme.subTitle,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RouteInfoCard extends StatelessWidget {
  final List<String> villages;

  const _RouteInfoCard({required this.villages});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.access_time, size: 16),

              SizedBox(width: appTheme.s0),

              Text('Útvonal', style: appTheme.smallHeadLine),
            ],
          ),

          SizedBox(height: appTheme.s1),

          Wrap(
            spacing: 10,
            runSpacing: 10,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: _routeChips(appTheme),
          ),
        ],
      ),
    );
  }

  List<Widget> _routeChips(AppTheme appTheme) {
    final widgets = <Widget>[];
    for (var i = 0; i < villages.length; i++) {
      final v = villages[i];

      widgets.add(Text(v, style: appTheme.bodyText));

      if (i < villages.length - 1) {
        widgets.add(const Icon(Icons.arrow_right_alt, size: 18));
      }
    }
    return widgets;
  }
}

class _ArrivalSection extends StatelessWidget {
  final List<ScheduleStop> stops;

  const _ArrivalSection({required this.stops});

  @override
  Widget build(BuildContext context) {
    final vColor = Colors.red;

    return AppCard(
      style: const AppCardTheme(padding: 0),
      child: Column(
        children: List.generate(stops.length, (i) {
          final stop = stops[i];
          final isLast = i == stops.length - 1;

          return Column(
            children: [
              _StopRow(stop: stop),
              if (!isLast) const AppDivider(),
            ],
          );
        }),
      ),
    );
  }
}

class _StopRow extends StatelessWidget {
  final ScheduleStop stop;

  const _StopRow({required this.stop});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    final now = DateTime.now();
    final next = getNextDeparture(stop.arrivalTimes, now);

    return Padding(
      padding: EdgeInsets.all(appTheme.s2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.location_on, size: 16, color: appTheme.highlightColor),
              SizedBox(width: appTheme.s0),
              Expanded(child: Text(stop.name, style: appTheme.bodyText)),
              if (next != null)
                Container(
                  decoration: BoxDecoration(borderRadius: appTheme.r2xl),
                  child: Text('Következő: $next', style: appTheme.bodyText),
                ),
            ],
          ),

          SizedBox(height: appTheme.s1),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: stop.arrivalTimes.map((t) {
              final isNext = (next != null && t == next);

              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  t,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isNext ? FontWeight.w800 : FontWeight.w700,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _InfoNote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(appTheme.s2),
      child: Column(
        children: [
          const Icon(Icons.directions_bus, size: 32),
          SizedBox(height: appTheme.s1),
          Text(
            'A menetrend csak tájékoztatás jellegű!',
            style: appTheme.bodyText,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: appTheme.s1),
          Text(
            'A buszok pontos helyzetét a Térkép menüpontban tudod megnézni.',
            style: appTheme.descriptionText,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
