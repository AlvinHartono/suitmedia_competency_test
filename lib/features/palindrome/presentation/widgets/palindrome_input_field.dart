import 'package:flutter/material.dart';

class PalindromeInputField extends StatelessWidget {
  final TextEditingController controller;
  const PalindromeInputField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Palindrome',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a text to check';
        }
        return null;
      },
    );
  }
}
