part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => [];
}

class GetAllPostsByUser extends PostsEvent {
  final int userId;

  const GetAllPostsByUser({required this.userId});


}
