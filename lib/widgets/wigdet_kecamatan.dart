import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class CustomAutocomplete<T> extends StatefulWidget {
  final List<T> data;
  final String Function(T) displayString;
  final Function(T) onSelected;
  final String labelText;
  final InputDecoration? decoration;
  final TextEditingController? controller;

  const CustomAutocomplete({
    Key? key,
    required this.data,
    required this.displayString,
    required this.onSelected,
    required this.labelText,
    this.controller,
    this.decoration,
  }) : super(key: key);

  @override
  _CustomAutocompleteState<T> createState() => _CustomAutocompleteState<T>();
}

class _CustomAutocompleteState<T> extends State<CustomAutocomplete<T>> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isValidSelection = false;
  List<T> _filteredData = [];

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = FocusNode();

    // Listener untuk menangani kehilangan fokus
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        if (!_isValidSelection || _filteredData.isEmpty) {
          _controller.clear(); // Kosongkan field jika tidak ada hasil valid
        }
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<T>(
      controller: _controller,
      focusNode: _focusNode,
      suggestionsCallback: (pattern) {
        _filteredData = widget.data
            .where((item) => widget
                .displayString(item)
                .toLowerCase()
                .contains(pattern.toLowerCase()))
            .toList();

        if (_filteredData.isEmpty) {
          _isValidSelection = false;
        }

        return _filteredData;
      },
      itemBuilder: (context, T item) {
        return ListTile(
          title: Text(widget.displayString(item)),
        );
      },
      onSelected: (T suggestion) {
        _controller.text = widget.displayString(suggestion);
        _isValidSelection = true;
        widget.onSelected(suggestion);
      },
    );
  }
}
