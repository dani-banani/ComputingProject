import 'package:flutter/material.dart';

class DropdownWidget extends StatefulWidget {
  final ColorScheme colorScheme;
  final String hintText;
  final String value;
  final List<String> dropdownItems; 
  final Function(String) onChanged;
  const DropdownWidget({super.key, required this.colorScheme, required this.hintText, required this.value, required this.dropdownItems, required this.onChanged});

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: widget.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(10),
        ),
        child: DropdownButton<String>(
            isExpanded: true,
            hint: Text(
                widget.value.isEmpty
                    ? widget.hintText
                    : widget.value,
                style: TextStyle(
                    color: widget.colorScheme.onPrimaryContainer, fontSize: 16)),
            icon: Icon(Icons.arrow_drop_down,
                color: widget.colorScheme.onPrimaryContainer),
            dropdownColor: widget.colorScheme.primaryContainer,
            style: TextStyle(color: widget.colorScheme.onPrimaryContainer),
            borderRadius: BorderRadius.circular(25),
            items: widget.dropdownItems.map((item) {
              return DropdownMenuItem(value: item, child: Text(item));
            }).toList(),
            onChanged: (selection) {
              if (selection == null) return;
              widget.onChanged(selection);
            }),
      );
  }
}