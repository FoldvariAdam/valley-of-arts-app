import 'package:flutter/material.dart';
import 'package:valley_of_arts/core/core.dart';

class SingleSelectList<T> extends StatefulWidget {
  final List<T> items;
  final T selected;
  final Widget Function(T item, bool isSelected, int index, int length)
  itemBuilder;
  final ValueChanged<T> onSelected;

  const SingleSelectList({
    super.key,
    required this.items,
    required this.selected,
    required this.itemBuilder,
    required this.onSelected,
  });

  @override
  State<SingleSelectList<T>> createState() => _SingleSelectListState<T>();
}

class _SingleSelectListState<T> extends State<SingleSelectList<T>> {
  late T selectedItem;

  @override
  void initState() {
    super.initState();
    selectedItem = widget.selected;
  }

  void _onTap(T item) {
    setState(() => selectedItem = item);
    widget.onSelected(item);
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final children = <Widget>[];

    final length = widget.items.length;

    for (var i = 0; i < length; i++) {
      final item = widget.items[i];
      final isSelected = item == selectedItem;

      children.add(GestureDetector(
        onTap: () => _onTap(item),
        child: widget.itemBuilder(item, isSelected, i, length),
      ));

      if (i != length - 1) {
        children.add(Divider(
          height: 1,
          thickness: 1,
          color: appTheme.borderColor,
        ));
      }
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}
