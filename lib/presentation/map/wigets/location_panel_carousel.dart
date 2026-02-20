import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:valley_of_arts/core/core.dart';
import 'package:valley_of_arts/domain/programs_filter/models/models.dart';
import 'package:valley_of_arts/presentation/map/wigets/wigets.dart';

class LocationPanelCarouselController extends ChangeNotifier {
  int? _targetIndex;

  int? get targetIndex => _targetIndex;

  void scrollToLocation(int index) {
    _targetIndex = index;
    notifyListeners();
  }

  void clear() {
    _targetIndex = null;
  }
}

class LocationPanelCarousel extends StatefulWidget {
  final List<Location> locations;
  final int initialIndex;
  final LocationPanelCarouselController controller;
  final Function(Location) onLocationChanged;
  final VoidCallback onClose;

  const LocationPanelCarousel({
    super.key,
    required this.locations,
    required this.controller,
    this.initialIndex = 0,
    required this.onLocationChanged,
    required this.onClose,
  });

  @override
  State<LocationPanelCarousel> createState() => _LocationCarouselState();
}

class _LocationCarouselState extends State<LocationPanelCarousel> {
  late PageController _controller;
  double _currentPage = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      viewportFraction: 0.6,
      initialPage: widget.initialIndex,
    );
    _currentPage = widget.initialIndex.toDouble();

    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page!;
      });
    });

    widget.controller.addListener(_handleExternalScroll);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        controller: _controller,
        itemCount: widget.locations.length,
        onPageChanged: (index) {
          if (widget.controller.targetIndex != null) return;
          widget.onLocationChanged(widget.locations[index]);
        },
        itemBuilder: (context, index) {
          final location = widget.locations[index];
          return Center(
            child: Transform.scale(
              scale: lerpDouble(
                0.7,
                1.0,
                1 - (_currentPage - index).abs().clamp(0.0, 1.0),
              ),
              child: GestureDetector(
                onTap: () => NavigationService.of(
                  context,
                ).goToLocationDetailsPage(location: location),
                child: LocationPanel(
                  location: location,
                  nextProgram: null,
                  onClose: widget.onClose,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _handleExternalScroll() async {
    final index = widget.controller.targetIndex;
    if (index == null) return;

    if (!_controller.hasClients) return;

    await _controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );

    widget.controller.clear();
  }
}
