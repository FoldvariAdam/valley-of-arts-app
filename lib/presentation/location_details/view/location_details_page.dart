import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:valley_of_arts/core/core.dart';
import 'package:valley_of_arts/domain/programs/models/models.dart';
import 'package:valley_of_arts/domain/programs_filter/models/models.dart';
import 'package:valley_of_arts/presentation/location_details/blocs/location_details_bloc.dart';
import 'package:valley_of_arts/presentation/presentation.dart';
import 'package:valley_of_arts/presentation/shared/components/cached_program_image.dart';

class LocationDetailsPage extends StatefulWidget {
  final Location location;

  const LocationDetailsPage({super.key, required this.location});

  @override
  State<LocationDetailsPage> createState() => _LocationDetailsPageState();
}

class _LocationDetailsPageState extends State<LocationDetailsPage>
    with TickerProviderStateMixin {
  late bool _isFavorite;
  String? _selectedDate;

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
    _isFavorite = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final location = widget.location;

    return BlocProvider(
      create: (context) =>
          GetIt.instance.get<LocationDetailsBloc>()
            ..add(LocationDetailsStartedEvent(locationId: location.id)),
      child: Stack(
        children: [
          CustomScrollView(
            key: const PageStorageKey('location_details_scroll'),
            slivers: [
              SliverToBoxAdapter(
                child: _HeroImage(
                  location: location,
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

                      const SectionTitle(
                        icon: Icons.calendar_today,
                        title: 'Nap választó',
                      ),

                      SizedBox(height: appTheme.s1),

                      BlocBuilder<LocationDetailsBloc, LocationDetailsState>(
                        buildWhen: (prev, curr) =>
                            curr is LocationDetailsFiltersLoadedState,
                        builder: (context, state) {
                          if (state is LocationDetailsFiltersLoadedState) {
                            return AppFilterChipGroup<DateTime>(
                              selectedIds: [_selectedDate],
                              items: state.schedule.dates,
                              idOf: (s) => s.toBackendDateQuery(),
                              labelOf: (s) => s.toShortMonthString(),
                              onChanged: (ids) {
                                _selectedDate = ids.first;
                                context.read<LocationDetailsBloc>().add(
                                  LocationDetailsFilterChangedEvent(
                                    locationId: location.id,
                                    date: _selectedDate,
                                  ),
                                );
                              },
                            );
                          }

                          return Container();
                        },
                      ),

                      SizedBox(height: appTheme.s1),

                      BlocBuilder<LocationDetailsBloc, LocationDetailsState>(
                        builder: (context, state) {
                          if (state is LocationDetailsWithDataState) {
                            final programs = state.programs;

                            if (programs.isEmpty) {
                              return const AppEmptyState(
                                title: 'Nincs találat',
                                subtitle: 'Próbálj más szűrőbeállításokat',
                              );
                            } else {
                              return AppAnimatedListView<Program>(
                                key: const PageStorageKey('location_programs'),
                                items: programs,
                                spacing: appTheme.s1,
                                itemBuilder: (context, program, index) {
                                  return ProgramCard(
                                    program: program,
                                    onTap: () => NavigationService.of(
                                      context,
                                    ).goToProgramDetailsPage(program: program),
                                  );
                                },
                              );
                            }
                          }

                          return const AppCircularProgressIndicator();
                        },
                      ),

                      SizedBox(height: 1500),

                      Text('asd'),
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
                  icon: _isFavorite ? Icons.favorite : Icons.favorite_border,
                  active: true,
                  onTap: () {
                    setState(() {
                      _isFavorite = !_isFavorite;

                      /// TODO: Need to call a use case here
                    });
                  },
                  entranceFromX: 20,
                  delayMs: 50,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroImage extends StatelessWidget {
  final Location location;
  final AppTheme appTheme;
  final Animation<double> heroScale;

  const _HeroImage({
    required this.location,
    required this.appTheme,
    required this.heroScale,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return SizedBox(
      height: 300,
      child: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedBuilder(
            animation: heroScale,
            builder: (_, _) => Transform.scale(
              scale: heroScale.value,
              child: CachedProgramImage(imageUrl: location.displayUrl),
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

          Positioned(
            left: 16,
            bottom: 16,
            child: Text(location.name, style: appTheme.mediumHeadLine),
          ),
        ],
      ),
    );
  }
}
