import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suitmedia_competency_test/features/selected_user/presentation/bloc/selected_user_event.dart';
import 'package:suitmedia_competency_test/features/selected_user/presentation/bloc/selected_user_state.dart';

class SelectedUserBloc extends Bloc<SelectedUserEvent, SelectedUserState> {
  SelectedUserBloc() : super(const SelectedUserState()) {
    on<SelectUserEvent>((event, emit) {
      emit(state.copyWith(selectedUser: event.user));
    });
  }
}
