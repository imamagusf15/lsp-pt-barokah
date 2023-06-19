import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputFormField extends StatelessWidget {
  InputFormField({
    super.key,
    required this.controller,
    this.maxLength,
    required this.keyboardType,
    required this.hintText,
    this.helperText,
    this.suffixIcon,
  });

  final TextEditingController controller;
  int? maxLength;
  final String hintText;
  final TextInputType keyboardType;
  String? helperText;
  Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLength: maxLength,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        helperText: helperText,
        suffixIcon: suffixIcon,
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.amber, width: 2),
        ),
      ),
    );
  }
}
