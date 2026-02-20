import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:valley_of_arts/core/core.dart';
import 'package:valley_of_arts/domain/domain.dart';
import 'package:valley_of_arts/presentation/presentation.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final AppConfig _appConfig = GetIt.instance<AppConfig>();

  final LocationPanelCarouselController _locationPanelCarouselController =
      LocationPanelCarouselController();
  MapboxMap? mapboxMap;

  final Map<String, Location> poiToLocation = {};

  VillageWithLocations? _selectedVillage;
  Location? _selectedLocation;
  int _selectedLocationIndex = 0;

  List<VillageWithLocations> _villages = [];
  List<Location> _filteredLocations = [];

  PointAnnotationManager? pointManager;

  late Uint8List _imageData;

  @override
  void initState() {
    super.initState();

    MapboxOptions.setAccessToken(_appConfig.mapboxToken);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetIt.instance.get<MapBloc>()..add(const MapGetLocationsEvent()),
      child: BlocBuilder<MapBloc, MapState>(
        builder: (context, state) {
          if (state is MapVillagesLoadedState) {
            _villages = state.villages;
            _selectedVillage ??= _villages.first;
            _filteredLocations = _selectedVillage!.locations;

            return Scaffold(
              body: Stack(
                children: [
                  MapWidget(
                    cameraOptions: CameraOptions(
                      center: Point(
                        coordinates: Position(17.604607, 46.954580),
                      ),
                      zoom: 15,
                    ),
                    onMapCreated: (map) {
                      mapboxMap = map;
                    },
                    onStyleLoadedListener: _onStyleLoaded,
                    onZoomListener: _onZoom,
                  ),

                  const Positioned(
                    top: 48,
                    left: 16,
                    right: 16,
                    child: AppSearchBar(),
                  ),

                  Positioned(
                    top: 120,
                    left: 16,
                    right: 16,
                    child: AppFilterChipGroup<VillageWithLocations>(
                      selectedIds: [_villages.first.id.toString()],
                      items: _villages,
                      idOf: (c) => c.id.toString(),
                      labelOf: (c) => c.villageName,
                      showAllChip: false,
                      onChanged: (ids) {
                        final id = ids.first;
                        final selectedVillage = _villages.firstWhere(
                          (v) => v.id == int.parse(id!),
                        );

                        _onVillageTap(selectedVillage);
                      },
                    ),
                  ),

                  AnimatedPositioned(
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeOutCubic,
                    bottom: _selectedLocation == null ? -420 : 16,
                    left: 0,
                    right: 0,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: _selectedLocation == null ? 0 : 1,
                      child: LocationPanelCarousel(
                        controller: _locationPanelCarouselController,
                        locations: _filteredLocations,
                        initialIndex: _selectedLocationIndex,
                        onClose: () => setState(() => _selectedLocation = null),
                        onLocationChanged: (location) => _locationChanged(
                          location: location,
                          callFromCarousel: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return Container();
        },
      ),
    );
  }

  List<Program> programsForLocation(List<Program> all, int locationId) {
    return all.where((p) => p.locationId == locationId).toList();
  }

  Program? _nextProgramForLocation(List<Program> all, int locationId) {
    final list = all;
    if (list.isEmpty) return null;

    list.sort((a, b) {
      final dc = a.startTime.compareTo(b.startTime);
      if (dc != 0) return dc;
      return a.startTime.compareTo(b.startTime);
    });

    return list.first;
  }

  Future<void> _onStyleLoaded(StyleLoadedEventData data) async {
    if (mapboxMap == null) return;

    _imageData = (await rootBundle.load(
      'assets/tent.png',
    )).buffer.asUint8List();

    pointManager = await mapboxMap!.annotations.createPointAnnotationManager();

    pointManager!.tapEvents(
      onTap: (poi) async {
        final location = poiToLocation[poi.id];
        if (location == null) return;

        await _locationChanged(location: location);
      },
    );

    await _renderPoies();
  }

  Future<void> _locationChanged({
    required Location location,
    bool callFromCarousel = false,
  }) async {
    setState(() {
      _selectedLocation = location;
      _selectedLocationIndex = _filteredLocations.indexOf(location);

      if (!callFromCarousel) {
        _locationPanelCarouselController.scrollToLocation(_selectedLocationIndex);
      }
    });

    await mapboxMap!.easeTo(
      CameraOptions(center: Point(coordinates: location.position!), zoom: 16),
      MapAnimationOptions(duration: 1000),
    );
  }

  Future<void> _onZoom(MapContentGestureContext context) async {
    final zoom = await mapboxMap!.getCameraState().then((s) => s.zoom);
    await _setLabelsVisible(zoom >= 14);
  }

  Future<void> _setLabelsVisible(bool visible) async {
    if (pointManager == null) return;

    await pointManager!.setTextOpacity(visible ? 1.0 : 0.0);
  }

  void _onVillageTap(VillageWithLocations village) async {
    setState(() {
      _selectedVillage = village;
      _filteredLocations = village.locations;
      _selectedLocation = null;
      _selectedLocationIndex = 0;
    });

    mapboxMap?.easeTo(
      CameraOptions(center: Point(coordinates: village.position), zoom: 15),
      MapAnimationOptions(duration: 1000),
    );

    await _renderPoies();
  }

  Future<void> _renderPoies() async {
    if (mapboxMap == null) return;

    poiToLocation.clear();
    await pointManager!.deleteAll();

    for (final location in _filteredLocations) {
      if (location.position != null) {
        final options = _poiOptions(
          position: location.position!,
          imageData: _imageData,
          name: location.name,
        );

        final annotation = await pointManager!.create(options);
        poiToLocation[annotation.id] = location;
      }
    }
  }

  PointAnnotationOptions _poiOptions({
    required Position position,
    required Uint8List imageData,
    required String name,
  }) {
    final appTheme = context.appTheme;

    return PointAnnotationOptions(
      geometry: Point(coordinates: position),

      image: imageData,
      iconSize: 0.14,
      iconOffset: [0.0, -15.0],
      iconAnchor: IconAnchor.BOTTOM,

      textField: name,
      textSize: 10.0,
      textColor: appTheme.foregroundColor.toARGB32(),
      textHaloColor: appTheme.backgroundColor.toARGB32(),
      textHaloWidth: 1.0,
      textHaloBlur: 1.0,
      textOffset: [0.1, 0.0],
      textAnchor: TextAnchor.TOP,
      textMaxWidth: 8.0,
    );
  }
}
