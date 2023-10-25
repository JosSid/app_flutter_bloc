
import 'package:equatable/equatable.dart';
import 'package:first_flutter_bloc/models/models.dart';
import 'package:first_flutter_bloc/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  late UserRepository _userRepository;
  UsersBloc() : super(const UsersState()) {
    _userRepository = UserRepositoryImplement();

    on<UsersInit>((event, emit) => emit(state.copyWith(add: false, loading: false, error: '')));

    on<GetAllUsers>((event, emit) async {
      try{
        emit(state.copyWith(loading: true));
        
        final response = await _userRepository.getAllUsers();

        emit(state.copyWith(loading: false, listUsers: response));
      }catch(error) {
        try{
          emit(state.copyWith(loading: false, error: (error as dynamic)['mesage']));
        }catch(error) {
          emit(state.copyWith(loading: false, error: 'Unespected error'));
        }
        
      }
    });

    on<SaveUser>((event, emit) async {
      try{
        emit(state.copyWith(loading: true));
        
        final response = await _userRepository.saveUser(event.user);

        emit(state.copyWith(loading: false, add: true));
      }catch(error) {
        try{
          emit(state.copyWith(loading: false, error: (error as dynamic)['mesage']));
        }catch(error) {
          emit(state.copyWith(loading: false, error: 'Unespected error'));
        }
        
      }
    });
  }
}
