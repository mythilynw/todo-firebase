

import 'package:flutter/material.dart';

class CustomTextFormField
    extends StatelessWidget {

  final TextEditingController
      controller;

  final String label;

  final bool obscureText;

  final String? Function(String?)?
      validator;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.label,
    this.obscureText = false,
    this.validator,
  });

  @override
  Widget build(
    BuildContext context,
  ) {

    return TextFormField(

      controller: controller,

      obscureText: obscureText,

      validator: validator,

      decoration: InputDecoration(

        labelText: label,

        filled: true,

        fillColor: Colors.white,

        contentPadding:
            const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),

        border:
            OutlineInputBorder(

          borderRadius:
              BorderRadius.circular(
            14,
          ),
        ),

        enabledBorder:
            OutlineInputBorder(

          borderRadius:
              BorderRadius.circular(
            14,
          ),

          borderSide:
              const BorderSide(
            color: Colors.grey,
          ),
        ),

        focusedBorder:
            OutlineInputBorder(

          borderRadius:
              BorderRadius.circular(
            14,
          ),

          borderSide:
              const BorderSide(
            color: Colors.blue,
            width: 2,
          ),
        ),
      ),
    );
  }
}