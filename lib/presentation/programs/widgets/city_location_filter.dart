import 'package:flutter/material.dart';
import 'package:valley_of_arts/core/core.dart';
import 'package:valley_of_arts/domain/programs_filter/models/models.dart';
import 'package:valley_of_arts/presentation/shared/components/components.dart';

class CityLocationFilter extends StatefulWidget {
  final int? selectedLocation;
  final bool isLocationsExpanded;
  final List<CityWithLocations> cities;
  final ValueChanged<int?> onLocationChanged;
  final ValueChanged<bool> onExpandedLocationsChanged;
  final AppFilterChipGroupController? citiesAppFilterChipGroupController;
  final AppFilterChipGroupController? locationsAppFilterChipGroupController;

  const CityLocationFilter({
    super.key,
    required this.cities,
    required this.onLocationChanged,
    required this.onExpandedLocationsChanged,
    this.selectedLocation,
    this.isLocationsExpanded = false,
    this.citiesAppFilterChipGroupController,
    this.locationsAppFilterChipGroupController,
  });

  @override
  State<CityLocationFilter> createState() => _CityLocationFilterState();
}

class _CityLocationFilterState extends State<CityLocationFilter> {
  final ScrollController _verticalController = ScrollController();
  final Map<String, GlobalKey> _locationKeys = {};
  final GlobalKey _allKey = GlobalKey();

  int? _selectedCityId;
  int? _selectedLocationId;
  bool _isLocationsExpanded = false;

  List<Location> get _filteredLocations {
    if (_selectedCityId == null) {
      return widget.cities.expand((c) => c.locations).toList();
    } else {
      return widget.cities
          .where((c) => _selectedCityId == c.cityId)
          .expand((c) => c.locations)
          .toList();
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedCityId = _getCityByLocationId();
    _selectedLocationId = widget.selectedLocation;
    _isLocationsExpanded = widget.isLocationsExpanded;

    if (_isLocationsExpanded) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToSelectedLocation();
      });
    }
  }

  @override
  void didUpdateWidget(covariant CityLocationFilter oldWidget) {
    super.didUpdateWidget(oldWidget);

    _selectedCityId = _getCityByLocationId();
    _selectedLocationId = widget.selectedLocation;

    if (_isLocationsExpanded) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_selectedLocationId == null) {
          _scrollToAll();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(width: appTheme.s1),
            Text('Város', style: appTheme.bodyText),
          ],
        ),

        SizedBox(height: appTheme.s1),

        AppFilterChipGroup<CityWithLocations>(
          appFilterChipGroupController: widget.citiesAppFilterChipGroupController,
          selectedIds: [
            _selectedCityId.toString() == 'null'
                ? null
                : _selectedCityId.toString(),
          ],
          items: widget.cities,
          idOf: (c) => c.cityId.toString(),
          labelOf: (c) => c.cityName,
          onChanged: (ids) {
            setState(() {
              final cityId = ids.first;
              if (cityId == null) {
                _selectedCityId = null;
                widget.onLocationChanged(null);
              } else {
                _selectedCityId = int.parse(cityId);
              }
              _selectedLocationId = null;
            });
          },
        ),

        SizedBox(height: appTheme.s1),

        Row(
          children: [
            SizedBox(width: appTheme.s1),
            Text('Helyszín', style: appTheme.bodyText),
          ],
        ),

        SizedBox(height: appTheme.s1),

        _buildLocationChips(),

        SizedBox(height: appTheme.s1),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AppButton.secondary(
              text: _isLocationsExpanded ? 'Egysoros nézet' : 'Rács nézet',
              icon: Icon(
                _isLocationsExpanded ? Icons.view_stream : Icons.grid_view,
              ),
              onPressed: () {
                setState(() {
                  _isLocationsExpanded = !_isLocationsExpanded;
                  widget.onExpandedLocationsChanged(_isLocationsExpanded);
                });

                if (_isLocationsExpanded) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _scrollToSelectedLocation();
                  });
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _verticalController.dispose();
    super.dispose();
  }

  Widget _buildLocationChips() {
    final appTheme = context.appTheme;

    if (!_isLocationsExpanded) {
      return AppFilterChipGroup<Location>(
        appFilterChipGroupController: widget.locationsAppFilterChipGroupController,
        items: _filteredLocations,
        idOf: (l) => l.id.toString(),
        labelOf: (l) => l.name,
        selectedIds: _selectedLocationId != null
            ? [_selectedLocationId.toString()]
            : [null],
        onChanged: (ids) {
          setState(() {
            final locationId = ids.first;
            if (locationId == null) {
              widget.onLocationChanged(null);
              _selectedLocationId = null;
            } else {
              _selectedLocationId = int.parse(ids.first!);
              widget.onLocationChanged(_selectedLocationId);
            }
          });
        },
      );
    } else {
      const double chipHeight = 40;
      const int maxRows = 5;

      return SizedBox(
        height: (chipHeight + appTheme.s1) * maxRows,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF3A9C95),
            borderRadius: appTheme.r2xl,
          ),
          child: Scrollbar(
            controller: _verticalController,
            thumbVisibility: true,
            child: SingleChildScrollView(
              controller: _verticalController,
              padding: EdgeInsets.all(appTheme.s1),
              child: Wrap(
                spacing: appTheme.s1,
                runSpacing: appTheme.s1,
                children: [
                  AppFilterChip(
                    key: _allKey,
                    label: 'Mind',
                    isActive: _selectedLocationId == null,
                    onTap: () => _onLocationChanged([null]),
                  ),

                  ..._filteredLocations.map((location) {
                    final id = location.id.toString();
                    _locationKeys.putIfAbsent(id, () => GlobalKey());
                    final isSelected = _selectedLocationId?.toString() == id;

                    return AppFilterChip(
                      key: _locationKeys[id],
                      label: location.name,
                      isActive: isSelected,
                      onTap: () => _onLocationChanged([id]),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  void _scrollToAll() {
    if (!_verticalController.hasClients) return;

    _verticalController.scrollToAll();
  }

  void _scrollToSelectedLocation() {
    final id = _selectedLocationId.toString();
    final key = _locationKeys[id];
    if (key == null) return;

    _verticalController.scrollToChip(key, isVertical: true);
  }

  void _onLocationChanged(List<String?> ids) {
    setState(() {
      final locationId = ids.first;
      if (locationId == null) {
        _selectedLocationId = null;
        widget.onLocationChanged(null);
      } else {
        _selectedLocationId = int.parse(locationId);
        widget.onLocationChanged(_selectedLocationId);
      }
    });
  }

  int? _getCityByLocationId() {
    if (widget.selectedLocation == null) return null;

    try {
      final city = widget.cities.firstWhere(
        (city) => city.locations.any((l) => l.id == widget.selectedLocation),
      );

      return city.cityId;
    } catch (_) {
      return null;
    }
  }
}
