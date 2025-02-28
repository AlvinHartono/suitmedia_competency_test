import 'package:equatable/equatable.dart';
import 'package:suitmedia_competency_test/core/domain/entities/user.dart';

abstract class SelectedUserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SelectUserEvent extends SelectedUserEvent {
  final User user;

  SelectUserEvent(this.user);

  @override
  List<Object> get props => [user];
}
