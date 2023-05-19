part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => [];
}

class PostInit extends PostsEvent {}

class GetAllPostByUser extends PostsEvent {
  final int userId;

  const GetAllPostByUser({required this.userId});
}

class SavePostByUser extends PostsEvent {
  final PostModel postModel;

  const SavePostByUser({required this.postModel});
}
