import 'package:first_flutter_bloc/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:first_flutter_bloc/presentation/screens/screens.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UsersBloc>(create: (_) => UsersBloc()),
        BlocProvider<PostsBloc>(create: (_) => PostsBloc()),
      ],
      child: MaterialApp(
        title: 'App Flutter BLOC',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xFFf32968),
          scaffoldBackgroundColor: const Color(0xFF2e2c3f),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xFFf32968),
          ),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: Color(0xFF2e2c3f),
          ),
        ),
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName: (_) => const HomeScreen(),
          NewUserScreen.routeName: (_) => const NewUserScreen(),
          NewPostScreen.routeName: (_) => const NewPostScreen(),
        },
      ),
    );
  }
}
