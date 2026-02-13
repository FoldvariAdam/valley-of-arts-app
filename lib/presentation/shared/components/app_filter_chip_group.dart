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

  @override
  void initState() {
    super.initState();
    _selectedIds = widget.selectedIds ?? [null];
  }

  @override
  void didUpdateWidget(covariant AppFilterChipGroup<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIds != null && widget.selectedIds != _selectedIds) {
      _selectedIds = widget.selectedIds!;
    }
  }

  void _tapMind() {
    setState(() {
      _selectedIds = [null];
    });
    widget.onChanged([null]);
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
          _selectedIds = [null];
        }
      } else {
        _selectedIds = [id];
      }
    });

    widget.onChanged(_selectedIds);
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: appTheme.s1),
        itemCount: widget.items.length + 1,
        separatorBuilder: (_, __) => SizedBox(width: appTheme.s1),
        itemBuilder: (context, index) {
          if (index == 0) {
            return AppFilterChip(
              label: 'Mind',
              isActive: _selectedIds.contains(null),
              onTap: _tapMind,
            );
          }

          final item = widget.items[index - 1];
          final id = widget.idOf(item);
          final label = widget.labelOf(item);

          return AppFilterChip(
            label: label,
            isActive: _selectedIds.contains(id),
            onTap: () => _tapItem(item),
          );
        },
      ),
    );

  }
}
