import 'package:first_flutter_bloc/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

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

  @override
  void dispose() {
    _titleTextEditingController.dispose();
    _bodyTextEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo post'),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios_rounded),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 10.0),
            child: Center(
              child: GestureDetector(
                onTap: () {},
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
  }
}
