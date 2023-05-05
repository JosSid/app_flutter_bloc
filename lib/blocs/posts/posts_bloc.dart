import 'package:equatable/equatable.dart';
import 'package:first_flutter_bloc/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(const PostsState()) {
    on<GetAllPostByUser>((event, emit) {
      // TODO: implement event handler
    });
  }
}
