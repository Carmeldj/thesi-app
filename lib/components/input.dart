import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final TextEditingController controller;
  final String? initialValue;
  final InputDecoration? decoration;
  final int? minLines;

  const Input({
    super.key,
    required this.controller,
    this.initialValue,
    this.decoration,
    this.minLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please ';
        }
        return null;
      },
      minLines:
          minLines, // any number you need (It works as the rows for the textarea)
      keyboardType: TextInputType.multiline,
      maxLines: null,
      initialValue: initialValue,
      controller: controller,
      decoration: decoration,
    );
  }
}
