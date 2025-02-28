import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:suitmedia_competency_test/core/domain/entities/user.dart';
import 'package:suitmedia_competency_test/features/palindrome/presentation/bloc/palindrome_bloc.dart';
import 'package:suitmedia_competency_test/features/palindrome/presentation/bloc/palindrome_event.dart';
import 'package:suitmedia_competency_test/features/palindrome/presentation/bloc/palindrome_state.dart';
import 'package:suitmedia_competency_test/features/palindrome/presentation/widgets/input_form_widget.dart';

class FirstScreenPage extends HookWidget {
  const FirstScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Controllers
    final nameController = useTextEditingController();
    final palindromeController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());

    // Define the functions within build() so they have access to context and controllers
    void onCheckPressed() {
      if (formKey.currentState?.validate() ?? false) {
        context.read<PalindromeBloc>().add(
          CheckPalindromeEvent(palindromeController.text),
        );
      }
    }

    void onNextPressed() {
      if (formKey.currentState?.validate() ?? false) {
        Navigator.pushNamed(
          context,
          '/second-screen',
          arguments: {'user': User(name: nameController.text)},
        );
      }
    }

    return BlocListener<PalindromeBloc, PalindromeState>(
      listener: (context, state) {
        if (state is PalindromeResult) {
          // show dialog
          _showResultDialog(context, state.isPalindrome);
        } else if (state is PalindromeError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background_1.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 116,
                  height: 116,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/ic_photo.png'),
                    ),
                  ),
                ),
                const SizedBox(height: 51.0),
                InputFormWidget(
                  formKey: formKey,
                  nameController: nameController,
                  palindromeController: palindromeController,
                  onNextPressed: onNextPressed,
                  onCheckPressed: onCheckPressed,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showResultDialog(BuildContext context, bool isPalindrome) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Result"),
            content: Text(isPalindrome ? 'isPalindrome' : 'not palindrome'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }
}
