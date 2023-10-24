import 'package:first_flutter_bloc/models/models.dart';

abstract class UserRepository {
  Future<List<UserModel>> getAllUsers();
}