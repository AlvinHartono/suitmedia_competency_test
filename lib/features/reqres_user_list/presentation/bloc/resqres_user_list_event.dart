import 'package:equatable/equatable.dart';

abstract class ReqresUserListEvent extends Equatable {
  const ReqresUserListEvent();

  @override
  List<Object?> get props => [];
}

class GetReqresUserEvent extends ReqresUserListEvent {
  final int page;
  final int perPage;

  const GetReqresUserEvent({this.page = 1, this.perPage = 10});

  @override
  List<Object?> get props => [page, perPage];
}

class RefreshReqresUserEvent extends ReqresUserListEvent {}

class LoadMoreReqresUserEvent extends ReqresUserListEvent {}
