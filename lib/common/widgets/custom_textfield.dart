import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
    this.obscureText = false,
  }) : super(key: key);

  final TextEditingController controller; // Controller for managing text input
  final String hintText; // Placeholder text for the input field
  final int maxLines; // Maximum number of lines for the input
  final bool obscureText; // Whether the input is obscured (password field)

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller, // Controller to manage the input text
      maxLines: maxLines, // Maximum lines for multi-line input
      obscureText: obscureText, // Whether to obscure the input (password)
      decoration: InputDecoration(
        hintText: hintText, // Placeholder text
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter your $hintText';
        }
        return null; // Validation passed
      },
    );
  }
}
