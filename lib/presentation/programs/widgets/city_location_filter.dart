import 'package:flutter/material.dart';
import 'package:valley_of_arts/core/core.dart';
import 'package:valley_of_arts/domain/programs_filter/models/models.dart';
import 'package:valley_of_arts/presentation/shared/components/components.dart';

class CityLocationFilter extends StatefulWidget {
  final int? selectedLocation;
  final List<CityWithLocations> cities;
  final ValueChanged<int?> onLocationChanged;

  const CityLocationFilter({
    super.key,
    required this.cities,
    required this.onLocationChanged,
    this.selectedLocation,
  });

  @override
  State<CityLocationFilter> createState() => _CityLocationFilterState();
}

class _CityLocationFilterState extends State<CityLocationFilter> {
  int? _selectedCityId;
  int? _selectedLocationId;

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
    final asd = null.toString();
    _selectedCityId = _getCityByLocationId();
    _selectedLocationId = widget.selectedLocation;
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

        AppFilterChipGroup<Location>(
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
        ),
      ],
    );
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
