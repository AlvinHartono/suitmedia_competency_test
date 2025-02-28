import 'package:equatable/equatable.dart';

abstract class PalindromeState extends Equatable {
  @override
  List<Object> get props => [];
}

class PalindromeInitial extends PalindromeState {}

class PalindromeChecking extends PalindromeState {}

class PalindromeResult extends PalindromeState {
  final bool isPalindrome;
  final String text;

  PalindromeResult({required this.isPalindrome, required this.text});
}

class PalindromeError extends PalindromeState {
  final String message;

  PalindromeError({required this.message});

  @override
  List<Object> get props => [message];
}
