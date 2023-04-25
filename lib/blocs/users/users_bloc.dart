import 'package:equatable/equatable.dart';
import 'package:first_flutter_bloc/models/models.dart';
import 'package:first_flutter_bloc/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  late UserRepository _userRepository;
  UsersBloc() : super(const UsersState()) {
    _userRepository = UserRepositoryImpl();

    on<UsersInit>(((event, emit) =>
        emit(state.copyWith(add: false, loading: false, error: ''))));

    on<GetAllUsers>((event, emit) async {
      try {
        emit(state.copyWith(loading: true));

        final resp = await _userRepository.getAllUsers();
        emit(state.copyWith(loading: false, listUsers: resp));
      } catch (error) {
        try {
          emit(state.copyWith(
              loading: false, error: (error as dynamic)['message']));
        } catch (err) {
          emit(state.copyWith(loading: false, error: 'Ocurrio un error'));
        }
      }
    });

    on<SaveUser>((event, emit) async {
      try {
        emit(state.copyWith(loading: true));

        await _userRepository.saveUser(event.userModel);
        emit(state.copyWith(loading: false, error: '', add: true));
      } catch (error) {
        try {
          emit(state.copyWith(
              loading: false, error: (error as dynamic)['message']));
        } catch (err) {
          emit(state.copyWith(loading: false, error: 'Ocurrio un error'));
        }
      }
    });
  }
}
