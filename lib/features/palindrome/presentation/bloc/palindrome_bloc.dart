import 'package:suitmedia_competency_test/features/palindrome/domain/usecases/check_palindrome.dart';
import 'package:suitmedia_competency_test/features/palindrome/presentation/bloc/palindrome_event.dart';
import 'package:suitmedia_competency_test/features/palindrome/presentation/bloc/palindrome_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PalindromeBloc extends Bloc<PalindromeEvent, PalindromeState> {
  final CheckPalindromeUseCase checkPalindromeUseCase;

  PalindromeBloc({required this.checkPalindromeUseCase})
    : super(PalindromeInitial()) {
    on<CheckPalindromeEvent>(_onCheckPalindrome);
  }

  Future<void> _onCheckPalindrome(
    CheckPalindromeEvent event,
    Emitter<PalindromeState> emit,
  ) async {
    emit(PalindromeChecking());

    try {
      final isPalindrome = await checkPalindromeUseCase.call(
        params: event.text,
      );
      emit(PalindromeResult(isPalindrome: isPalindrome, text: event.text));
    } catch (e) {
      emit(PalindromeError(message: e.toString()));
    }
  }
}
