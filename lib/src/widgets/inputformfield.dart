import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputFormField extends StatelessWidget {
  InputFormField({
    super.key,
    required this.controller,
    this.validator,
    this.maxLength,
    this.keyboardType,
    required this.hintText,
    this.labelText,
    this.helperText,
    this.suffixIcon,
    this.readOnly = false,
    this.enabled = true,
  });

  final TextEditingController controller;
  String? Function(String?)? validator;
  int? maxLength;
  String? labelText;
  final String hintText;
  TextInputType? keyboardType;
  String? helperText;
  Widget? suffixIcon;
  bool readOnly;
  bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      maxLength: maxLength,
      keyboardType: keyboardType,
      readOnly: readOnly,
      enabled: enabled,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        helperText: helperText,
        labelText: labelText,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: Colors.blue, width: 2)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.amber, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: Colors.blue, width: 1)),
      ),
    );
  }
}
