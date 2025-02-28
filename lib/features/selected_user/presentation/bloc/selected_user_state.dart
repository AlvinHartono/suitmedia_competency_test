import 'package:equatable/equatable.dart';
import 'package:suitmedia_competency_test/core/domain/entities/user.dart';

class SelectedUserState extends Equatable {
  final User? selectedUser;

  const SelectedUserState({this.selectedUser});

  SelectedUserState copyWith({User? selectedUser}) {
    return SelectedUserState(selectedUser: selectedUser ?? this.selectedUser);
  }

  @override
  List<Object?> get props => [];
}
