import 'package:equatable/equatable.dart';

abstract class PalindromeEvent extends Equatable {
  const PalindromeEvent();

  @override
  List<Object> get props => [];
}

class CheckPalindromeEvent extends PalindromeEvent {
  final String text;

  const CheckPalindromeEvent(this.text);

  @override
  List<Object> get props => [];
}
