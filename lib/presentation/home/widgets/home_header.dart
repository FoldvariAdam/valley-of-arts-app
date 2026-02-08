import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:valley_of_arts/core/core.dart';
import 'package:valley_of_arts/generated/locale_keys.g.dart';
import 'package:valley_of_arts/shared/animations/animations.dart';

import 'package:valley_of_arts/shared/decor/decor.dart';

class HomeHeader extends StatefulWidget {
  final Color background;
  final VoidCallback onTicketTap;

  const HomeHeader({
    super.key,
    required this.background,
    required this.onTicketTap,
  });

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..forward();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  Animation<double> _interval(
    double a,
    double b, {
    Curve curve = Curves.easeOut,
  }) {
    return CurvedAnimation(
      parent: _c,
      curve: Interval(a, b, curve: curve),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    final badgeIn = _interval(0.00, 0.35);
    final titleIn = _interval(0.08, 0.45);
    final descIn = _interval(0.16, 0.55);
    final ctaIn = _interval(0.24, 0.65);

    final circle1 = _interval(0.18, 0.55, curve: Curves.elasticOut);
    final circle2 = _interval(0.24, 0.60, curve: Curves.elasticOut);
    final circle3 = _interval(0.30, 0.66, curve: Curves.elasticOut);
    //final circle4 = _interval(0.36, 0.72, curve: Curves.elasticOut);

    final stroke1 = _interval(0.12, 0.80, curve: Curves.easeInOut);
    final stroke2 = _interval(0.30, 0.92, curve: Curves.easeInOut);
    final stroke3 = _interval(0.48, 1.00, curve: Curves.easeInOut);

    return SizedBox(
      height: 350,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedCircle(
            anim: circle1,
            left: 10,
            top: -6,
            size: 66,
            color: const Color(0xFF2EDAD3),
            opacity: 0.9,
          ),
          AnimatedCircle(
            anim: circle2,
            left: 62,
            top: 18,
            size: 30,
            color: const Color(0xFFE64A5E),
            opacity: 0.9,
          ),
          AnimatedCircle(
            anim: circle3,
            right: 18,
            top: -16,
            size: 60,
            color: const Color(0xFFF0C24B),
            opacity: 0.9,
          ),
          /*AnimatedCircle(
            anim: circle4,
            right: 16,
            bottom: 92,
            size: 42,
            color: const Color(0xFF2EDAD3),
            opacity: 0.65,
          ),*/

          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.all(appTheme.s2),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FadeSlideIn(
                            anim: badgeIn,
                            fromY: -10,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE64A5E),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: const Text(
                                '07.24 - 08.02',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: appTheme.s2),
                          FadeSlideIn(
                            anim: titleIn,
                            fromY: 20,
                            child: Text(
                              LocaleKeys.Home_Title.tr(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                height: 1.05,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          SizedBox(height: appTheme.s2),
                          FadeSlideIn(
                            anim: descIn,
                            fromY: 18,
                            child: Text(
                              LocaleKeys.Home_SubTitle.tr(),
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.62),
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(height: appTheme.s3),
                          FadeSlideIn(
                            anim: ctaIn,
                            fromY: 18,
                            child: GestureDetector(
                              onTap: widget.onTicketTap,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 28,
                                  vertical: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE64A5E),
                                  borderRadius: BorderRadius.circular(999),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(
                                        0xFFE64A5E,
                                      ).withValues(alpha: 0.35),
                                      blurRadius: 22,
                                      offset: const Offset(0, 12),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  LocaleKeys.Home_Purchase.tr(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 86,
            child: CustomPaint(
              painter: AnimatedBrushStroke(
                repaint: _c,
                t1: stroke1,
                t2: stroke2,
                t3: stroke3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
