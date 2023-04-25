part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

class UsersInit extends UsersEvent {}

class GetAllUsers extends UsersEvent {}

class SaveUser extends UsersEvent {
  final UserModel userModel;

  const SaveUser({required this.userModel});
}
