part of 'posts_bloc.dart';

class PostsState extends Equatable {
  final bool loading;
  final List<PostModel> listPosts;
  final String error;
  final bool add;

  const PostsState({
    this.loading = false,
    this.listPosts = const [],
    this.error = '',
    this.add = false,
  });

  PostsState copyWith({
    bool? loading,
    List<PostModel>? listPosts,
    String? error,
    bool? add,
  }) =>
      PostsState(
        loading: loading ?? this.loading,
        listPosts: listPosts ?? this.listPosts,
        error: error ?? this.error,
        add: add ?? this.add,
      );

  @override
  List<Object> get props => [loading, listPosts, error, add];
}
