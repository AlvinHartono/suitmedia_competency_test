import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suitmedia_competency_test/features/reqres_user_list/domain/entity/reqres_user.dart';
import 'package:suitmedia_competency_test/features/reqres_user_list/presentation/bloc/reqres_user_list_bloc.dart';
import 'package:suitmedia_competency_test/features/reqres_user_list/presentation/bloc/reqres_user_list_state.dart';
import 'package:suitmedia_competency_test/features/reqres_user_list/presentation/bloc/resqres_user_list_event.dart';
import 'package:suitmedia_competency_test/features/reqres_user_list/presentation/widgets/empty_state_widget.dart';
import 'package:suitmedia_competency_test/features/reqres_user_list/presentation/widgets/error_state_widget.dart';
import 'package:suitmedia_competency_test/features/reqres_user_list/presentation/widgets/user_list_item.dart';

class ThirdScreenPage extends StatefulWidget {
  final Function(ReqresUserEntity) onUserSelected;

  const ThirdScreenPage({super.key, required this.onUserSelected});

  @override
  State<ThirdScreenPage> createState() => _ThirdScreenPageState();
}

class _ThirdScreenPageState extends State<ThirdScreenPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<ReqresUserBloc>().add(LoadMoreReqresUserEvent());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  _buildAppBar() {
    return AppBar(
      title: const Text(
        "Third Screen",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    );
  }

  _buildBody() {
    return BlocBuilder<ReqresUserBloc, ReqresUserListState>(
      builder: (context, state) {
        if (state is ReqresUserInitial || state is ReqresUserLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ReqresUserLoaded) {
          return _buildUserList(context, state.users, state.hasReachedMax);
        } else if (state is ReqresUserLoadingMore) {
          return _buildUserList(
            context,
            state.currentUsers,
            false,
            isLoadingMore: true,
          );
        } else if (state is ReqresUserRefreshing) {
          return _buildUserList(
            context,
            state.currentUsers,
            false,
            isRefreshing: true,
          );
        } else if (state is ReqresUserError && state.currentUsers != null) {
          return _buildUserList(
            context,
            state.currentUsers!,
            true,
            errorMessage: state.message,
          );
        } else if (state is ReqresUserError) {
          return ErrorStateWidget(
            message: state.message,
            onRetry:
                () => context.read<ReqresUserBloc>().add(
                  const GetReqresUserEvent(),
                ),
          );
        } else if (state is ReqresUserEmpty) {
          return const EmptyStateWidget();
        }

        // Default empty view
        return const EmptyStateWidget();
      },
    );
  }

  Widget _buildUserList(
    BuildContext context,
    List<ReqresUserEntity> users,
    bool hasReachedMax, {
    bool isLoadingMore = false,
    bool isRefreshing = false,
    String? errorMessage,
  }) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<ReqresUserBloc>().add(RefreshReqresUserEvent());
      },
      child: Column(
        children: [
          if (errorMessage != null)
            Container(
              color: Colors.red[100],
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              child: Text(
                errorMessage,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount:
                  users.length + (isLoadingMore || !hasReachedMax ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= users.length) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                return UserListItem(
                  user: users[index],
                  onTap: () {
                    widget.onUserSelected(users[index]);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
