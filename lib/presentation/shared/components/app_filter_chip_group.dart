import 'package:flutter/material.dart';
import 'package:valley_of_arts/core/core.dart';
import 'package:valley_of_arts/presentation/shared/components/app_filter_chip.dart';

class AppFilterChipGroup<T> extends StatefulWidget {
  final List<T> items;
  final bool multi;
  final List<String?>? selectedIds;
  final String Function(T item) idOf;
  final String Function(T item) labelOf;
  final ValueChanged<List<String?>> onChanged;

  const AppFilterChipGroup({
    super.key,
    required this.items,
    required this.idOf,
    required this.labelOf,
    required this.onChanged,
    this.multi = false,
    this.selectedIds,
  });

  @override
  State<AppFilterChipGroup<T>> createState() => _AppFilterChipGroupState<T>();
}

class _AppFilterChipGroupState<T> extends State<AppFilterChipGroup<T>> {
  late List<String?> _selectedIds;
  late final ScrollController _controller;
  
  final Map<String, GlobalKey> _chipKeys = {};

  @override
  void initState() {
    super.initState();
    _selectedIds = widget.selectedIds ?? <String?>[null];
    _controller = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelected();
    });
  }

  @override
  void didUpdateWidget(covariant AppFilterChipGroup<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIds != null && widget.selectedIds != _selectedIds) {
      _selectedIds = widget.selectedIds!;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToSelected();
      });
    }
  }

  void _scrollToSelected() {
    if (_selectedIds.isEmpty || !_controller.hasClients) return;

    final selectedId = _selectedIds.firstWhere((id) => id != null, orElse: () => 'mind');
    final key = _chipKeys[selectedId];
    if (key == null) return;

    final context = key.currentContext;
    if (context == null) return;

    final box = context.findRenderObject() as RenderBox?;
    final listBox = _controller.position.context.storageContext.findRenderObject() as RenderBox?;
    if (box == null || listBox == null) return;

    final offset = box.localToGlobal(Offset.zero, ancestor: listBox).dx;

    final targetOffset = _controller.offset + offset - (_controller.position.viewportDimension / 2) + (box.size.width / 2);

    _controller.animateTo(
      targetOffset.clamp(0.0, _controller.position.maxScrollExtent),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }


  void _tapMind() {
    setState(() {
      _selectedIds = <String?>[null];
    });
    widget.onChanged([null]);
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToSelected());
  }

  void _tapItem(T item) {
    final id = widget.idOf(item);

    setState(() {
      _selectedIds.removeWhere((element) => element == null);

      if (widget.multi) {
        if (_selectedIds.contains(id)) {
          _selectedIds.remove(id);
        } else {
          _selectedIds.add(id);
        }

        if (_selectedIds.isEmpty) {
          _selectedIds = <String?>[null];
        }
      } else {
        _selectedIds = <String?>[id];
      }
    });

    widget.onChanged(_selectedIds);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToChip(id);
    });
  }

  void _scrollToChip(String id) {
    final key = _chipKeys[id];
    if (key == null) return;

    final context = key.currentContext;
    if (context == null) return;

    final box = context.findRenderObject() as RenderBox?;
    if (box == null) return;

    final scrollBox = _controller.position.context.storageContext.findRenderObject() as RenderBox;
    final position = box.localToGlobal(Offset.zero, ancestor: scrollBox).dx;

    _controller.animateTo(
      _controller.offset + position - 16,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return SizedBox(
      height: 40,
      child: ListView.separated(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: appTheme.s1),
        itemCount: widget.items.length + 1,
        separatorBuilder: (_, __) => SizedBox(width: appTheme.s1),
        itemBuilder: (context, index) {
          String id;
          Widget chip;

          if (index == 0) {
            id = 'mind';
            _chipKeys[id] = GlobalKey();
            chip = AppFilterChip(
              key: _chipKeys[id],
              label: 'Mind',
              isActive: _selectedIds.contains(null),
              onTap: _tapMind,
            );
          } else {
            final item = widget.items[index - 1];
            id = widget.idOf(item);
            _chipKeys[id] = GlobalKey();

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
}
