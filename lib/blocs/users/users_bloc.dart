import 'package:equatable/equatable.dart';
import 'package:first_flutter_bloc/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(const UsersState()) {
    on<GetAllUsers>((event, emit) async {
      try {
        emit(state.copyWith(loading: true));

        ///TO DO
        final resp = //CONSULTAR LA API;
            emit(state.copyWith(
          loading: false, /*listUsers: resp*/
        ));
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
