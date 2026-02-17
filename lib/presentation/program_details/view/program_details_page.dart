import 'package:flutter/material.dart';
import 'package:valley_of_arts/core/core.dart';
import 'package:valley_of_arts/domain/domain.dart';
import 'package:valley_of_arts/presentation/program_details/program_details.dart';
import 'package:valley_of_arts/presentation/shared/shared.dart';

class ProgramDetailsPage extends StatefulWidget {
  final Program program;
  final ToggleFavoriteUseCase toggleFavoriteUseCase;

  const ProgramDetailsPage({
    super.key,
    required this.program,
    required this.toggleFavoriteUseCase,
  });

  @override
  State<ProgramDetailsPage> createState() => _ProgramDetailsPageState();
}

class _ProgramDetailsPageState extends State<ProgramDetailsPage>
    with TickerProviderStateMixin {
  bool _notificationEnabled = false;
  late bool _isFavorite;

  late final AnimationController _heroC = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  )..forward();

  late final Animation<double> _heroScale = Tween(
    begin: 1.10,
    end: 1.00,
  ).animate(CurvedAnimation(parent: _heroC, curve: Curves.easeOut));

  @override
  void initState() {
    _isFavorite = widget.program.isFavorite;
    super.initState();
  }

  @override
  void dispose() {
    _heroC.dispose();
    super.dispose();
  }

  void _toggleNotification() {
    setState(() => _notificationEnabled = !_notificationEnabled);
    /*FestivalToast.show(
      context,
      title: notificationEnabled ? "Értesítés beállítva!" : "Értesítés kikapcsolva",
      description: notificationEnabled ? "30 perccel az esemény előtt szólunk." : null,
    );*/
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final program = widget.program;

    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _HeroImage(
                program: program,
                appTheme: appTheme,
                heroScale: _heroScale,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(appTheme.s2),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    SizedBox(height: appTheme.s1),

                    Entrance(delayMs: 0, child: TitleCard(program: program)),

                    SizedBox(height: appTheme.s3),

                    if (program.description.isNotEmpty)
                      Entrance(
                        delayMs: 100,
                        child: _DescriptionCard(
                          description: program.description,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),

        Positioned(
          left: 16,
          right: 16,
          top: MediaQuery.of(context).padding.top + 10,
          child: Row(
            children: [
              const AppBackButton(),

              const Spacer(),

              GlassIconButton(
                icon: _notificationEnabled
                    ? Icons.notifications_active
                    : Icons.notifications_none,
                active: _notificationEnabled,
                onTap: _toggleNotification,
                entranceFromX: 20,
                delayMs: 0,
              ),

              SizedBox(width: appTheme.s1),

              GlassIconButton(
                icon: _isFavorite ? Icons.favorite : Icons.favorite_border,
                active: true,
                onTap: () {
                  setState(() {
                    _isFavorite = !_isFavorite;
                    widget.toggleFavoriteUseCase.execute(
                      program: program.copyWith(isFavorite: _isFavorite),
                      isFavorite: _isFavorite,
                    );
                  });
                },
                entranceFromX: 20,
                delayMs: 50,
              ),

              SizedBox(width: appTheme.s1),

              // Maybe once we will have this feature
              GlassIconButton(
                icon: Icons.share,
                onTap: () {},
                entranceFromX: 20,
                delayMs: 100,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HeroImage extends StatelessWidget {
  final Program program;
  final AppTheme appTheme;
  final Animation<double> heroScale;

  const _HeroImage({
    required this.program,
    required this.appTheme,
    required this.heroScale,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedBuilder(
            animation: heroScale,
            builder: (_, _) => Transform.scale(
              scale: heroScale.value,
              child: CachedProgramImage(imageUrl: program.displayUrl),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  appTheme.backgroundColor,
                  appTheme.backgroundColor.withValues(alpha: 0.60),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// TODOD: Maybe I will use it on program card
class _CategoryBadge extends StatelessWidget {
  final String label;

  const _CategoryBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return AppCard(
      child: Row(
        mainAxisSize: .min,
        children: [
          Text(
            label.toUpperCase(),
            style: TextStyle(
              color: appTheme.foregroundColor,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.1,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _DescriptionCard extends StatelessWidget {
  final String description;

  const _DescriptionCard({required this.description});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Column(
      crossAxisAlignment: .start,
      children: [
        Text('Leírás', style: appTheme.smallHeadLine),

        SizedBox(height: appTheme.s1),

        AppCard(child: Text(description, style: appTheme.bodyText)),
      ],
    );
  }
}
