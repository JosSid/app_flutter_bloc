import 'package:first_flutter_bloc/blocs/posts/posts_bloc.dart';
import 'package:first_flutter_bloc/models/posts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListPostsWidget extends StatefulWidget {
  final int userId;

  const ListPostsWidget({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<ListPostsWidget> createState() => _ListPostsWidgetState();
}

class _ListPostsWidgetState extends State<ListPostsWidget> {
  int? _selectPost;

  @override
  void initState() {
    context.read<PostsBloc>().add(GetAllPostByUser(userId: widget.userId));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsBloc, PostsState>(
      builder: (context, state) {
        return state.loading
            ? Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor),
              )
            : Container(
                padding: const EdgeInsets.all(20.0),
                color: Colors.grey[200],
                child: _selectPost == null
                    ? state.listPosts.isEmpty
                        ? const Center(
                            child: Text('No tiene posts registrados'),
                          )
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: state.listPosts.length,
                            itemBuilder: (context, index) {
                              final post = state.listPosts[index];
                              return _item(index, post);
                            },
                          )
                    : _detailPost(state.listPosts[_selectPost!]),
              );
      },
    );
  }

  Widget _item(int index, PostModel postModel) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectPost = index;
        });
      },
      child: _detailPost(postModel),
    );
  }

  Widget _detailPost(PostModel postModel) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      margin: const EdgeInsets.only(bottom: 20.0),
      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * .7,
                child: Text(
                  postModel.title!,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Color(0xFF2e2c3f),
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              GestureDetector(
                onTap: _selectPost != null
                    ? () {
                        setState(() {
                          _selectPost = null;
                        });
                      }
                    : null,
                child: Icon(
                  _selectPost != null ? Icons.close : Icons.file_copy,
                  color: Colors.grey,
                  size: 20.0,
                ),
              )
            ],
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            height: _selectPost != null ? null : 50.0,
            child: Text(
              postModel.body!,
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
              maxLines: _selectPost != null ? null : 2,
              overflow: _selectPost != null ? null : TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
