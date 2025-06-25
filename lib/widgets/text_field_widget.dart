import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final ColorScheme colorScheme;
  final String hintText;
  final TextEditingController textController;
  final bool isTextHidden;
  final int minLines;
  final int maxLines;
  const TextFieldWidget({super.key, required this.colorScheme, required this.hintText, required this.textController, required this.isTextHidden, this.minLines = 1, this.maxLines = 1});

  @override
  State<TextFieldWidget> createState() => _TextFieldState();
}

class _TextFieldState extends State<TextFieldWidget> { 
  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: widget.colorScheme.onPrimaryContainer,
      style: TextStyle(color: widget.colorScheme.onPrimaryContainer, fontSize: 16),

      decoration: InputDecoration(
        filled: true,
        fillColor: widget.colorScheme.primaryContainer,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        labelText: widget.hintText,
        alignLabelWithHint: true,
        labelStyle: TextStyle(color: widget.colorScheme.onPrimaryContainer,fontWeight: FontWeight.bold),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 1, color: widget.colorScheme.onPrimaryContainer)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
      ),
      obscureText: widget.isTextHidden,
      controller: widget.textController,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      );
  }
}