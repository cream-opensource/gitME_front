import 'package:flutter/material.dart';

class DropdownWidget extends StatefulWidget {
  final List<String> itemList;
  final String selectedValue;
  final ValueChanged<String?> onChanged;

  DropdownWidget({
    required this.itemList,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  _DropdownWidgetState createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String?>(
      value: widget.selectedValue,
      items: widget.itemList.map((itemText) {
        return DropdownMenuItem(
          key: ValueKey<String>(itemText),
          value: itemText,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Text(
              itemText,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
        );
      }).toList(),
      onChanged: widget.onChanged,
      icon: Icon(Icons.arrow_drop_down, color: Colors.black),
      iconSize: 24,
      isExpanded: true,
      elevation: 16,
      style: TextStyle(color: Colors.black),
      underline: Container(),
    );
  }
}
