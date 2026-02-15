import 'package:flutter/material.dart';
import 'package:valley_of_arts/core/core.dart';
import 'package:valley_of_arts/domain/programs/models/models.dart';
import 'package:valley_of_arts/presentation/program_details/program_details.dart';
import 'package:valley_of_arts/presentation/shared/shared.dart';

class ProgramDetailsPage extends StatefulWidget {
  final Program program;

  const ProgramDetailsPage({super.key, required this.program});

  @override
  State<ProgramDetailsPage> createState() => _ProgramDetailsPageState();
}

class _ProgramDetailsPageState extends State<ProgramDetailsPage>
    with TickerProviderStateMixin {
  bool notificationEnabled = false;

  late final AnimationController _heroC = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  )..forward();

  late final Animation<double> _heroScale = Tween(
    begin: 1.10,
    end: 1.00,
  ).animate(CurvedAnimation(parent: _heroC, curve: Curves.easeOut));

  @override
  void dispose() {
    _heroC.dispose();
    super.dispose();
  }

  void _toggleNotification() {
    setState(() => notificationEnabled = !notificationEnabled);
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
              child: _hero(e: program, appTheme: appTheme),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(appTheme.s2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
              GlassIconButton(
                icon: Icons.arrow_back,
                onTap: NavigationService.of(context).goBack,
                entranceFromX: -20,
              ),

              const Spacer(),

              GlassIconButton(
                icon: notificationEnabled
                    ? Icons.notifications_active
                    : Icons.notifications_none,
                active: notificationEnabled,
                onTap: _toggleNotification,
                entranceFromX: 20,
                delayMs: 0,
              ),

              SizedBox(width: appTheme.s1),

              GlassIconButton(
                icon: true ? Icons.favorite : Icons.favorite_border,
                active: true,
                onTap: () {},
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

  Widget _hero({required Program e, required AppTheme appTheme}) {
    return SizedBox(
      height: 288,
      child: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedBuilder(
            animation: _heroScale,
            builder: (_, _) {
              return Transform.scale(
                scale: _heroScale.value,
                child: e.displayUrl.isNotEmpty
                    ? Image.network(
                        e.displayUrl,
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      )
                /// TODO: Add this everywhere in the background
                    : DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.black.withValues(alpha: 0.80),
                              Colors.black.withValues(alpha: 0.30),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
              );
            },
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

          /*Positioned(
            left: 16,
            bottom: 16,
            child: Entrance(
              delayMs: 80,
              child: _CategoryBadge(
                label: 'e.categoryLabel',
              ),
            ),
          ),*/
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
        mainAxisSize: MainAxisSize.min,
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
    final paragraphs = description.split('\n\n');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Leírás', style: appTheme.smallHeadLine),

        SizedBox(height: appTheme.s1),

        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final p in paragraphs) ...[
                Text(p, style: appTheme.bodyText),
                SizedBox(height: appTheme.s1),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
