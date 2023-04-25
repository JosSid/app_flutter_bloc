import 'package:first_flutter_bloc/models/users.dart';

abstract class UserRepository {
  Future<List<UserModel>> getAllUsers();

  Future<bool> saveUser(UserModel userModel);
}
