import 'dart:io';

import 'package:flutter/material.dart';

class CustomFormField extends FormField<String> {
  CustomFormField({
    FormFieldValidator<String>? validator,

  }) : super(
    validator: validator,
    builder: (FormFieldState<String> field) {
      final errorText = field.errorText;
      return Text(
        errorText ?? '',
        style: TextStyle(
          color: Colors.red,
        ),
      );
    },
  );
}