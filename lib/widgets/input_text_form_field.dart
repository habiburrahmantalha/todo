import 'package:flutter/material.dart';

class InputTextFormField extends TextFormField {
  InputTextFormField({
    super.key,
    String? labelText,
    String? hintText,
    super.controller,
    super.validator,
    super.keyboardType,
    super.obscureText,
    super.initialValue,
    super.readOnly,
    super.textInputAction,
    super.onChanged,
    super.focusNode,
    super.onTap
  }) : super(
    decoration: InputDecoration(
      labelText: labelText,
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}

