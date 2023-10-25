import 'package:first_flutter_bloc/blocs/blocs.dart';
import 'package:first_flutter_bloc/models/models.dart';
import 'package:first_flutter_bloc/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<UsersBloc>().add(GetAllUsers());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (context, state) {
        if(state.error != '') {
          Future.delayed(Duration.zero,() {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Theme.of(context).primaryColor,
                ),
            );
          });
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Lista de usuarios'),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
              )
            ],
          ),
          body: state.loading
            ? Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),)
            : ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: state.listUsers.length,
            itemBuilder: (context, index) {
              final user = state.listUsers[index];
              return _item(context, index, user);
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () =>
                Navigator.pushNamed(context, NewUserScreen.routeName),
            child: const Icon(Icons.person_add_rounded),
          ),
        );
      },
    );
  }

  Widget _item(BuildContext context, int index, UserModel user) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => DetailUserScreen(user: user,),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 70.0,
              height: 70.0,
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(40.0),
                      image: DecorationImage(
                        image: AssetImage('assets/images/${user.gender}.png'),
                      ),
                    ),
                  ),
                  if(user.status == 'active')Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 8.0,
                      height: 8.0,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(width: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .65,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .55,
                        child: Text(
                          user.name!,
                          style: const TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        '#${_number((index + 1).toString())}',
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.white54,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .65,
                  child: Text(
                    user.email!,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.white54,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  String _number(String value) {
    if (value.length == 1) {
      return '0$value';
    }
    return value;
  }
}
