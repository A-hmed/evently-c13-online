import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData? iconData;
  final int minLines;

  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hint,
      this.iconData,
      this.minLines = 1});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.bodyLarge,
      cursorColor: Theme.of(context).primaryColor,
      controller: controller,
      minLines: minLines,
      maxLines: 6,
      decoration: InputDecoration(
          prefixIcon: iconData == null ? null : Icon(iconData),
          hintMaxLines: minLines,
          hintText: hint),
    );
  }
}
