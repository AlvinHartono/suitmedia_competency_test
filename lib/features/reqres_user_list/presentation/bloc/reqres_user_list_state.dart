import 'package:equatable/equatable.dart';
import 'package:suitmedia_competency_test/features/reqres_user_list/domain/entity/reqres_user.dart';

abstract class ReqresUserListState extends Equatable {
  const ReqresUserListState();

  @override
  List<Object?> get props => [];
}

class ReqresUserInitial extends ReqresUserListState {}

class ReqresUserLoading extends ReqresUserListState {}

class ReqresUserLoadingMore extends ReqresUserListState {
  final List<ReqresUserEntity> currentUsers;
  final int currentPage;

  const ReqresUserLoadingMore(this.currentUsers, this.currentPage);

  @override
  List<Object?> get props => [currentUsers, currentPage];
}

class ReqresUserRefreshing extends ReqresUserListState {
  final List<ReqresUserEntity> currentUsers;

  const ReqresUserRefreshing(this.currentUsers);

  @override
  List<Object?> get props => [currentUsers];
}

class ReqresUserLoaded extends ReqresUserListState {
  final List<ReqresUserEntity> users;
  final int currentPage;
  final int totalPages;
  final bool hasReachedMax;

  const ReqresUserLoaded({
    required this.users,
    required this.currentPage,
    required this.totalPages,
    required this.hasReachedMax,
  });

  @override
  List<Object?> get props => [users, currentPage, totalPages, hasReachedMax];

  ReqresUserLoaded copyWith({
    List<ReqresUserEntity>? users,
    int? currentPage,
    int? totalPages,
    bool? hasReachedMax,
  }) {
    return ReqresUserLoaded(
      users: users ?? this.users,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class ReqresUserError extends ReqresUserListState {
  final String message;
  final List<ReqresUserEntity>? currentUsers;

  const ReqresUserError(this.message, {this.currentUsers});

  @override
  List<Object?> get props => [message, currentUsers];
}

class ReqresUserEmpty extends ReqresUserListState {}
