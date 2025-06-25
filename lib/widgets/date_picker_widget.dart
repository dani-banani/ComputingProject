import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerWidget extends StatefulWidget {
  final ColorScheme colorScheme;
  final String helpText;
  final bool isSelected;
  final DateTime selectedDate;
  final Function(BuildContext) onDateSelected;
  const DatePickerWidget({super.key, required this.colorScheme, required this.onDateSelected, required this.isSelected, required this.selectedDate, this.helpText = "Select Date"});

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          widget.onDateSelected(context);
        },
        child: Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: widget.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.isSelected
                    ? DateFormat('dd/MM/yyyy').format(widget.selectedDate)
                    : widget.helpText,
                style: TextStyle(
                    color: widget.colorScheme.onPrimaryContainer, fontSize: 16),
              ),
              Icon(Icons.calendar_month,
                  color: widget.colorScheme.onPrimaryContainer)
            ]),
        ),
      );
  }
}