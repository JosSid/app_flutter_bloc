import 'package:first_flutter_bloc/blocs/users/users_bloc.dart';
import 'package:first_flutter_bloc/models/users.dart';
import 'package:first_flutter_bloc/presentation/screens/screens.dart';
import 'package:first_flutter_bloc/presentation/screens/users/detail/widgets/list_posts.dart';
import 'package:first_flutter_bloc/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InfoWidget extends StatelessWidget {
  final UserModel userModel;

  const InfoWidget({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (context, state) {
        if (state.error != '') {
          Future.delayed(Duration.zero, () {
            context.read<UsersBloc>().add(UsersInit());
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
              backgroundColor: Theme.of(context).primaryColor,
            ));
          });
        }
        if (state.removed) {
          Future.delayed(Duration.zero, () {
            context.read<UsersBloc>()
              ..add(UsersInit())
              ..add(GetAllUsers());
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Usuario eliminado con éxito!!!'),
              backgroundColor: Colors.green,
            ));
            Navigator.pop(context);
          });
        }
        return Container(
          margin: const EdgeInsets.only(top: 40.0),
          padding: const EdgeInsets.only(top: 80.0),
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0),
            ),
          ),
          child: Column(
            children: [
              Text(
                userModel.name!,
                style: const TextStyle(
                  fontSize: 30.0,
                  color: Color(0xFF2e2c3f),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                userModel.email!,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10.0),
              state.loading
                  ? Center(
                      child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  NewPostScreen(userId: userModel.id!),
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            width: 200,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: const Center(
                              child: Text(
                                'Agregar post',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  const DeleteWidget(),
                            ).then((value) {
                              if (value == true) {
                                context
                                    .read<UsersBloc>()
                                    .add(RemoveUser(userId: userModel.id!));
                              }
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            width: 50,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.4)),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.delete_outline_rounded,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
              const SizedBox(height: 10.0),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: Theme.of(context).primaryColor, width: 4),
                    ),
                  ),
                  child: const Text(
                    'Lista de posts',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xFF2e2c3f),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListPostsWidget(userId: userModel.id!),
              )
            ],
          ),
        );
      },
    );
  }
}
