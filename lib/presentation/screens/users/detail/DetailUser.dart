import 'package:first_flutter_bloc/models/models.dart';
import 'package:first_flutter_bloc/presentation/screens/users/detail/widgets/image_status.dart';
import 'package:first_flutter_bloc/presentation/screens/users/detail/widgets/info.dart';
import 'package:flutter/material.dart';

class DetailUserScreen extends StatelessWidget {
  final UserModel user;
  
  const DetailUserScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2e2c3f).withOpacity(.5),
      body: Container(
        color: const Color(0xFF2e2c3f).withOpacity(.5),
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    margin: const EdgeInsets.all(20.0),
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    child: const Center(child: Icon(Icons.close)),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      InfoWidget(user: user),
                      ImageStatusWidget(user: user,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
