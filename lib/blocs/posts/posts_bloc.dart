import 'package:equatable/equatable.dart';
import 'package:first_flutter_bloc/models/models.dart';
import 'package:first_flutter_bloc/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  late PostRepository _postRepository;
  PostsBloc() : super(const PostsState()) {
    _postRepository = PostRepositoryImpl();

    on<PostInit>(
        ((event, emit) => emit(state.copyWith(loading: false, add: false))));

    on<GetAllPostByUser>((event, emit) async {
      try {
        emit(state.copyWith(loading: true));
        var resp = await _postRepository.getAllPostsByUser(event.userId);
        emit(state.copyWith(loading: false, error: '', listPosts: resp));
      } catch (e) {
        try {
          emit(
              state.copyWith(loading: false, error: (e as dynamic)['message']));
        } catch (error) {
          emit(state.copyWith(loading: false, error: 'Ocurrio un error'));
        }
      }
    });

    on<SavePostByUser>((event, emit) async {
      try {
        emit(state.copyWith(loading: true));
        await _postRepository.savePostByUser(event.postModel);
        emit(state.copyWith(loading: false, error: '', add: true));
      } catch (e) {
        try {
          emit(
              state.copyWith(loading: false, error: (e as dynamic)['message']));
        } catch (error) {
          emit(state.copyWith(loading: false, error: 'Ocurrio un error'));
        }
      }
    });
  }
}
