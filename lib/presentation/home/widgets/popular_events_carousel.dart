import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:valley_of_arts/core/core.dart';
import 'package:valley_of_arts/domain/programs/models/models.dart';
import 'package:valley_of_arts/generated/locale_keys.g.dart';
import 'package:valley_of_arts/presentation/shared/animations/animations.dart';
import 'package:valley_of_arts/presentation/shared/components/components.dart';

class PopularEventsCarousel extends StatefulWidget {
  final List<Program> programs;

  const PopularEventsCarousel({super.key, required this.programs});

  @override
  State<PopularEventsCarousel> createState() => _PopularEventsCarouselState();
}

class _PopularEventsCarouselState extends State<PopularEventsCarousel> {
  final _controller = PageController(viewportFraction: 0.85);
  Timer? _timer;
  int _current = 0;

  late List<Program> _programs;

  @override
  void initState() {
    super.initState();
    _programs = widget.programs;
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted) return;
      final next = (_current + 1) % _programs.length;
      _controller.animateToPage(
        next,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: appTheme.s2),
          child: SectionTitle(
            icon: Icons.star,
            title: LocaleKeys.Home_Popular.tr(),
          ),
        ),

        SizedBox(height: appTheme.s1),

        SizedBox(
          height: 190,
          child: PageView.builder(
            controller: _controller,
            itemCount: _programs.length,
            onPageChanged: (i) => setState(() => _current = i),
            itemBuilder: (context, i) {
              return Entrance(
                delayMs: i * 100,
                fromScale: 0.95,
                fromY: 0,
                child: _PopularCard(
                  program: _programs[i],
                  isActive: i == _current,
                  onTap: () {},
                ),
              );
            },
          ),
        ),

        SizedBox(height: appTheme.s1),

        _Dots(
          count: _programs.length,
          current: _current,
          onTap: (i) => _controller.animateToPage(
            i,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeOut,
          ),
        ),
      ],
    );
  }
}

class _PopularCard extends StatelessWidget {
  final Program program;
  final bool isActive;
  final VoidCallback onTap;

  const _PopularCard({
    required this.program,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    final scale = isActive ? 1.0 : 0.97;

    return AnimatedScale(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      scale: scale,
      child: Padding(
        padding: EdgeInsets.only(left: appTheme.s1, right: appTheme.s1),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: GestureDetector(
            onTap: onTap,
            child: Stack(
              fit: StackFit.expand,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [appTheme.accentColor, appTheme.foregroundColor],
                    ),
                  ),
                ),

                if (program.displayUrl.isNotEmpty)
                  Image.network(program.displayUrl, fit: BoxFit.cover),

                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.80),
                        Colors.black.withOpacity(0.30),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(appTheme.s2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(program.name, style: appTheme.smallHeadLine),
                      SizedBox(height: appTheme.s1),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 14,
                            color: appTheme.foregroundColor,
                          ),
                          SizedBox(width: appTheme.s0),
                          Text(
                            program.startTime.timeZoneName,
                            style: appTheme.bodyText,
                          ),
                          SizedBox(width: appTheme.s3),
                          Icon(
                            Icons.location_on,
                            size: 14,
                            color: appTheme.foregroundColor,
                          ),
                          SizedBox(width: appTheme.s0),
                          Expanded(
                            child: Text(
                              program.locationName,
                              overflow: TextOverflow.ellipsis,
                              style: appTheme.bodyText,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  final int count;
  final int current;
  final void Function(int) onTap;

  const _Dots({
    required this.count,
    required this.current,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final active = i == current;
        return GestureDetector(
          onTap: () => onTap(i),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: EdgeInsets.symmetric(horizontal: appTheme.s0),
            height: 8,
            width: active ? 24 : 8,
            decoration: BoxDecoration(
              color: active
                  ? appTheme.accentColor
                  : appTheme.mutedForegroundColor,
              borderRadius: BorderRadius.circular(99),
            ),
          ),
        );
      }),
    );
  }
}
