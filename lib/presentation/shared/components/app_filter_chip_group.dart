import 'package:flutter/material.dart';
import 'package:valley_of_arts/core/core.dart';
import 'package:valley_of_arts/presentation/shared/components/app_filter_chip.dart';

class AppFilterChipGroupController extends ChangeNotifier {
  bool _scrollToAllRequested = false;

  bool get scrollToAllRequested => _scrollToAllRequested;

  void scrollToAll() {
    _scrollToAllRequested = true;
    notifyListeners();
  }

  void clearScrollToAllFlag() {
    _scrollToAllRequested = false;
  }
}

class AppFilterChipGroup<T> extends StatefulWidget {
  final List<T> items;
  final bool multi;
  final List<String?>? selectedIds;
  final String Function(T item) idOf;
  final String Function(T item) labelOf;
  final ValueChanged<List<String?>> onChanged;
  final AppFilterChipGroupController? appFilterChipGroupController;
  final bool showAllChip;

  const AppFilterChipGroup({
    super.key,
    required this.items,
    required this.idOf,
    required this.labelOf,
    required this.onChanged,
    this.multi = false,
    this.selectedIds,
    this.appFilterChipGroupController,
    this.showAllChip = true,
  });

  @override
  State<AppFilterChipGroup<T>> createState() => _AppFilterChipGroupState<T>();
}

class _AppFilterChipGroupState<T> extends State<AppFilterChipGroup<T>> {
  static const String all = 'all';

  late List<String?> _selectedIds;
  late final ScrollController _scrollController;

  final Map<String, GlobalKey> _chipKeys = {};

  late int _itemCount;
  late bool _showAllChip;

  @override
  void initState() {
    super.initState();
    _showAllChip = widget.showAllChip;

    final itemsLength = widget.items.length;
    _itemCount = _showAllChip ? itemsLength + 1 : itemsLength;

    _selectedIds = widget.selectedIds ?? <String?>[null];
    _scrollController = ScrollController();

    widget.appFilterChipGroupController?.addListener(_handleController);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelected();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    widget.appFilterChipGroupController?.removeListener(_handleController);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return SizedBox(
      height: 40,
      child: ListView.separated(
        clipBehavior: Clip.none,
        padding: EdgeInsets.zero,
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        cacheExtent: widget.items.length * 160,
        itemCount: _itemCount,
        separatorBuilder: (_, _) => SizedBox(width: appTheme.s1),
        itemBuilder: (context, index) {
          String id;
          Widget chip;

          if (index == 0 && _showAllChip) {
            id = all;
            _chipKeys.putIfAbsent(id, () => GlobalKey());
            chip = AppFilterChip(
              key: _chipKeys[id],
              label: 'Mind',
              isActive: _selectedIds.contains(null),
              onTap: _scrollToAll,
            );
          } else {
            final itemIndex = _showAllChip ? index - 1 : index;
            final item = widget.items[itemIndex];
            id = widget.idOf(item);
            _chipKeys.putIfAbsent(id, () => GlobalKey());
            chip = AppFilterChip(
              key: _chipKeys[id],
              label: widget.labelOf(item),
              isActive: _selectedIds.contains(id),
              onTap: () => _tapItem(item),
            );
          }

          return chip;
        },
      ),
    );
  }

  void _handleController() {
    if (widget.appFilterChipGroupController?.scrollToAllRequested == true) {
      _scrollToAll();
      widget.appFilterChipGroupController?.clearScrollToAllFlag();
    }
  }

  void _scrollToAll() {
    setState(() {
      _selectedIds = <String?>[null];
    });

    widget.onChanged([null]);

    _scrollController.scrollToAll();
  }

  void _scrollToSelected() {
    if (_selectedIds.isEmpty || !_scrollController.hasClients) return;

    final selectedId = _selectedIds.firstWhere(
      (id) => id != null,
      orElse: () => all,
    );

    _scrollController.scrollToChip(_chipKeys[selectedId]!);
  }

  void _tapItem(T item) {
    final id = widget.idOf(item);

    setState(() {
      if (widget.multi) {
        final current = _selectedIds.whereType<String>().toSet();

        if (current.contains(id)) {
          current.remove(id);
        } else {
          current.add(id);
        }

        _selectedIds = current.isEmpty ? <String?>[null] : current.toList();
      } else {
        _selectedIds = <String?>[id];
      }
    });

    widget.onChanged(_selectedIds);

    _scrollController.scrollToChip(_chipKeys[id]!);
  }
}
