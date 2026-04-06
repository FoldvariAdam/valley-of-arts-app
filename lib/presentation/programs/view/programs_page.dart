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
          GetIt.instance.get<ProgramsBloc>()..add(const ProgramsStartedEvent()),
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
  bool _isLocationsExpanded = false;

  final _datesChipController = AppFilterChipGroupController();
  final _categoriesChipController = AppFilterChipGroupController();
  final _citiesChipController = AppFilterChipGroupController();
  final _locationsChipController = AppFilterChipGroupController();

  @override
  void dispose() {
    _datesChipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Stack(
      children: [
        const ProgramsDeco(),
        SingleChildScrollView(
          padding: EdgeInsets.all(appTheme.s2),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              const PageHeader(
                title: 'Programok',
                subtitle: 'Szűrj hely, időpont és kategória alapján',
              ),

              SizedBox(height: appTheme.s1),

              const AppSearchBar(),

              SizedBox(height: appTheme.s1),

              Row(
                mainAxisAlignment: .end,
                children: [
                  AppButton.secondary(
                    icon: Icon(
                      _filtersExpanded ? Icons.expand_less : Icons.expand_more,
                    ),
                    iconPosition: AppButtonIconPosition.trailing,
                    text: _filtersExpanded
                        ? 'Szűrők bezárása'
                        : 'Szűrők megnyitása',
                    onPressed: () {
                      setState(() {
                        _filtersExpanded = !_filtersExpanded;
                      });
                    },
                  ),
                ],
              ),

              SizedBox(height: appTheme.s2),

              BlocBuilder<ProgramsBloc, ProgramsState>(
                buildWhen: (prev, curr) => curr is ProgramsFiltersLoadedState,
                builder: (context, state) {
                  if (state is! ProgramsFiltersLoadedState) {
                    return const AppCircularProgressIndicator();
                  }

                  final schedule = state.schedule;
                  final categories = state.categories;
                  final locations = state.locations;

                  final currentSelectedCategories =
                      (_selectedCategories == null ||
                          _selectedCategories!.isEmpty)
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
                                appFilterChipGroupController:
                                    _datesChipController,
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
                                appFilterChipGroupController:
                                    _categoriesChipController,
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

                              VillageLocationFilter(
                                villagesAppFilterChipGroupController:
                                    _citiesChipController,
                                locationsAppFilterChipGroupController:
                                    _locationsChipController,
                                selectedLocation: _selectedLocation,
                                isLocationsExpanded: _isLocationsExpanded,
                                villages: locations,
                                onLocationChanged: (location) {
                                  _selectedLocation = location;
                                  _filterPrograms(context: context);
                                },
                                onExpandedLocationsChanged: (value) {
                                  _isLocationsExpanded = value;
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
                  if (state is ProgramsLoadingState) {
                    return const AppCircularProgressIndicator();
                  }

                  if (state is ProgramsWithDataState) {
                    final programs = state.programs;

                    final bool hasActiveFilters =
                        _selectedDate != null ||
                        (_selectedCategories != null &&
                            _selectedCategories!.isNotEmpty) ||
                        _selectedLocation != null;

                    return Column(
                      crossAxisAlignment: .start,
                      children: [
                        Row(
                          mainAxisAlignment: .spaceBetween,
                          children: [
                            Text(
                              '${programs.length} program',
                              style: appTheme.smallHeadLine,
                            ),

                            if (hasActiveFilters)
                              AppButton.secondary(
                                text: 'Szűrők törlése',
                                onPressed: () {
                                  setState(() {});
                                  _selectedDate = null;
                                  _selectedCategories = [];
                                  _selectedLocation = null;

                                  _datesChipController.scrollToAll();
                                  _categoriesChipController.scrollToAll();
                                  _citiesChipController.scrollToAll();
                                  _locationsChipController.scrollToAll();

                                  _filterPrograms(context: context);
                                },
                              ),
                          ],
                        ),
                        SizedBox(height: appTheme.s3),
                        if (programs.isEmpty)
                          const AppEmptyState(
                            title: 'Nincs találat',
                            subtitle: 'Próbálj más szűrőbeállításokat',
                          )
                        else
                          AppAnimatedListView<Program>(
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
                          ),
                      ],
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _filterPrograms({required BuildContext context}) =>
      context.read<ProgramsBloc>().add(
        ProgramsFilterChangedEvent(
          date: _selectedDate,
          categories: _selectedCategories,
          location: _selectedLocation,
        ),
      );
}
