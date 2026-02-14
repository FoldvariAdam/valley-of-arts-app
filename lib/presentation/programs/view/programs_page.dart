import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:valley_of_arts/core/core.dart';
import 'package:valley_of_arts/domain/domain.dart';
import 'package:valley_of_arts/presentation/presentation.dart';

class ProgramsPage extends StatelessWidget {
  const ProgramsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetIt.instance.get<ProgramsBloc>()..add(const ProgramsStarted()),
      child: const _ProgramsPageInner(),
    );
  }
}

class _ProgramsPageInner extends StatefulWidget {
  const _ProgramsPageInner();

  @override
  State<_ProgramsPageInner> createState() => _ProgramsPageInnerState();
}

class _ProgramsPageInnerState extends State<_ProgramsPageInner> {
  String? _selectedDate;
  List<int>? _selectedCategories;
  int? _selectedLocation;
  bool _filtersExpanded = true;

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return SingleChildScrollView(
      padding: EdgeInsets.all(appTheme.s2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(
            title: 'Programok',
            subtitle: 'Szűrj hely, időpont és kategória alapján',
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    _filtersExpanded = !_filtersExpanded;
                  });
                },
                icon: Icon(
                  _filtersExpanded ? Icons.expand_less : Icons.expand_more,
                ),
                label: Text(
                  _filtersExpanded ? 'Szűrők bezárása' : 'Szűrők megnyitása',
                ),
              ),
            ],
          ),

          SizedBox(height: appTheme.s2),

          BlocBuilder<ProgramsBloc, ProgramsState>(
            buildWhen: (prev, curr) => curr is ProgramsFiltersLoaded,
            builder: (context, state) {
              if (state is! ProgramsFiltersLoaded) {
                return const AppCircularProgressIndicator();
              }

              final schedule = state.schedule;
              final categories = state.categories;
              final locations = state.locations;

              final currentSelectedCategories =
              (_selectedCategories == null || _selectedCategories!.isEmpty)
                  ? <String?>[null]
                  : _selectedCategories!
                  .map((category) => category.toString())
                  .toList();

              return AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: _filtersExpanded
                    ? Column(
                        children: [
                          const SectionTitle(
                            icon: Icons.calendar_today,
                            title: 'Dátum',
                          ),
                          SizedBox(height: appTheme.s1),
                          AppFilterChipGroup<DateTime>(
                            selectedIds: [_selectedDate],
                            items: schedule.dates,
                            idOf: (s) => s.toBackendDateQuery(),
                            labelOf: (s) => s.toShortMonthString(),
                            onChanged: (ids) {
                              _selectedDate = ids.first;
                              _filterPrograms(context: context);
                            },
                          ),

                          SizedBox(height: appTheme.s2),

                          const SectionTitle(
                            icon: Icons.filter_alt,
                            title: 'Kategória',
                          ),
                          SizedBox(height: appTheme.s1),
                          AppFilterChipGroup<Category>(
                            selectedIds: currentSelectedCategories,
                            items: categories,
                            multi: true,
                            idOf: (c) => c.id.toString(),
                            labelOf: (c) => c.name,
                            onChanged: (ids) {
                              _selectedCategories = ids.first == null
                                  ? []
                                  : ids.map((e) => int.parse(e!)).toList();

                              _filterPrograms(context: context);
                            },
                          ),

                          SizedBox(height: appTheme.s2),

                          const SectionTitle(
                            icon: Icons.location_city,
                            title: 'Helyszín',
                          ),
                          SizedBox(height: appTheme.s1),

                          Row(
                            children: [
                              SizedBox(width: appTheme.s1),
                              Expanded(
                                child: Text(
                                  'A város szűrő csak a helyszínlistát szűkíti – a programok a kiválasztott helyszín alapján frissülnek.',
                                  style: appTheme.descriptionText,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: appTheme.s2),

                          CityLocationFilter(
                            selectedLocation: _selectedLocation,
                            cities: locations,
                            onLocationChanged: (location) {
                              _selectedLocation = location;
                              _filterPrograms(context: context);
                            },
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              );
            },
          ),

          SizedBox(height: appTheme.s3),

          BlocBuilder<ProgramsBloc, ProgramsState>(
            builder: (context, state) {
              if (state is ProgramsLoading) {
                return const AppCircularProgressIndicator();
              }

              if (state is ProgramsWithDataState) {
                final programs = state.programs;

                if (programs.isEmpty) {
                  return _EmptyState();
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${programs.length} program',
                      style: appTheme.bodyText,
                    ),
                    SizedBox(height: appTheme.s3),
                    AnimatedListView<Program>(
                      items: programs,
                      spacing: appTheme.s1,
                      itemBuilder: (context, program, index) {
                        return ProgramCard(
                          program: program,
                          onToggleFavorite: (_) {},
                          onTap: NavigationService.of(
                            context,
                          ).goToProgramDetailsPage,
                          compact: true,
                        );
                      },
                    ),
                  ],
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  void _filterPrograms({required BuildContext context}) =>
      context.read<ProgramsBloc>().add(
        ProgramsFilterChanged(
          date: _selectedDate,
          categories: _selectedCategories,
          location: _selectedLocation,
        ),
      );
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: appTheme.mutedColor,
                shape: BoxShape.circle,
                border: Border.all(color: appTheme.borderColor),
              ),
              child: Icon(
                Icons.filter_alt,
                size: 36,
                color: appTheme.mutedForegroundColor,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'Nincs találat',
              style: TextStyle(
                color: appTheme.foregroundColor,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Próbálj más szűrőbeállításokat',
              style: TextStyle(
                color: appTheme.mutedForegroundColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
