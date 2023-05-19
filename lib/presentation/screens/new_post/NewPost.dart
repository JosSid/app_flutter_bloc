import 'package:first_flutter_bloc/blocs/blocs.dart';
import 'package:first_flutter_bloc/blocs/posts/posts_bloc.dart';
import 'package:first_flutter_bloc/models/posts.dart';
import 'package:first_flutter_bloc/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPostScreen extends StatefulWidget {
  static String routeName = 'new_post';

  final int? userId;

  const NewPostScreen({super.key, this.userId});

  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  final TextEditingController _titleTextEditingController =
      TextEditingController();
  final TextEditingController _bodyTextEditingController =
      TextEditingController();

  late bool _errorTitle = false;
  late bool _errorBody = false;

  void _save() {
    var band = false;

    if (validateTile(_titleTextEditingController.text)) {
      band = true;
    }

    if (validateBody(_bodyTextEditingController.text)) {
      band = true;
    }

    if (band) return;

    final postModel = PostModel(
        userId: widget.userId,
        title: _titleTextEditingController.text.trim(),
        body: _bodyTextEditingController.text.trim());

    context.read<PostsBloc>().add(SavePostByUser(postModel: postModel));
  }

  @override
  void dispose() {
    _titleTextEditingController.dispose();
    _bodyTextEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsBloc, PostsState>(
      builder: (context, state) {
        if (state.error != '') {
          Future.delayed(Duration.zero, () {
            context.read<PostsBloc>().add((PostInit()));
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
              backgroundColor: Theme.of(context).primaryColor,
            ));
          });
        }
        if (state.add) {
          Future.delayed(Duration.zero, () {
            context.read<PostsBloc>()
              ..add(GetAllPostByUser(userId: widget.userId!))
              ..add(PostInit());
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Post agregado.'),
              backgroundColor: Colors.green,
            ));
            Navigator.pop(context);
          });
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Nuevo post'),
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back_ios_rounded),
            ),
            actions: [
              state.loading
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.green))
                  : Container(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Center(
                        child: GestureDetector(
                          onTap: () => _save(),
                          child: const Text(
                            'Guardar',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextFieldWidget(
                  label: 'Titulo de post',
                  controller: _titleTextEditingController,
                  icon: Icons.title,
                  error: _errorTitle,
                ),
                TextFieldWidget(
                  label: 'Contenido',
                  controller: _bodyTextEditingController,
                  isTextArea: true,
                  error: _errorBody,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  bool validateTile(String value) {
    if (value.isEmpty || value == null) {
      setState(() {
        _errorTitle = true;
      });
      return true;
    }
    setState(() {
      _errorTitle = false;
    });
    return false;
  }

  bool validateBody(String value) {
    if (value.isEmpty || value == null) {
      setState(() {
        _errorBody = true;
      });
      return true;
    }
    setState(() {
      _errorBody = false;
    });
    return false;
  }
}
