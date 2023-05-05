part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => [];
}

class GetAllPostByUser extends PostsEvent {
  final int userId;

  const GetAllPostByUser({required this.userId});
}
