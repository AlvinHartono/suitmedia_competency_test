import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suitmedia_competency_test/core/resources/data_state.dart';
import 'package:suitmedia_competency_test/features/reqres_user_list/domain/entity/reqres_user.dart';
import 'package:suitmedia_competency_test/features/reqres_user_list/domain/usecase/get_reqres_user_usercase.dart';
import 'package:suitmedia_competency_test/features/reqres_user_list/presentation/bloc/reqres_user_list_state.dart';
import 'package:suitmedia_competency_test/features/reqres_user_list/presentation/bloc/resqres_user_list_event.dart';

class ReqresUserBloc extends Bloc<ReqresUserListEvent, ReqresUserListState> {
  final GetReqresUserUsecase _getUserUseCase;

  // Using this to make pagination possible
  final int _perPage = 10;
  int _currentPage = 1;
  int _totalPages = 1;

  ReqresUserBloc(this._getUserUseCase) : super(ReqresUserInitial()) {
    on<GetReqresUserEvent>(_onGetUsers);
    on<RefreshReqresUserEvent>(_onRefreshUsers);
    on<LoadMoreReqresUserEvent>(_onLoadMoreUsers);
  }

  Future<void> _onGetUsers(
    GetReqresUserEvent event,
    Emitter<ReqresUserListState> emit,
  ) async {
    emit(ReqresUserLoading());

    _currentPage = event.page;

    final result = await _getUsers(_currentPage, event.perPage);
    emit(result);
  }

  Future<void> _onRefreshUsers(
    RefreshReqresUserEvent event,
    Emitter<ReqresUserListState> emit,
  ) async {
    final currentState = state;

    if (currentState is ReqresUserLoaded) {
      emit(ReqresUserRefreshing(currentState.users));
    } else {
      emit(ReqresUserLoading());
    }

    _currentPage = 1;

    final result = await _getUsers(_currentPage, _perPage);
    emit(result);
  }

  Future<void> _onLoadMoreUsers(
    LoadMoreReqresUserEvent event,
    Emitter<ReqresUserListState> emit,
  ) async {
    final currentState = state;

    if (currentState is ReqresUserLoaded) {
      if (currentState.hasReachedMax) return;

      emit(ReqresUserLoadingMore(currentState.users, currentState.currentPage));

      _currentPage = currentState.currentPage + 1;

      final DataState<List<ReqresUserEntity>> result = await _getUserUseCase
          .call(params: null);

      if (result is DataSuccess && result.data != null) {
        final newUsers = [...currentState.users, ...result.data!];

        emit(
          ReqresUserLoaded(
            users: newUsers,
            currentPage: _currentPage,
            totalPages: _totalPages,
            hasReachedMax: _currentPage >= _totalPages,
          ),
        );
      } else if (result is DataFailed) {
        emit(
          ReqresUserError(
            result.error?.message ??
                'An error occurred while loading more users',
            currentUsers: currentState.users,
          ),
        );
      }
    }
  }

  Future<ReqresUserListState> _getUsers(int page, int perPage) async {
    final DataState<List<ReqresUserEntity>> result = await _getUserUseCase.call(
      params: null,
    );

    if (result is DataSuccess && result.data != null) {
      final users = result.data!;

      if (users.isEmpty) {
        return ReqresUserEmpty();
      }
      _totalPages = 1;

      return ReqresUserLoaded(
        users: users,
        currentPage: page,
        totalPages: _totalPages,
        hasReachedMax: page >= _totalPages,
      );
    } else if (result is DataFailed) {
      return ReqresUserError(
        result.error?.message ?? 'An error occurred while fetching users',
      );
    } else {
      return const ReqresUserError('Unknown error occurred');
    }
  }
}
