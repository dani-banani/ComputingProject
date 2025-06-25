import 'package:flutter/material.dart';

class SliderWidget extends StatefulWidget {
  final ColorScheme colorScheme;
  final int value;
  final Function(int) onChanged;
  final int min;
  final int max;
  final int divisions;
  const SliderWidget({
    super.key,
    required this.colorScheme,
    required this.value,
    required this.onChanged,
    required this.min,
    required this.max,
    required this.divisions,
  });

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: widget.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Slider(
                min: widget.min.toDouble(),
                max: widget.max.toDouble(),
                divisions: widget.divisions,
                activeColor: widget.colorScheme.primary,
                value: widget.value.toDouble(),
                label: widget.value.toString(),
                onChanged: (value) {
                  widget.onChanged(value.toInt());
                }),
          ),
          Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                widget.value.toString(),
                style: TextStyle(
                    color: widget.colorScheme.onPrimary, fontWeight: FontWeight.bold),
              )),
        ],
      ),
    );
  }
}
