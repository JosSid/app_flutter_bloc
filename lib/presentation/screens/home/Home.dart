import 'package:first_flutter_bloc/presentation/screens/screens.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 6,
        itemBuilder: (context, index) {
          return _item(context, index);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, NewUserScreen.routeName),
        child: const Icon(Icons.person_add_rounded),
      ),
    );
  }

  Widget _item(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => const DetailUserScreen(),
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
                      image: const DecorationImage(
                        image: AssetImage('assets/images/female.png'),
                      ),
                    ),
                  ),
                  Positioned(
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
                        child: const Text(
                          'Nombre de usuario',
                          style: TextStyle(
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
                  child: const Text(
                    'correo@correo.com',
                    style: TextStyle(
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
