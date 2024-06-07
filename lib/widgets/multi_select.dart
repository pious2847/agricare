import 'package:flutter/material.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class CustomMultiSelect extends StatefulWidget {
  final List<MultiSelectItem<String>> items;
  final List<String> initialValue;
  final Function(List<String>) onSelectionChanged;

  CustomMultiSelect({
    required this.items,
    required this.initialValue,
    required this.onSelectionChanged,
  });

  @override
  _CustomMultiSelectState createState() => _CustomMultiSelectState();
}

class _CustomMultiSelectState extends State<CustomMultiSelect> {
  late List<String> _selectedValues;

  @override
  void initState() {
    super.initState();
    _selectedValues = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.items.map((item) {
        return CheckboxListTile(
          title: Text(item.label),
          value: _selectedValues.contains(item.value),
          onChanged: (bool? checked) {
            setState(() {
              if (checked == true) {
                _selectedValues.add(item.value);
              } else {
                _selectedValues.remove(item.value);
              }
              widget.onSelectionChanged(_selectedValues);
            });
          },
        );
      }).toList(),
    );
  }
}
