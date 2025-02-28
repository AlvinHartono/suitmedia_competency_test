import 'package:flutter/material.dart';
import 'package:suitmedia_competency_test/features/palindrome/presentation/widgets/action_button.dart';
import 'package:suitmedia_competency_test/features/palindrome/presentation/widgets/name_input_field.dart';
import 'package:suitmedia_competency_test/features/palindrome/presentation/widgets/palindrome_input_field.dart';

class InputFormWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController palindromeController;
  final VoidCallback onNextPressed;
  final VoidCallback onCheckPressed;

  const InputFormWidget({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.palindromeController,
    required this.onNextPressed,
    required this.onCheckPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          NameInputField(controller: nameController),
          SizedBox(height: 15.0),
          PalindromeInputField(controller: palindromeController),
          SizedBox(height: 45.0),
          ActionButton(label: 'CHECK', onPressed: onCheckPressed),
          SizedBox(height: 15.0),
          ActionButton(label: 'NEXT', onPressed: onNextPressed),
        ],
      ),
    );
  }
}
