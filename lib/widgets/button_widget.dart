import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  final ColorScheme colorScheme;
  final double width;
  final double height;
  final Widget child;
  final Function() onPressed;
  const ButtonWidget({
    super.key,
    required this.colorScheme,
    required this.onPressed,
    this.width = 300,
    this.height = 50,
    this.child = const SizedBox.shrink(),
  });

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.colorScheme.primary,
          foregroundColor: widget.colorScheme.onPrimary,
          fixedSize: Size(widget.width, widget.height),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: widget.onPressed,
        child: widget.child);
  }
}
