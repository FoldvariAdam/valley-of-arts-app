import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:valley_of_arts/core/core.dart';
import 'package:valley_of_arts/generated/locale_keys.g.dart';
import 'package:valley_of_arts/presentation/shared/shared.dart';

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

class _HomeHeaderState extends State<HomeHeader> with TickerProviderStateMixin {
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
    final circle4 = _interval(0.36, 0.72, curve: Curves.elasticOut);

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
          AnimatedCircle(
            anim: circle4,
            right: 16,
            bottom: 92,
            size: 42,
            color: const Color(0xFF2EDAD3),
            opacity: 0.65,
          ),

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
                        crossAxisAlignment: .start,
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
                              child: Text(
                                '07.24 - 08.02',
                                style: appTheme.smallHeadLine,
                              ),
                            ),
                          ),

                          SizedBox(height: appTheme.s2),

                          FadeSlideIn(
                            anim: titleIn,
                            fromY: 20,
                            child: Text(
                              LocaleKeys.Home_Title.tr(),
                              style: appTheme.bigHeadLine,
                            ),
                          ),

                          SizedBox(height: appTheme.s2),

                          FadeSlideIn(
                            anim: descIn,
                            fromY: 18,
                            child: Text(
                              LocaleKeys.Home_SubTitle.tr(),
                              style: appTheme.subTitle,
                            ),
                          ),

                          SizedBox(height: appTheme.s2),

                          FadeSlideIn(
                            anim: ctaIn,
                            fromY: 18,
                            child: AppButton(
                              text: LocaleKeys.Home_Purchase.tr(),
                              onPressed: widget.onTicketTap,
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
}
