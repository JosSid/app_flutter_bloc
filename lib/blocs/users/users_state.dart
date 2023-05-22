part of 'users_bloc.dart';

class UsersState extends Equatable {
  final bool loading;
  final String error;
  final bool add;
  final bool removed;
  final List<UserModel> listUsers;

  const UsersState({
    this.loading = false,
    this.error = '',
    this.add = false,
    this.removed = false,
    this.listUsers = const [],
  });

  UsersState copyWith({
    bool? loading,
    String? error,
    bool? add,
    bool? removed,
    List<UserModel>? listUsers,
  }) =>
      UsersState(
        loading: loading ?? this.loading,
        error: error ?? this.error,
        add: add ?? this.add,
        removed: removed ?? this.removed,
        listUsers: listUsers ?? this.listUsers,
      );

  @override
  List<Object> get props => [loading, error, add, removed, listUsers];
}
